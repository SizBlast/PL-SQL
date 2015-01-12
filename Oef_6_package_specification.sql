CREATE OR REPLACE PACkAGE Oefening6Package IS

  TYPE product_rec_type IS RECORD(
     product_id product_information.product_id%TYPE,
     product_name product_information.product_name%TYPE,
     new_price product_information.list_price%TYPE
  );

  TYPE product_tab_type IS TABLE OF product_rec_type INDEX BY PLS_INTEGER;
  
  FUNCTION checkCategory (p_category_id product_information.category_id%TYPE) RETURN BOOLEAN;
  
  FUNCTION checkEnough (p_category_id product_information.category_id%TYPE,
  p_number NUMBER) RETURN BOOLEAN;
  
  FUNCTION getProductDiscounts (p_category_id product_information.category_id%TYPE,
  p_number NUMBER) RETURN product_tab_type;
  
  PROCEDURE updatePrijzen (p_category_id product_information.category_id%TYPE,
  p_number NUMBER);
  
  END;