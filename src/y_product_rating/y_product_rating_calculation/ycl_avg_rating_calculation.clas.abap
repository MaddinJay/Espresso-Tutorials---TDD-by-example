CLASS ycl_avg_rating_calculation DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor IMPORTING product_ratings_dao TYPE REF TO yif_product_ratings_dao OPTIONAL
                                  print_data          TYPE REF TO yif_print_data          OPTIONAL.

    "! <p class="shorttext synchronized" lang="en"></p>
    "! Berechnet für ein gegebenes Product das durchschnittliche Rating
    "! @parameter product_id | <p class="shorttext synchronized" lang="en">Product ID</p>
    "! @raising cx_abap_context_info_error | <p class="shorttext synchronized" lang="en"></p>
    METHODS process IMPORTING product_id TYPE ye_product_id
                    RAISING   cx_abap_context_info_error.

  PRIVATE SECTION.
    DATA product_ratings_dao TYPE REF TO yif_product_ratings_dao.
    DATA print_data          TYPE REF TO yif_print_data.

    METHODS read_product_ratings IMPORTING product_id    TYPE ye_product_id
                                 RETURNING VALUE(result) TYPE ytt_product_rating.

    METHODS calculate_avg_rating IMPORTING product_ratings TYPE ytt_product_rating
                                 RETURNING VALUE(result)   TYPE ytt_avg_rating.

    METHODS create_instance_prod_rating IMPORTING product_ratings_dao TYPE REF TO yif_product_ratings_dao.
    METHODS create_instance_print_data  IMPORTING print_data TYPE REF TO yif_print_data.
    METHODS display_data IMPORTING avg_ratings TYPE ytt_avg_rating
                         RAISING   cx_abap_context_info_error.

  ENDCLASS.

CLASS ycl_avg_rating_calculation IMPLEMENTATION.

  METHOD constructor. " Integration
    create_instance_prod_rating( product_ratings_dao ). "Operation
    create_instance_print_data( print_data ).           "Operation
  ENDMETHOD.

  METHOD process. "Integration
    DATA(product_ratings) = read_product_ratings( product_id ).         " Integration
    DATA(avg_ratings)     = calculate_avg_rating( product_ratings ).    " Operation
    display_data( avg_ratings ).                                        " Integration
  ENDMETHOD.

  METHOD display_data.
    print_data->display( avg_ratings ). " Operation
  ENDMETHOD.

  METHOD create_instance_print_data.
    me->print_data          = COND #( WHEN print_data IS BOUND THEN print_data
                                      ELSE NEW ycl_print_data( ) ).
  ENDMETHOD.

  METHOD create_instance_prod_rating.
    me->product_ratings_dao = COND #( WHEN product_ratings_dao IS BOUND THEN product_ratings_dao
                                      ELSE NEW ycl_product_ratings_dao( ) ).
  ENDMETHOD.

  METHOD calculate_avg_rating.
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

  METHOD read_product_ratings.
    result = product_ratings_dao->read( product_id ). "Operation
  ENDMETHOD.

ENDCLASS.
