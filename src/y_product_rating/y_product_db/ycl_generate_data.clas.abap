CLASS ycl_generate_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
    METHODS generate_products RETURNING VALUE(r_number_of_entries) TYPE i.
    METHODS generate_ratings RETURNING VALUE(r_number_of_entries) TYPE i.
  PRIVATE SECTION.
ENDCLASS.



CLASS yCL_GENERATE_DATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(number_of_entries) = generate_products( ).
    out->write( |{ number_of_entries } products generated successfully!| ).

    number_of_entries = generate_ratings( ).
    out->write( |{ number_of_entries } ratings generated successfully!| ).
  ENDMETHOD.


  METHOD generate_ratings.
    DATA ratings TYPE TABLE OF yrating.

    DELETE FROM yrating.

    GET TIME STAMP FIELD DATA(current_ts).

    ratings = VALUE #(
        ( rating_uuid = cl_system_uuid=>create_uuid_x16_static( )
          rating = 4
          product_id = |DXTR1000|
          name = |Anna Bauer|
          email = |anna@bauer.de|
          )
        ( rating_uuid = cl_system_uuid=>create_uuid_x16_static( )
          rating = 5
          product_id = |DXTR2000|
          name = |Chris Drumm|
          email = |cd@test.de|
          )
        ( rating_uuid = cl_system_uuid=>create_uuid_x16_static( )
          rating = 3
          product_id = |DXTR3000|
          name = |Eve Smith|
          email = |es@email.com|
          )
        ( rating_uuid = cl_system_uuid=>create_uuid_x16_static( )
          rating = 5
          product_id = |EPAD1000|
          name = |Frank Jones|
          email = |f@jones.mail|
          )
        ( rating_uuid = cl_system_uuid=>create_uuid_x16_static( )
          rating = 4
          product_id = |EPAD1000|
          name = |Gill Miller|
          email = |g.miller@online.com|
          )
        ( rating_uuid = cl_system_uuid=>create_uuid_x16_static( )
          rating = 5
          product_id = |DXTR1000|
          name = |G. Miller|
          email = |g.miller@online.com|
          )
    ).

    INSERT yrating FROM TABLE @ratings.

    RETURN sy-dbcnt.

  ENDMETHOD.


  METHOD generate_products.
    DATA products TYPE TABLE OF yproduct.
    DELETE FROM yproduct.

    products = VALUE #(
        ( product_id = |DXTR1000| product_desc = |Deluxe Touring Bike Black| )
        ( product_id = |DXTR2000| product_desc = |Deluxe Touring Bike Silver| )
        ( product_id = |DXTR3000| product_desc = |Deluxe Touring Bike Red| )
        ( product_id = |EPAD1000| product_desc = |Ellbow Pad| )
        ( product_id = |KPAD1000| product_desc = |Knee Pad| )
    ).

    INSERT yproduct FROM TABLE @products.
    RETURN sy-dbcnt.
  ENDMETHOD.
ENDCLASS.
