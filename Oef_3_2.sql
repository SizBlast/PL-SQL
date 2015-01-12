CREATE OR REPLACE PROCEDURE productenperklant AS
  CURSOR cust_curs IS 
    SELECT customer_id, cust_first_name, cust_last_name
    FROM customers;
    
  CURSOR product_curs (p_customer_id customers.customer_id%TYPE) IS
    SELECT p.product_id, p.product_name, oi.unit_price, oi.quantity
    FROM orders o
      JOIN order_items oi ON o.order_id = oi.order_id
      JOIN product_information p ON oi.product_id = p.product_id 
    WHERE o.customer_id = p_customer_id;
  
  BEGIN
    FOR cust_rec IN cust_curs LOOP
      dbms_output.put_line('Customer ' || cust_rec.customer_id || ' ' || cust_rec.cust_first_name || ' ' || cust_rec.cust_last_name);
      FOR product_rec IN product_curs (cust_rec.customer_id) LOOP
          dbms_output.put_line(product_rec.product_id || ' ' || product_rec.product_name || ' ' || product_rec.unit_price || ' ' || product_rec.quantity);
      END LOOP;
    END LOOP;
  END;