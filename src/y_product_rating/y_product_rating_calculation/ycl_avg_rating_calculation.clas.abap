CLASS ycl_avg_rating_calculation DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS calculate IMPORTING product_ratings TYPE ytt_product_rating
                      RETURNING VALUE(result)   TYPE ytt_avg_rating.
  PRIVATE SECTION.

ENDCLASS.

CLASS ycl_avg_rating_calculation IMPLEMENTATION.

  METHOD calculate.
    DATA count TYPE int1.

    LOOP AT product_ratings INTO DATA(product_rating)
      GROUP BY ( group = product_rating-product_id ) INTO DATA(group). " Gruppiere durch Product ID

      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<avg_rating>).
      LOOP AT GROUP group ASSIGNING FIELD-SYMBOL(<rating>).            " Für alle Einträge zu einer Product ID
        <avg_rating> = VALUE #( BASE <avg_rating>
                              product_id   = <rating>-product_id
                              product_desc = <rating>-product_desc
                              avg_rating   = <rating>-rating + <avg_rating>-avg_rating
                              created_on   = sy-datum ). ##TODO " Find new expression in HANA
        count = count + 1.
      ENDLOOP.
      <avg_rating>-avg_rating = <avg_rating>-avg_rating / count.           " Arithmetisches Mittel
      CLEAR count.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
