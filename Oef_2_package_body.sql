CREATE OR REPLACE PACKAGE BODY departement_info IS

  FUNCTION location_department(p_department_id departments.department_id%TYPE) RETURN t_dep_loc AS
    v_dep_loc t_dep_loc;
    
    BEGIN
      SELECT r.region_name, co.country_name, l.state_province, l.city INTO v_dep_loc.region_name, v_dep_loc.country_name, v_dep_loc.state, v_dep_loc.city
      FROM regions r
        JOIN countries co ON r.region_id = CO.REGION_ID
        JOIN locations l ON l.country_id = co.country_id
        JOIN departments d ON l.location_id = d.location_id
      WHERE d.department_id = p_department_id;
      RETURN v_dep_loc;
    END;
    
  FUNCTION manager_department(p_department_id departments.department_id%TYPE) RETURN t_dep_mgr AS
    v_dep_mgr t_dep_mgr;
    
    BEGIN
      SELECT e.first_name, e.last_name, e.email, e.phone_number INTO v_dep_mgr.first_name, v_dep_mgr.last_name, v_dep_mgr.email, v_dep_mgr.phone_number 
      FROM employees e JOIN departments d ON e.employee_id = d.manager_id
      WHERE d.department_id = p_department_id;
      RETURN v_dep_mgr; 
    END;
    
END;