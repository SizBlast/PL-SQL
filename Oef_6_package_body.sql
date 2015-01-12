CREATE OR REPLACE PACKAGE BODY Oefening6Package IS

  FUNCTION checkCategory (p_category_id product_information.category_id%TYPE) RETURN BOOLEAN IS
    v_count NUMBER (5,0);
    BEGIN
      SELECT COUNT(category_id) INTO v_count 
      FROM product_information
      WHERE category_id = p_category_id;
    
      RETURN v_count  > 0;	
    END;
  
  FUNCTION checkEnough (p_category_id product_information.category_id%TYPE, p_number NUMBER) RETURN BOOLEAN IS
    v_count NUMBER (5,0);
    BEGIN
      SELECT COUNT(product_id) INTO v_count 
      FROM product_information
      WHERE category_id = p_category_id;
  
      RETURN v_count >= p_number;		
    END;
  
  FUNCTION getProductDiscounts (p_category_id product_information.category_id%TYPE, p_number NUMBER) RETURN product_tab_type IS
    CURSOR c_products (p_category_id product_information.category_id%TYPE) IS
      SELECT product_id, product_name, list_price
      FROM product_information
      WHERE category_id = p_category_id
      ORDER BY list_price DESC;
      
    v_product_tab product_tab_type;
    e_my_exception EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_my_exception, -20001);
    /* Niet vergeten initialiseren */
    v_count NUMBER(5,0) := 0;
    BEGIN
      IF checkCategory(p_category_id) = false THEN
        raise_application_error (-20001, 'categorie bestaat niet');
      END IF;
      IF checkEnough(p_category_id, p_number) = false THEN
        raise_application_error (-20001, 'niet genoeg producten');
      END IF;	
      FOR product IN c_products(p_category_id) LOOP
        EXIT WHEN v_count >= p_number;
        v_product_tab(v_count).product_id := product.product_id;
        v_product_tab(v_count).product_name := product.product_name;
        v_product_tab(v_count).new_price := product.list_price * 0.9;
        v_count := v_count + 1;
      END LOOP;
      RETURN v_product_tab;
    END;
  
  PROCEDURE updatePrijzen (p_category_id product_information.category_id%TYPE, p_number NUMBER) IS
    TYPE product_id_tab_type IS TABLE OF product_information.product_id%TYPE
      INDEX BY PLS_INTEGER;
    v_product_id_tab product_id_tab_type;	
    BEGIN
      SELECT product_id BULK COLLECT INTO v_product_id_tab
      FROM product_information
      WHERE category_id = p_category_id and rownum <= p_number
      ORDER BY list_price DESC;
  
      FORALL i in v_product_id_tab.FIRST .. v_product_id_tab.LAST
      UPDATE product_information
      SET list_price = list_price * 0.9
      WHERE product_id = v_product_id_tab(i);
    END;

END;