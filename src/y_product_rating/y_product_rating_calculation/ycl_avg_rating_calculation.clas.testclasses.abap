CLASS ltcl_avg_rating_calculation DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO ycl_avg_rating_calculation.

    METHODS:
      calc_avg_rating_successfully FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_avg_rating_calculation IMPLEMENTATION.

  METHOD calc_avg_rating_successfully.
    cut = NEW #( ).

    cl_abap_unit_assert=>assert_equals(
        exp = VALUE ytt_avg_rating(
                ( product_id = 'TEST1' product_desc = 'Test Descr 1' avg_rating = '4.5' created_on = sy-datum )
                ( product_id = 'TEST2' product_desc = 'Test Descr 2' avg_rating = '3.3' created_on = sy-datum ) )

        act = cut->calculate( VALUE ytt_product_rating(
                ( product_id = 'TEST1' product_desc = 'Test Descr 1' rating = '4' )
                ( product_id = 'TEST1' product_desc = 'Test Descr 1' rating = '5' )
                ( product_id = 'TEST2' product_desc = 'Test Descr 2' rating = '3' )
                ( product_id = 'TEST2' product_desc = 'Test Descr 2' rating = '3' )
                ( product_id = 'TEST2' product_desc = 'Test Descr 2' rating = '4' ) ) ) ).
  ENDMETHOD.

ENDCLASS.
