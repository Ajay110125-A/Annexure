CLASS lhc_ZI_ANNEXURE_MASTER_AJ DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_annexure_master_aj RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zi_annexure_master_aj.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zi_annexure_master_aj.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zi_annexure_master_aj.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_annexure_master_aj RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zi_annexure_master_aj.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_annexure_master_aj RESULT result.

    METHODS accept FOR MODIFY
      IMPORTING keys FOR ACTION zi_annexure_master_aj~accept RESULT result.

ENDCLASS.

CLASS lhc_ZI_ANNEXURE_MASTER_AJ IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.

    DATA : l_failed TYPE c.

    IF zcl_aj_annexure_bp=>lo_m IS NOT BOUND.
      zcl_aj_annexure_bp=>lo_m = NEW #(  ).
*      FIELD-SYMBOLS(<fs_create>) = zcl_aj_annexure_bp=>lo_m.
    ENDIF.

    DATA : li_master TYPE  zcl_aj_annexure_bp=>lo_m->t_master_t.

    SELECT *
       FROM zaj_anx_category
       INTO TABLE @DATA(li_cate).

    SELECT *
       FROM zaj_anx_type
       INTO TABLE @DATA(li_type).

    SELECT *
       FROM zaj_anx_status
       INTO TABLE @DATA(li_status).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).

      IF NOT line_exists( li_cate[ user_id = cl_abap_context_info=>get_user_technical_name( ) category = <fs_entity>-%data-Category ] ).

        failed-zi_annexure_master_aj = VALUE #( BASE failed-zi_annexure_master_aj ( %cid = <fs_entity>-%cid ) ).
        reported-zi_annexure_master_aj = VALUE #( BASE reported-zi_annexure_master_aj
                                                  ( %cid = <fs_entity>-%cid %element-category = if_abap_behv=>mk-on
                                                    %msg =  new_message(
                                                              id       = 'ZAJ_MESS_ANNEXURE'
                                                              number   = 001
                                                              severity = if_abap_behv_message=>severity-error
                                                              v1       = <fs_entity>-%data-Category
                                                            )
                                                  )
                                                ).
        l_failed = abap_true.

      ENDIF.

      IF NOT line_exists( li_type[ type = <fs_entity>-%data-Type ] ).

        failed-zi_annexure_master_aj = VALUE #( BASE failed-zi_annexure_master_aj ( %cid = <fs_entity>-%cid ) ).
        reported-zi_annexure_master_aj = VALUE #( BASE reported-zi_annexure_master_aj
                                                  (
                                                    %cid = <fs_entity>-%cid %element-type = if_abap_behv=>mk-on
                                                    %msg =  new_message(
                                                              id       = 'ZAJ_MESS_ANNEXURE'
                                                              number   = 002
                                                              severity = if_abap_behv_message=>severity-error
                                                              v1       = <fs_entity>-%data-Type
                                                            )
                                                  )
                                                ).
        l_failed = abap_true.

      ENDIF.

      IF NOT line_exists( li_status[ status = <fs_entity>-%data-Status ] ).

        failed-zi_annexure_master_aj = VALUE #( BASE failed-zi_annexure_master_aj ( %cid = <fs_entity>-%cid ) ).
        reported-zi_annexure_master_aj = VALUE #( BASE reported-zi_annexure_master_aj
                                                  (
                                                    %cid = <fs_entity>-%cid %element-status = if_abap_behv=>mk-on
                                                    %msg =  new_message(
                                                              id       = 'ZAJ_MESS_ANNEXURE'
                                                              number   = 003
                                                              severity = if_abap_behv_message=>severity-error
                                                              v1       = <fs_entity>-%data-Type
                                                            )
                                                  )
                                                ).
        l_failed = abap_true.

      ENDIF.

      IF <fs_entity>-ItemsCount NOT BETWEEN 1 AND 10.

        failed-zi_annexure_master_aj = VALUE #( BASE failed-zi_annexure_master_aj ( %cid = <fs_entity>-%cid ) ).
        reported-zi_annexure_master_aj = VALUE #( BASE reported-zi_annexure_master_aj
                                                  (
                                                    %cid = <fs_entity>-%cid %element-itemscount = if_abap_behv=>mk-on
                                                    %msg =  new_message(
                                                              id       = 'ZAJ_MESS_ANNEXURE'
                                                              number   = 004
                                                              severity = if_abap_behv_message=>severity-error
                                                            )
                                                  )
                                                ).
        l_failed = abap_true.

      ENDIF.

      IF l_failed = abap_false.
        mapped-zi_annexure_master_aj = VALUE #( BASE mapped-zi_annexure_master_aj ( %cid =  <fs_entity>-%cid ) ).

        li_master = VALUE #(
                             BASE li_master
                             (
                               cid = <fs_entity>-%cid
                               annexurename = <fs_entity>-%data-AnnexureName
                               category     = <fs_entity>-%data-Category
                               type         = <fs_entity>-%data-Type
                               itemscount   = <fs_entity>-%data-ItemsCount
                               status       = <fs_entity>-%data-Status
                             )
                           ).
      ENDIF.
    ENDLOOP.

    IF l_failed = abap_false.
      zcl_aj_annexure_bp=>l_type = 'C'.
      zcl_aj_annexure_bp=>lo_m->create_annexure( i_master = li_master ).

    ENDIF.

  ENDMETHOD.

  METHOD update.

    DATA : li_master TYPE TABLE OF zaj_annex_master.

    DATA(lo_annex) = zcl_aj_annexure_bp=>get_instance( ).

    DATA : li_master_3 TYPE zcl_aj_annexure_bp=>t_master_t.

    SELECT *
        FROM zaj_annex_master
        FOR ALL ENTRIES IN @entities
        WHERE annexure_id = @entities-%key-AnnexureId
        INTO TABLE @li_master.


    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).

      READ TABLE li_master ASSIGNING FIELD-SYMBOL(<fs_master>) WITH KEY annexure_id = <fs_entity>-%key-AnnexureId.

      IF <fs_entity>-%control-Category = if_abap_behv=>fc-o-disabled.
        <fs_master>-category = <fs_entity>-%data-Category.
      ENDIF.

      IF <fs_entity>-%control-Status = if_abap_behv=>fc-o-disabled.
        <fs_master>-status = <fs_entity>-%data-Status.
      ENDIF.

      IF <fs_entity>-%control-ItemsCount = if_abap_behv=>fc-o-disabled.
        <fs_master>-items_count = <fs_entity>-%data-ItemsCount.
      ENDIF.

      IF <fs_entity>-%control-AnnexureName = if_abap_behv=>fc-o-disabled.
        <fs_master>-annexure_name = <fs_entity>-%data-AnnexureName.
      ENDIF.

      IF <fs_entity>-%control-Type = if_abap_behv=>fc-o-disabled.
        <fs_master>-type = <fs_entity>-%data-Type.
      ENDIF.


      li_master_3 = VALUE #(
                             BASE li_master_3
                             (
                               annexureid    = <fs_master>-annexure_id
                               annexurename  = <fs_master>-annexure_name
                               Category     = <fs_master>-category
                               createdby    = <fs_master>-created_by
                               createddate  = <fs_master>-created_date
                               createdtime  = <fs_master>-created_time
                               itemscount   = <fs_master>-items_count
                               status       = <fs_master>-status
                               type         = <fs_master>-type
                               timestamp    = <fs_master>-timestamp
                             )
                           ).

    ENDLOOP.

    lo_annex->update_annexure( i_master = CORRESPONDING #( li_master_3 ) ).

    mapped-zi_annexure_master_aj = VALUE #(
                                             FOR lwa_master1 IN li_master
                                             ( %key-AnnexureId = lwa_master1-annexure_id )
                                          )  .

  ENDMETHOD.

  METHOD delete.

    DATA(lo_annex) = zcl_aj_annexure_bp=>get_instance( ).

    DATA : li_annexure_ids TYPE zcl_aj_annexure_bp=>t_master_t.

    li_annexure_ids = VALUE #(
                                FOR lwa_keys IN keys
                                ( annexureid = lwa_keys-%key-AnnexureId )
                             ).

    lo_annex->li_master = li_annexure_ids.
    lo_annex->l_type = 'D'.

  ENDMETHOD.

  METHOD read.

    SELECT *
       FROM zaj_annex_master
       FOR ALL ENTRIES IN @keys
       WHERE annexure_id = @keys-AnnexureId
       INTO TABLE @DATA(li_master).
    IF sy-subrc EQ 0.

      result = VALUE #(
                        FOR lwa_master IN li_master
                        (
                          %key-AnnexureId = lwa_master-annexure_id
                          %data-AnnexureName = lwa_master-annexure_name
                          %data-Category     = lwa_master-category
                          %data-CreatedBy    = lwa_master-created_by
                          %data-CreatedDate  = lwa_master-created_date
                          %data-CreatedTime  = lwa_master-created_time
                          %data-ItemsCount   = lwa_master-items_count
                          %data-Status       = lwa_master-status
                          %data-Type         = lwa_master-type
                          %data-Timestamp    = lwa_master-timestamp
                        )
                      ).

    ENDIF.

  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD Accept.

    MODIFY ENTITIES OF zi_annexure_master_aj IN LOCAL MODE
        ENTITY zi_annexure_master_aj
        UPDATE FIELDS ( Status )
        WITH VALUE #(
                      FOR ls_keys IN keys
                      ( %tky = ls_keys-%tky %data-Status = 'C' )
                    ).


    READ ENTITIES OF zi_annexure_master_aj IN LOCAL MODE
        ENTITY zi_annexure_master_aj
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(li_result).

    result = VALUE #(
                      FOR ls_result IN li_result
                      (
                        %tky = ls_result-%tky
                        %param = ls_result
                      )
                    ).
    mapped-zi_annexure_master_aj = VALUE #(
                                            FOR ls_result IN li_result
                                            (
                                                %key = ls_result-%key
                                            )
                                          ).


  ENDMETHOD.

ENDCLASS.
