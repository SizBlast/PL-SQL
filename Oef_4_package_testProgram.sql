declare
  v_order_rec_type1 oefening4package.order_product_rec_type;
  v_order_rec_type2  oefening4package.order_product_rec_type;
  v_order_product_tab  oefening4package.order_product_tab_type;
BEGIN
  v_order_rec_type1.product_id := 4200;
  v_order_rec_type1.product_name := 'test_product_1';
  v_order_rec_type1.category_id := 11;
  v_order_rec_type1.product_status := 'planned';
  v_order_rec_type1.list_price := 510;
  v_order_rec_type1.min_price := 480;

  v_order_rec_type2.product_id := 4201;
  v_order_rec_type2.product_name := 'test_product_2';
  v_order_rec_type2.category_id := 11;
  v_order_rec_type2.product_status := 'obsolete';
  v_order_rec_type2.list_price := 520;
  v_order_rec_type2.min_price := 470;

  v_order_product_tab(1) := v_order_rec_type1;
  v_order_product_tab(2) := v_order_rec_type2;
  
  oefening4package.addproducts(v_order_product_tab);
END;