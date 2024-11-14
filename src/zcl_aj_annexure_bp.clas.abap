CLASS zcl_aj_annexure_bp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    CLASS-DATA : lo_m    TYPE REF TO zcl_aj_annexure_bp,
                 l_annex TYPE c LENGTH 60.
    TYPES : BEGIN OF t_master,
              cid               TYPE abp_behv_cid,
              annexureid        TYPE c LENGTH 60,
              annexurename      TYPE c LENGTH 120,
              itemscount        TYPE int8,
              category          TYPE c LENGTH 5,
              type              TYPE c LENGTH 3,
              typedescription   TYPE c LENGTH 20,
              status            TYPE c LENGTH 1,
              statusdescription TYPE c LENGTH 100,
              createddate       TYPE d,
              createdtime       TYPE t,
              createdby         TYPE abp_creation_user,
              timestamp         TYPE abp_creation_tstmpl,
            END OF t_master,
            t_master_t TYPE TABLE OF t_master WITH DEFAULT KEY.
    DATA: li_master TYPE TABLE OF t_master.


    METHODS :
      constructor,
      create_annexure
        IMPORTING i_master TYPE t_master_t,
      create_annex_ids
        IMPORTING i_master TYPE t_master_t
        RETURNING VALUE(r_master) TYPE t_master_t,

      save_annexure.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aj_annexure_bp IMPLEMENTATION.

  METHOD create_annexure.

    li_master = CORRESPONDING #( i_master ).

    LOOP AT li_master ASSIGNING FIELD-SYMBOL(<fs_master>).

      <fs_master>-createdby = cl_abap_context_info=>get_user_technical_name( ).
      <fs_master>-createddate = cl_abap_context_info=>get_system_date( ).
      <fs_master>-createdtime = cl_abap_context_info=>get_system_time( ).
      <fs_master>-timestamp = cl_abap_context_info=>get_system_date( ) && cl_abap_context_info=>get_system_time( ).

    ENDLOOP.

  ENDMETHOD.

  METHOD constructor.

*    DATA(lo_master) = NEW zcl_aj_annexure_bp( ).
    lo_m  = COND #( WHEN lo_m IS NOT BOUND THEN lo_m ELSE NEW #(  ) ).

  ENDMETHOD.

  METHOD save_annexure.

    DATA : li_master_annex TYPE TABLE OF zaj_annex_master.
*    li_master_annex = CORRESPONDING #( li_master ).

    li_master_annex = VALUE #(
                                FOR lwa_master IN li_master
                                (
                                    annexure_id   = lwa_master-annexureid
                                    annexure_name = lwa_master-annexurename
                                    category      = lwa_master-category
                                    type          = lwa_master-type
                                    items_count   = lwa_master-itemscount
                                    status        = lwa_master-status
                                    created_by    = lwa_master-createdby
                                    created_date  = lwa_master-createddate
                                    created_time  = lwa_master-createdtime
                                    timestamp     = lwa_master-timestamp

                                )
                             ).
    MODIFY zaj_annex_master FROM TABLE @li_master_annex.

  ENDMETHOD.

  METHOD create_annex_ids.

     DATA : l_annex_id TYPE c LENGTH 60.
     li_master = CORRESPONDING #( i_master ).
     LOOP AT li_master ASSIGNING FIELD-SYMBOL(<fs_master>).

        CLEAR : l_annex_id.

        l_annex_id = <fs_master>-category && '_' && cl_abap_context_info=>get_system_date( ).
        <fs_master>-annexureid = l_annex_id && '_'.
        l_annex_id = l_annex_id && '_%'.

        SELECT COUNT( * )
           FROM zaj_annex_master
           WHERE annexure_id LIKE @l_annex_id
           INTO @DATA(l_count).

        l_count += 1.
        <fs_master>-annexureid = <fs_master>-annexureid && CONV string( l_count ).

     ENDLOOP.

     r_master = li_master.

  ENDMETHOD.

ENDCLASS.
