CLASS ycl_fizz_buzz DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_list,
             number           TYPE int1,
             converted_number TYPE string,
           END OF ts_list,
           tt_list TYPE STANDARD TABLE OF ts_list WITH DEFAULT KEY.

    "! <p class="shorttext synchronized" lang="en"></p>
    "! Converts numbers 1 to imput number
    "!   - Number dividable by 3        -> Return 'Fizz'
    "!   - Number dividable by 5        -> Return 'Buzz'
    "!   - Number dividable by 3 and 5  -> Return 'FizzBuzz'
    "!   - Else                         -> Return number
    "! @parameter number | <p class="shorttext synchronized" lang="en">User Input</p>
    "! @parameter result | <p class="shorttext synchronized" lang="en">List of converted numbers 1 up to Input</p>
    METHODS convert IMPORTING number        TYPE int1
                    RETURNING VALUE(result) TYPE tt_list.


  PRIVATE SECTION.
    CONSTANTS fizz TYPE string VALUE `Fizz` ##NO_TEXT.
    CONSTANTS buzz TYPE string VALUE `Buzz` ##NO_TEXT.

    METHODS convert_number IMPORTING number        TYPE int1
                           RETURNING VALUE(result) TYPE string.

    METHODS is_dividable_by_3 IMPORTING number        TYPE int1
                              RETURNING VALUE(result) TYPE abap_boolean.
    METHODS is_dividable_by_5 IMPORTING number        TYPE int1
                              RETURNING VALUE(result) TYPE abap_boolean.

ENDCLASS.



CLASS YCL_FIZZ_BUZZ IMPLEMENTATION.


  METHOD convert.
    DATA actual_number TYPE int1 VALUE 1.

    DO number TIMES.
      APPEND VALUE ts_list( number = actual_number converted_number = convert_number( actual_number ) ) TO result.
      actual_number = actual_number + 1.
    ENDDO.
  ENDMETHOD.


  METHOD convert_number.
    result = COND #( WHEN is_dividable_by_3( number ) AND is_dividable_by_5( number ) THEN |{ fizz }{ buzz }|
                     WHEN is_dividable_by_3( number )                                 THEN |{ fizz }|
                     WHEN is_dividable_by_5( number )                                 THEN |{ buzz }|
                     ELSE condense( CONV string( number ) ) ).
  ENDMETHOD.


  METHOD is_dividable_by_3.
    result = xsdbool( number MOD 3 = 0 ).
  ENDMETHOD.


  METHOD is_dividable_by_5.
    result = xsdbool( number MOD 5 = 0 ).
  ENDMETHOD.
ENDCLASS.
