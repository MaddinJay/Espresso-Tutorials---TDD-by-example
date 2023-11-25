INTERFACE yif_product_ratings_dao
  PUBLIC .
  METHODS read IMPORTING product_id    TYPE ye_product_id
               RETURNING VALUE(result) TYPE ytt_product_rating.

ENDINTERFACE.
