CREATE OR REPLACE PACKAGE Oefening4Package IS

  TYPE order_product_rec_type IS RECORD (
    product_id product_information.product_id%TYPE,
    product_name product_information.product_name%TYPE,
    category_id product_information.category_id%TYPE,
    product_status product_information.product_status%TYPE,
    list_price product_information.list_price%TYPE,
    min_price product_information.min_price%TYPE
  );
  
  TYPE order_product_tab_type IS TABLE OF
    order_product_rec_type INDEX BY binary_integer;
    
  FUNCTION checkProduct (p_product_id product_information.product_id%TYPE)
  RETURN boolean;
    
  FUNCTION checkCategory (p_category_id product_information.category_id%TYPE)
  RETURN boolean;
  
  FUNCTION checkProductPrice (p_category_id product_information.category_id%TYPE,
    p_list_price product_information.list_price%TYPE,
    p_min_price product_information.min_price%TYPE)
  RETURN boolean;
   
  PROCEDURE addProducts (p_products order_product_tab_type);
  
END;