drop table Tsd_Uptime_report_year_tab
go
create table Tsd_Uptime_report_year_tab
(Asset_no					varchar(30)
,BE_Category				varchar(200)
,BeGroup					varchar(200)
,AgeofBE					varchar(200)
,Ownership					varchar(200)
,State						varchar(200)
,District					varchar(200)
,Zone						varchar(200)
,clinic_name				varchar(200)
,clinic_category			varchar(200)
,purchase_cost				varchar(200)
,[BE Status]				varchar(200)
,[Actual Working Days Year] int
,[Total Downtime]			int
,[First Level Days]			int
,[Second Level Days]		int
,[Total Uptime]				int
,less_than_1_uptime_grnt	float(8)
,less_than_2_uptime_grnt	float(8)
,less_than_1_uptime_penlty	float(8)
,less_than_2_uptime_penlty	float(8)
,[First Level Status]		varchar(30)	
,[Second Level Status]		varchar(30)
)
GO
drop table tsd_uptime_wo_rpt_tbl
go
create table tsd_uptime_wo_rpt_tbl
(
asset_no		varchar(30)
,wr_no			varchar(12)
,wr_date		datetime
,wo_no			varchar(11)
,wo_cmpl_date   datetime
,down_time		int
,holidays		int
)