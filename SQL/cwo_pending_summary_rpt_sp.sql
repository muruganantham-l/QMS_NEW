alter proc cwo_pending_summary_rpt_sp
as
begin
set nocount ON
--alter table wo_pr_pending_rpt_tbl drop column number_of_wo
--drop table wo_pr_pending_rpt_tbl
--create table wo_pr_pending_rpt_tbl
--(

--wo_state		varchar(200)
--,month_year		varchar(50)
----,number_of_wo   int
--,wo_date		datetime
--,wo_no			varchar(50)
--,col_order  int
--)

--alter table wo_pr_pending_rpt_tbl add col_order  int

--alter table wo_pr_pending_rpt_tbl drop column supp_nsme
truncate table wo_pr_pending_rpt_tbl
truncate table pr_pending_rpt_tbl

insert wo_pr_pending_rpt_tbl
(
wo_state
,month_year
--,number_of_wo
,wo_no
,wo_date
--,supp_name
,col_order
)
SELECT m.wko_mst_asset_level,left(Datename(MONTH,wko_mst_org_date),3)+'-'+right(YEAR(wko_mst_org_date),2),m.wko_mst_wo_no ,m.wko_mst_org_date,DENSE_RANK() over( order by eomonth(m.wko_mst_org_date))
--,dense_rank() over(PARTITION by left(Datename(MONTH,wko_mst_org_date),3)+'-'+right(YEAR(wko_mst_org_date),2) order by  wko_mst_org_date) rpt_order_no
from wko_mst m (NOLOCK) 
join wko_det d (NOLOCK) 
on m.RowID  = d.mst_RowID
and m.wko_mst_status in ('ope','rfs')
and left(wko_mst_wo_no,3) = 'CWO'
and Year(wko_mst_org_date) >= year(getdate())-1
--group by  m.wko_mst_asset_level,left(Datename(MONTH,wko_mst_org_date),3)+'-'+right(YEAR(wko_mst_org_date),2)

insert pr_pending_rpt_tbl
(
pr_status
,month_year
,pr_no
,col_order
,po_no
)

SELECT
case when pur_mst_porqnnum is not null then 'PR' else 'NO PR' end pr_status
,month_year
,m.pur_mst_porqnnum 
,col_order
,pur_ls1_po_no
from pur_mst m (NOLOCK)  join pur_ls1 l (NOLOCK)  
on m.RowID = l.mst_RowID right join wo_pr_pending_rpt_tbl t on t.wo_no = l.pur_ls1_wo_no


--update t set pr_no = m.pur_mst_porqnnum  ,po_no = l.pur_ls1_po_no  ,pr_status = 'PR'
--from pur_mst m (NOLOCK)  join pur_ls1 l (NOLOCK)  
--on m.RowID = l.mst_RowID join wo_pr_pending_rpt_tbl t on t.wo_no = l.pur_ls1_wo_no

update t set supp_name = m.puo_mst_supplier,po_status = m.puo_mst_status from 
puo_mst m (nolock) 
join  pr_pending_rpt_tbl t on t.po_no = m.puo_mst_po_no  

update t set supp_name = m.sup_mst_desc from pr_pending_rpt_tbl t join sup_mst m on m.sup_mst_supplier_cd = t.supp_name
 

--update wo_pr_pending_rpt_tbl set pr_status = 'NO PR' where pr_no is   null

update t set po_status = 'PO '+case when  puo_sts_status_type = 'cancel' then null else puo_sts_status_type end
 
from pr_pending_rpt_tbl t (nolock)
join puo_sts s (NOLOCK)
on t.po_status = s.puo_sts_status

--sup_mst_supplier_cd

--alter table wo_pr_pending_rpt_tbl add po_status varchar(30)
update t set wo_state = statecode from Stock_Location_mst_report s join pr_pending_rpt_tbl t on t.wo_state = s.SatateDesc
--alter table wo_pr_pending_rpt_tbl drop column p0_status 
SELECT * from wo_pr_pending_rpt_tbl order by col_order, wo_state,wo_date

 set nocount OFF
end


--WILAYAH PERSEKUTUAN
--WILAYAH PERSEKUTUAN LABUAN

--WILAYAH PERSEKUTUAN KUALA LUMPUR

--update m set  wko_mst_chg_costcenter = 'WKL056-P-KUL', wko_mst_asset_level = 'WILAYAH PERSEKUTUAN KUALA LUMPUR' from wko_mst m  where wko_mst_wo_no = 'CWO188143'

--go 

--exec cwo_pending_summary_rpt_sp

 