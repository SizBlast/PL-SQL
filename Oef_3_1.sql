CREATE OR REPLACE PROCEDURE productenperwarehouse AS
  CURSOR cur_warehouses IS
    SELECT warehouse_id, warehouse_name
    FROM warehouses;
    
  CURSOR cur_products (p_warehouse_id warehouses.warehouse_id%TYPE) IS 
    SELECT p.product_id, p.product_name
    FROM inventories i, product_information p 
    WHERE p.product_id = i.product_id AND i.warehouse_id = p_warehouse_id;
    
  BEGIN
    FOR warehouse_rec IN cur_warehouses LOOP
      dbms_output.put_line('Warehouse ' || warehouse_rec.warehouse_id || ' ' || warehouse_rec.warehouse_name);
      FOR product_rec IN cur_products(warehouse_rec.warehouse_id) LOOP
        dbms_output.put_line(product_rec.product_id || ' ' || product_rec.product_name);
      END LOOP;
        dbms_output.put_line(' ');
    END LOOP;
  END;