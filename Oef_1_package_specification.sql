CREATE OR REPLACE PACKAGE Oefening1Package IS

  TYPE t_name_type IS TABLE OF VARCHAR2(50)
  INDEX BY BINARY_INTEGER;
  
  TYPE t_job_info IS RECORD (
    job_id jobs.job_id%TYPE,
    job_title jobs.job_title%TYPE,
    name_tab t_name_type
  );
  
  FUNCTION geefWerknemers(p_job_id jobs.job_id%TYPE) RETURN t_job_info;

END;
  