alter proc installment_batch_tbl_sp
@report_date date= '2019-03-07'
as
begin
set NOCOUNT ON

truncate table installment_batch_tbl_rpt
insert installment_batch_tbl_rpt (batch_no,clinic_category,installment_start_date,installment_end_date,tot_install_period,install_complete)
SELECT distinct ast_det_varchar21,ast_mst_asset_code,d.ast_det_datetime3,d.ast_det_datetime4
,datediff(month,d.ast_det_datetime3,d.ast_det_datetime4)+1,Datediff(mm,ast_det_datetime3,@report_date)+1
from   ast_det (NOLOCK) d 
join   ast_mst m (NOLOCK)
on m.RowID = d.mst_RowID
where  ast_det_varchar21 like 'batch%'
and ast_det_datetime3 is not NULL
and ast_det_datetime3 <= @report_date

UPDATE  installment_batch_tbl_rpt
set install_pend = tot_install_period - install_complete


SELECT  
row_number() over(order by batch_no,clinic_category) sno
,batch_no
,clinic_category
,convert(varchar(30),installment_start_date,103) 	installment_start_date
,convert(varchar(30),installment_end_date,103) installment_end_date
,tot_install_period
,install_complete
,install_pend

from installment_batch_tbl_rpt (NOLOCK) t
set nocount OFF
end

GO
exec installment_batch_tbl_sp
 