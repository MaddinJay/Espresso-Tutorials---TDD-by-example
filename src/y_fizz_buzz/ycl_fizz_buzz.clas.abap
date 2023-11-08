CLASS ycl_fizz_buzz DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_list,
             number           TYPE int1,
             converted_number TYPE string,
           END OF ts_list,
           tt_list TYPE STANDARD TABLE OF ts_list WITH DEFAULT KEY.

    METHODS convert IMPORTING number        TYPE int1
                    RETURNING VALUE(result) TYPE tt_list.

    METHODS convert_number IMPORTING number        TYPE int1
                           RETURNING VALUE(result) TYPE string.

  PRIVATE SECTION.
    CONSTANTS fizz TYPE string VALUE `Fizz` ##NO_TEXT.
    CONSTANTS buzz TYPE string VALUE `Buzz` ##NO_TEXT.

    METHODS is_dividable_by_3 IMPORTING number        TYPE int1
                              RETURNING VALUE(result) TYPE abap_boolean.
    METHODS is_dividable_by_5 IMPORTING number        TYPE int1
                              RETURNING VALUE(result) TYPE abap_boolean.

ENDCLASS.

CLASS ycl_fizz_buzz IMPLEMENTATION.

  METHOD convert.
    APPEND VALUE ts_list( number = number converted_number = convert_number( number ) ) TO result.
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
