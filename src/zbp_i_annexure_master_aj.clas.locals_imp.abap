CLASS lsc_ZI_ANNEXURE_MASTER_AJ DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS adjust_numbers REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_ANNEXURE_MASTER_AJ IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD adjust_numbers.

    CHECK zcl_aj_annexure_bp=>l_type EQ 'C'.

    DATA(lo_annex) = zcl_aj_annexure_bp=>get_instance( ).

    DATA(li_master) = lo_annex->create_annex_ids( i_master = zcl_aj_annexure_bp=>lo_m->li_master ).

    mapped-zi_annexure_master_aj = VALUE #(
                                            FOR lwa_master IN li_master
                                            ( %key-AnnexureId = lwa_master-annexureid )
                                          ).



  ENDMETHOD.

  METHOD save.

   DATA(lo_annex) = zcl_aj_annexure_bp=>get_instance( ).
    IF zcl_aj_annexure_bp=>l_type = 'D'.
        lo_annex->delete_annexure( ).
    ELSE.
      lo_annex->save_annexure( ).
    ENDIF.


  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
