DECLARE
	v_product_tab Oefening6Package.product_tab_type;
BEGIN
	v_product_tab := Oefening6Package.getProductDiscounts(11, 5);

	FOR i IN v_product_tab.FIRST .. v_product_tab.LAST LOOP
		IF v_product_tab.EXISTS(i) THEN
			dbms_output.put_line(v_product_tab(i).product_id || '  ' ||	v_product_tab(i).product_name || ' ' || v_product_tab(i).new_price);
		END IF;
	END LOOP;
END;