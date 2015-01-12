CREATE OR REPLACE PROCEDURE GemiddeldeWinstPerCategorie AS

  v_resultaat NUMBER(10,5) := 0;
  v_aantal NUMBER(6,0) := 0;

  CURSOR cur_cats IS
    SELECT *
    FROM categories;
    
  CURSOR cur_products (p_category_id product_information.category_id%TYPE) IS
    SELECT list_price, min_price
    FROM product_information
    WHERE category_id = p_category_id;
    
  BEGIN
    FOR cat_rec IN cur_cats LOOP
      dbms_output.put('category ' || cat_rec.category_name || ' ' || cat_rec.category_description || ': ');
      v_resultaat := 0;
      v_aantal := 0;
      FOR product_rec IN cur_products(cat_rec.category_id) LOOP
        v_aantal := v_aantal + 1;
        v_resultaat := v_resultaat + ((product_rec.list_price - product_rec.min_price) / product_rec.min_price);
      END LOOP;
      
      IF v_aantal = 0 THEN
        dbms_output.put_line('Er zijn geen producten voor deze categorie');
      ELSE
        dbms_output.put_line(Round(v_resultaat / v_aantal,2));
      END IF;
    END LOOP;
  END;