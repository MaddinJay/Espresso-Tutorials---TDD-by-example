CLASS ltcl_fizz_buzz DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      cut TYPE REF TO ycl_fizz_buzz.

    METHODS: setup,
      for_1_return_1         FOR TESTING,
      for_3_return_fizz      FOR TESTING,
      for_5_return_buzz      FOR TESTING,
      for_15_return_fizzbuzz FOR TESTING,
      for_100_return_buzz    FOR TESTING.
ENDCLASS.

CLASS ltcl_fizz_buzz IMPLEMENTATION.

  METHOD setup.
    cut = NEW #( ).
  ENDMETHOD.

  METHOD for_1_return_1.
    cl_abap_unit_assert=>assert_equals( exp = |1|
                                        act = cut->convert_number( 1 ) ).
  ENDMETHOD.

  METHOD for_3_return_fizz.
    cl_abap_unit_assert=>assert_equals( exp = |Fizz|
                                        act = cut->convert_number( 3 ) ).
  ENDMETHOD.

  METHOD for_5_return_buzz.
    cl_abap_unit_assert=>assert_equals( exp = |Buzz|
                                        act = cut->convert_number( 5 ) ).
  ENDMETHOD.

  METHOD for_15_return_fizzbuzz.
    cl_abap_unit_assert=>assert_equals( exp = |FizzBuzz|
                                        act = cut->convert_number( 15 ) ).
  ENDMETHOD.

  METHOD for_100_return_buzz.
    cl_abap_unit_assert=>assert_equals( exp = |Buzz|
                                        act = cut->convert_number( 100 ) ).
  ENDMETHOD.

ENDCLASS.
