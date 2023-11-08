CLASS ltcl_fizz_buzz DEFINITION DEFERRED.
CLASS ycl_fizz_buzz DEFINITION LOCAL FRIENDS ltcl_fizz_buzz.

CLASS ltcl_fizz_buzz DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      cut TYPE REF TO ycl_fizz_buzz.

    METHODS:
      setup,
      for_1_to_5_return_list    FOR TESTING,
      for_15_return_fizzbuzz    FOR TESTING,
      for_100_return_buzz       FOR TESTING.
ENDCLASS.

CLASS ltcl_fizz_buzz IMPLEMENTATION.

  METHOD setup.
    cut = NEW #( ).
  ENDMETHOD.

  METHOD for_15_return_fizzbuzz.
    cl_abap_unit_assert=>assert_equals( exp = |FizzBuzz|
                                        act = cut->convert_number( 15 ) ).
  ENDMETHOD.

  METHOD for_100_return_buzz.
    cl_abap_unit_assert=>assert_equals( exp = |Buzz|
                                        act = cut->convert_number( 100 ) ).
  ENDMETHOD.

  METHOD for_1_to_5_return_list.
    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_fizz_buzz=>tt_list( ( number = 1 converted_number = |1| )
                                                                            ( number = 2 converted_number = |2| )
                                                                            ( number = 3 converted_number = |Fizz| )
                                                                            ( number = 4 converted_number = |4| )
                                                                            ( number = 5 converted_number = |Buzz| ) )
                                        act = cut->convert( 5 ) ).
  ENDMETHOD.

ENDCLASS.
