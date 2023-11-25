INTERFACE yif_print_data
  PUBLIC .
  METHODS display IMPORTING avg_ratings TYPE ytt_avg_rating
                  RAISING   cx_abap_context_info_error.

ENDINTERFACE.
