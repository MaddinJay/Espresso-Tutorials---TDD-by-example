CLASS ltd_print_data DEFINITION FINAL.

  PUBLIC SECTION.
    INTERFACES: yif_print_data.

ENDCLASS.

CLASS ltd_print_data IMPLEMENTATION.

  METHOD yif_print_data~display.
    " Falls Ergebnis nicht korrekt -> Raise Exception
    IF avg_ratings <> VALUE ytt_avg_rating(
                ( product_id = 'TEST1' product_desc = 'Test Descr 1' avg_rating = '4.5' created_on = sy-datum ) ).
      RAISE EXCEPTION TYPE cx_abap_context_info_error.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
