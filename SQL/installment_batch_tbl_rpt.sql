drop table installment_batch_tbl_rpt
go
create table installment_batch_tbl_rpt
(
--sno							int identity(1,1)
batch_no					varchar(50)
,clinic_category			varchar(50)
,installment_start_date		date
,installment_end_date		date
,tot_install_period			int
,install_complete			int
,install_pend				int
)