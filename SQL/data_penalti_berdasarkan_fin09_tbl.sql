drop table data_penalti_berdasarkan_fin09_tbl

--data_penalti_berdasarkan_fin09_ssrs
create table data_penalti_berdasarkan_fin09_tbl
(
state1 varchar(300)
,year1 varchar(300)
,response_time				numeric(12)		
,repair_time				numeric(12)
,schedule_maintenance		numeric(12)
,uptime_guarantees			numeric(12)
,created_by varchar(100)
,created_date datetime
,modified_by varchar(100)
,modified_date datetime
,quarter1  varchar(10)
)