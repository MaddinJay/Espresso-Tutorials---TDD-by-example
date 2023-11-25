CLASS ycl_product_ratings_dao DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: yif_product_ratings_dao.
    ALIASES: read FOR yif_product_ratings_dao~read.

ENDCLASS.

CLASS ycl_product_ratings_dao IMPLEMENTATION.

  METHOD yif_product_ratings_dao~read.
    SELECT yproduct~product_id,
           yproduct~product_desc,
           yrating~rating
      FROM yproduct
      INNER JOIN yrating
        ON yproduct~product_id = yrating~product_id
    WHERE yproduct~product_id = @product_id
      INTO TABLE @result.
  ENDMETHOD.

ENDCLASS.
