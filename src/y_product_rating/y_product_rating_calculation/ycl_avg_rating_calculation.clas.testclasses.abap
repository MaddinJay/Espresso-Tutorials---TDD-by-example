CLASS ltcl_avg_rating_calculation DEFINITION DEFERRED.
CLASS ycl_avg_rating_calculation DEFINITION LOCAL FRIENDS ltcl_avg_rating_calculation.

CLASS ltcl_avg_rating_calculation DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO ycl_avg_rating_calculation.

    METHODS:
      calc_avg_rating_successfully FOR TESTING,
      process_executed_success     FOR TESTING.

    METHODS create_product_ratings_dao
      RETURNING VALUE(product_ratings_dao_mock) TYPE REF TO yif_product_ratings_dao.
ENDCLASS.

CLASS ltcl_avg_rating_calculation IMPLEMENTATION.

  METHOD calc_avg_rating_successfully.
    cut = NEW #( ).

    cl_abap_unit_assert=>assert_equals(
        exp = VALUE ytt_avg_rating(
                ( product_id = 'TEST1' product_desc = 'Test Descr 1' avg_rating = '4.5' created_on = sy-datum )
                ( product_id = 'TEST2' product_desc = 'Test Descr 2' avg_rating = '3.3' created_on = sy-datum ) )

        act = cut->calculate_avg_rating( VALUE ytt_product_rating(
                ( product_id = 'TEST1' product_desc = 'Test Descr 1' rating = '4' )
                ( product_id = 'TEST1' product_desc = 'Test Descr 1' rating = '5' )
                ( product_id = 'TEST2' product_desc = 'Test Descr 2' rating = '3' )
                ( product_id = 'TEST2' product_desc = 'Test Descr 2' rating = '3' )
                ( product_id = 'TEST2' product_desc = 'Test Descr 2' rating = '4' ) ) ) ).
  ENDMETHOD.

  METHOD process_executed_success.
    cut = NEW #( product_ratings_dao = create_product_ratings_dao( )
                 print_data          = NEW ltd_print_data( ) ).

    TRY.
        cut->process( 'TEST1' ).
      CATCH cx_abap_context_info_error.
        cl_abap_unit_assert=>fail( 'Falsches Ergebnis für AVG_RATING berechnet. Check LTD_PRINT_DATA->PRINT.' ).
    ENDTRY.
  ENDMETHOD.

  METHOD create_product_ratings_dao.
    product_ratings_dao_mock ?= cl_abap_testdouble=>create( 'YIF_PRODUCT_RATINGS_DAO' ).

    cl_abap_testdouble=>configure_call( product_ratings_dao_mock )->returning(
      VALUE ytt_product_rating(
                ( product_id = 'TEST1' product_desc = 'Test Descr 1' rating = '4' )
                ( product_id = 'TEST1' product_desc = 'Test Descr 1' rating = '5' ) )
    ).

    product_ratings_dao_mock->read( 'TEST1' ).
  ENDMETHOD.

ENDCLASS.
