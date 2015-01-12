CREATE OR REPLACE PACKAGE BODY Oefening4Package IS

  /* Functie: checkProduct */
  FUNCTION checkProduct (p_product_id product_information.product_id%TYPE)
  RETURN boolean IS
    v_count NUMBER(10, 0);  
  BEGIN
    SELECT count(product_id) INTO v_count
    FROM product_information
    WHERE product_id = p_product_id;
    
    IF v_count > 0 THEN
      RETURN true;
    ELSE
      RETURN false;
    END IF;
  END;
  
  /* Functie: checkCategory */
  FUNCTION checkCategory (p_category_id product_information.category_id%TYPE)
  RETURN boolean IS
    v_count NUMBER(10, 0);  
  BEGIN
    SELECT count(category_id) INTO v_count
    FROM product_information
    WHERE category_id = p_category_id;
    
    IF v_count > 0 THEN
      RETURN true;
    ELSE
      RETURN false;
    END IF;
  END;
  
  /* Functie: checkProductPrice */
  FUNCTION checkProductPrice (p_category_id product_information.category_id%TYPE,
    p_list_price product_information.list_price%TYPE,
    p_min_price product_information.min_price%TYPE)
  RETURN boolean IS
    v_avg_list_price product_information.list_price%TYPE;
    v_avg_min_price product_information.min_price%TYPE;
  BEGIN
    SELECT avg(list_price), avg(min_price)
    INTO v_avg_list_price, v_avg_min_price
    FROM product_information
    WHERE category_id = p_category_id;
    
    IF p_list_price < p_min_price * 0.8 OR p_list_price > p_min_price * 1.2 
      OR p_min_price < p_list_price * 0.8 OR p_min_price > p_list_price * 1.2
    THEN
      RETURN false;
    ELSE
      RETURN true;
    END IF;
  END;
  
  /* Procedure: addProducts */
  PROCEDURE addProducts (p_products order_product_tab_type) IS
    exception_add_order EXCEPTION;
    PRAGMA exception_init (exception_add_order, -20001);
  BEGIN
    FOR i in p_products.first .. p_products.last LOOP
      IF p_products.exists(i) THEN
        IF checkProduct(p_products(i).product_id) = true THEN
          RAISE_APPLICATION_ERROR(-20001, 'product id bestaat al');
        END IF;
        IF checkCategory(p_products(i).category_id) = false THEN
          RAISE_APPLICATION_ERROR(-20001, 'category id bestaat niet');
        END IF;
        IF checkProductPrice(p_products(i).category_id, p_products(i).list_price, p_products(i).min_price) = false THEN
          RAISE_APPLICATION_ERROR(-20001, 'price is niet correct');
        END IF;
        /* Toevoegen van product */
        INSERT INTO product_information (product_id, product_name, category_id, list_price, min_price)
        VALUES (p_products(i).product_id, p_products(i).product_name, p_products(i).category_id,
          p_products(i).list_price, p_products(i).min_price);
      END IF;
    END LOOP;
  END;

END;