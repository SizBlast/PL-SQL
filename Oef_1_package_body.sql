CREATE OR REPLACE PACKAGE BODY Oefening1Package AS

  FUNCTION geefWerknemers (p_job_id jobs.job_id%TYPE) RETURN t_job_info AS
    CURSOR name_cur(p_job_id jobs.job_id%TYPE) IS
      SELECT first_name, last_name
      FROM employees
      WHERE job_id = p_job_id;
      
    job_info_rec t_job_info;
    exception_job_id EXCEPTION;
    PRAGMA exception_init (exception_job_id, -20001);
    v_cnt NUMBER(6) := 0;
    
    BEGIN
      job_info_rec.job_id := p_job_id;
      
      SELECT count(job_id) INTO v_cnt FROM jobs WHERE job_id = p_job_id;
      IF v_cnt = 0 THEN
        raise_application_error(-20001, 'De ingegeven job_id bestaat niet.');
      END IF;
      
      SELECT job_title INTO job_info_rec.job_title FROM jobs WHERE job_id = p_job_id;
      v_cnt := 1;
      
      FOR name_rec IN name_cur (p_job_id) LOOP
        job_info_rec.name_tab(v_cnt) := name_rec.first_name || ' ' || name_rec.last_name;
        v_cnt := v_cnt + 1;
      END LOOP;
      
      RETURN job_info_rec;
      
    EXCEPTION
      -- SELECT count(job_id) INTO v_cnt FROM jobs WHERE job_id = p_job_id; => heeft 0 gereturned
      WHEN exception_job_id THEN
        dbms_output.put_line(SQLERRM);
      WHEN OTHERS THEN
        dbms_output.put_line('Er is een onbekende fout opgetreden.');
    
    END;
    
END;
        