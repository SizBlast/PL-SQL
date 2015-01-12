-- Testprogramma
DECLARE
  v_job_id jobs.job_id%TYPE;
  v_job_info oefening1package.t_job_info;
BEGIN
  --v_job_id := 'Geef_de_jobid';
  v_job_id := 'AD_VP';  
  v_job_info := oefening1package.geefwerknemers(v_job_id);
  dbms_output.put_line('job_id = ' || v_job_info.job_id);
  dbms_output.put_line('job_title = ' || v_job_info.job_title);
  dbms_output.put_line('namen =');
  FOR i IN v_job_info.name_tab.FIRST .. v_job_info.name_tab.LAST LOOP
		IF v_job_info.name_tab.EXISTS(i) THEN
      IF i = v_job_info.name_tab.LAST THEN
        DBMS_OUTPUT.PUT_LINE(' ' || v_job_info.name_tab(i) || '.');
      ELSE
        DBMS_OUTPUT.PUT_LINE(' ' || v_job_info.name_tab(i) || ',');
      END IF;
		END IF;
	END LOOP;
end;