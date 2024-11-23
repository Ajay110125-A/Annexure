CLASS zcl_entity_program DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ENTITY_PROGRAM IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    READ ENTITY  zi_annexure_master_aj
         ALL FIELDS WITH VALUE #( ( %key-AnnexureId = 'AA01_20241104_1' ) )
          RESULT DATA(li_result).



    READ ENTITY zi_travel_ay_m "Single Entity Name
*    FIELDS ( AgencyId CustomerId CreatedAt )                               "While using FIELDS keep as WITH, Not FROM
*    FROM  VALUE #( ( ) )
    ALL FIELDS                                                              "Or you can fetch all fields from ENTITY
    WITH VALUE #( ( %key-TravelId = '00000019'                              "Way to give input and Only TravelId get fetched because no fields selected
*                    %control = VALUE #( AgencyId   = if_abap_behv=>mk-on   "One of way to select the fields from entity by putting ON on fields
*                                        CustomerId = if_abap_behv=>mk-on
*                                        BeginDate  = if_abap_behv=>mk-on
*                                      )
                  )
                )
    RESULT DATA(lt_travel_short)
    FAILED DATA(lt_failed_short).


    out->write( 'Data' ).
    out->write( li_result ).
  ENDMETHOD.
ENDCLASS.
