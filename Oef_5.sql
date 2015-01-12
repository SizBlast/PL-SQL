CREATE OR REPLACE PROCEDURE employees_per_country (p_region_id regions.region_id%TYPE) IS
  v_region_name regions.region_name%TYPE;
  
  CURSOR countries_curs IS
    SELECT co.country_id, co.country_name
    FROM countries co, locations l, departments d, employees e
    WHERE co.region_id = p_region_id
      AND co.country_id = l.country_id
      AND l.location_id = d.location_id
      AND d.department_id = e.department_id 
    GROUP BY co.country_id, co.country_name
    HAVING COUNT(e.employee_id) > 0;
    
  CURSOR loc_curs (p_country_id LOCATIONS.country_id%TYPE) IS
    SELECT * 
    from locations 
    where country_id = p_country_id;

  CURSOR emp_curs (p_location_id DEPARTMENTS.location_id%TYPE) IS
    SELECT employee_id, first_name, last_name, salary, department_name
    FROM employees e
      JOIN departments d ON e.department_id = d.department_id
    WHERE d.location_id = p_location_id;
  
  v_number NUMBER(3,0) := 0;
  
  BEGIN
    FOR country_rec IN countries_curs LOOP
      dbms_output.put_line('COUNTRY = ' || country_rec.country_id || ' ' || country_rec.country_name);
      FOR loc_rec in loc_curs(country_rec.country_id) LOOP
        dbms_output.put_line('LOCATION = ' || loc_rec.location_id || ' ' || loc_rec.city || ' ' || loc_rec.state_province);
        FOR emp_rec in emp_curs(loc_rec.location_id) LOOP
          v_number := emp_curs%ROWCOUNT;
          dbms_output.put_line('EMPLOYEE = ' || emp_rec.employee_id || ' ' || emp_rec.first_name || ' ' || emp_rec.last_name || ' Department = ' || emp_rec.department_name);
        END LOOP;
        dbms_output.put_line('Totaal aantal personeelsleden in ' || loc_rec.city || ' ' || v_number);
        dbms_output.put_line('');
      END LOOP;
      dbms_output.put_line('');
    END LOOP;
  END;