DECLARE
  v_department_id departments.department_id%TYPE;
  exception_dept_id EXCEPTION;
  PRAGMA exception_init (exception_dept_id, -20001);
  v_loc_dept departement_info.t_dep_loc;
  v_mgr_dept departement_info.t_dep_mgr;
  v_cnt NUMBER(4);
  v_department_name departments.department_name%TYPE;
  v_manager_id departments.manager_id%TYPE;
BEGIN
  -- v_department_id := '&Geef_de_departementid';
  v_department_id := '50';
  
  -- controleer of dit departement bestaat
  SELECT COUNT(department_id) INTO v_cnt FROM departments WHERE department_id = v_department_id;
  IF v_cnt = 0 THEN
    raise_application_error(-20001, 'Dit departement bestaat niet');
  END IF;
  
  -- Geef de gegevens van dit departement
  dbms_output.put_line('De gegevens van departement ' || v_department_id);
  
  SELECT department_name INTO v_department_name FROM departments WHERE department_id = v_department_id;
  dbms_output.put_line('De naam van het departement = ' || v_department_name);
  v_loc_dept := departement_info.location_department(v_department_id);
  dbms_output.put_line('Region = ' || v_loc_dept.region_name || CHR(13)||CHR(10)|| 'Country = ' || v_loc_dept.country_name || CHR(13)||CHR(10)|| 
  'State = ' || v_loc_dept.state || CHR(13)||CHR(10)|| 'City = ' || v_loc_dept.city);
  SELECT COUNT(manager_id) INTO v_cnt FROM departments WHERE department_id = v_department_id;
  IF v_cnt = 0 THEN
    raise_application_error(-20001, 'Er bestaat geen manager voor dit departement');
  END IF;
  v_mgr_dept := departement_info.manager_department(v_department_id);
  dbms_output.put_line('Name manager = ' || v_mgr_dept.first_name || ' ' || v_mgr_dept.last_name || CHR(13)||CHR(10)|| 'Email = ' || v_mgr_dept.email || CHR(13)||CHR(10)|| 'Phone = ' || v_mgr_dept.phone_number);

EXCEPTION
  WHEN exception_dept_id THEN
    dbms_output.put_line (SQLERRM);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE ('Er is een fout opgetreden');

END;