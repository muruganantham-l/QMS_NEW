use hrms40
go

if exists ( select 'y' from sysobjects where name = 'aml_ars_processed_status' and type = 'u')
    drop table aml_ars_processed_status
go

create table aml_ars_processed_status
(
empcode				varchar(200)
,attendance_date	varchar(200)
,attendance_time	varchar(200)
,io_flag			varchar(200)
,file_name1			varchar(200)
,date				date
,status				varchar(10)
,err_id				int
,err_desc			varchar(max)
)

go

if exists ( select 'y' from sysobjects where name = 'aml_ars_processed_status' and type = 'u')
    grant all on aml_ars_processed_status to public
go
