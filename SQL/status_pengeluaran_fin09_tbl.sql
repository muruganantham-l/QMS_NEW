drop table status_pengeluaran_fin09_tbl


create table status_pengeluaran_fin09_tbl
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
)