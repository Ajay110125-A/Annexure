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


    DATA : li_category TYPE TABLE OF zaj_anx_category.

    li_category = VALUE #(
                          ( user_id = cl_abap_context_info=>get_user_technical_name( ) category = 'AA01' )
                          ( user_id = cl_abap_context_info=>get_user_technical_name( ) category = 'BB01' )
                          ( user_id = cl_abap_context_info=>get_user_technical_name( ) category = 'AB01' )
                          ( user_id = cl_abap_context_info=>get_user_technical_name( ) category = 'CB01' )
                         ).

    INSERT zaj_anx_category FROM TABLE @li_category.

    DATA : li_type TYPE TABLE OF zaj_anx_type.

    li_type = VALUE #(
                       ( type = 'D' text = 'Domestic' )
                       ( type = 'E' text = 'Export' )
                     ).

    MODIFY  zaj_anx_type FROM TABLE @li_type.


    DATA : li_status TYPE TABLE OF zaj_anx_status.

    li_status = VALUE #(
                        ( status = 'N' status_desc = 'Not Yet Started'  )
                        ( status = 'C' status_desc = 'Completed'  )
                        ( status = 'I' status_desc = 'In Progress'  )
                        ( status = 'R' status_desc = 'Rejected'  )
                       ).

    MODIFY  zaj_anx_status FROM TABLE @li_status.

    DATA : li_constant TYPE TABLE OF zaj_anx_const.

    li_constant = VALUE #(
                          ( prgname = 'USER_ID' var = '01' value = cl_abap_context_info=>get_user_technical_name( ) )
                          ( prgname = 'USER_ID' var = '02' value = 'AJAY_123' )
                          ( prgname = 'USER_ID' var = '03' value = 'KIM_DAHYUN' )
                         ).

    MODIFY zaj_anx_const FROM TABLE @li_constant.

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
