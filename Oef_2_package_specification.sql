CREATE OR REPLACE PACKAGE departement_info AS

  TYPE t_dep_loc IS RECORD (
    region_name regions.region_name%TYPE,
    country_name countries.country_name%TYPE,
    state locations.state_province%TYPE,
    city locations.city%TYPE
  );
  
  TYPE t_dep_mgr IS RECORD (
    first_name employees.first_name%TYPE,
    last_name employees.last_name%TYPE,
    email employees.email%TYPE,
    phone_number employees.phone_number%TYPE
  );
  
  FUNCTION location_department(p_department_id departments.department_id%TYPE) RETURN t_dep_loc;
  
  FUNCTION manager_department(p_department_id departments.department_id%TYPE) RETURN t_dep_mgr;

END;