CLASS zcl_aj_insert_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aj_insert_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA : li_master TYPE TABLE OF zaj_annex_master.

    li_master = VALUE #(
*                         ( annexure_id = 'AA01_20241104_1' annexure_name = 'Test-001' items_count = 1 category = 'AA01' type = 'D' status = 'N' created_by = sy-uname
*                           created_date = cl_abap_context_info=>get_system_date( ) created_time = cl_abap_context_info=>get_system_time( )
*                           timestamp = cl_abap_context_info=>get_system_date( ) && cl_abap_context_info=>get_system_time( )
*                         )
*                         ( annexure_id = 'AA01_20241104_2' annexure_name = 'Test-002' items_count = 1 category = 'AA01' type = 'D' status = 'N' created_by = sy-uname
*                           created_date = cl_abap_context_info=>get_system_date( ) created_time = cl_abap_context_info=>get_system_time( )
*                           timestamp = cl_abap_context_info=>get_system_date( ) && cl_abap_context_info=>get_system_time( )
*                         )
                         ( annexure_id = 'AA01_20241104_3' annexure_name = 'Test-003' items_count = 1 category = 'AA01' type = 'D' status = 'C' created_by = sy-uname
                           created_date = cl_abap_context_info=>get_system_date( ) created_time = cl_abap_context_info=>get_system_time( )
                           timestamp = cl_abap_context_info=>get_system_date( ) && cl_abap_context_info=>get_system_time( )
                         )
                       ).

    MODIFY zaj_annex_master FROM TABLE @li_master.
    COMMIT WORK AND WAIT.

    out->write(
      EXPORTING
        data   = li_master
*        name   =
*      RECEIVING
*        output =
    ).

    out->write( 'Inserted' ).
  ENDMETHOD.
ENDCLASS.
