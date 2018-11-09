create table nbe_unshc_main_penlty_tbl
(

be_number							varchar(30)
,be_category						varchar(300)
,problem_reported varchar(300)
,action_taken varchar(300)
,wo_status varchar(300)
,wr_number							varchar(12)
,wo_number							varchar(11)
,wr_datetime						DATETIME
,wo_response_datetime DATETIME
,wo_cmpl_datetime DATETIME
,kpi_days_response  int
,kpi_days_repair int
,per_day_penalty_cost   NUMERIC(28,2)
,final_response_days int
,final_repair_days INT
,final_response_penalty_cost NUMERIC(28,2)
,final_repair_penalty_cost NUMERIC(28,2)
,final_total_penalty_cost NUMERIC(28,2)
,clinic_name varchar(300)
,state1 varchar(300)
,district varchar(300)
)