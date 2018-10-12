--exec Sp_Grn_Report_out 'PERAK','PRK-001-0001','2015-07-10', '2017-07-12'
Alter procedure Sp_Grn_Report_out
@state nvarchar(100),
@location nvarchar(100),
@receivefrom date ,
@receiveto date
as 
begin

Declare @Guid varchar(100)

select @guid = newid()

if @state in ('ALL','0','')
begin 
	select @state = '%'
end
else
begin 
	select @state = '%'+@state
end

if @location in ('ALL','0','')
begin 
	select @location = '%'
end
else
begin 
	select @location = '%'+@location
end

/*
select 
@guid,
DENSE_RANK() over ( order by itm_trx_grn_no ) [NUM], 
'' [STATE NAME],
isnull(itm_trx_rcv_empl_id,'') [EMPLOYEE ID],
isnull(itm_trx_stk_locn ,'') [STOCK LOCATION],
itm_trx_chg_costcenter [COST CENTER],
convert(varchar ,itm_trx_trx_date,120)  [RECEIVE DATE],
convert(varchar ,itm_trx_curr_date,120)  [GRN DATE],
isnull(itm_trx_pono ,'' ) [SOURCE],
isnull(itm_trx_stockno ,'') [STOCK NUM],
itm_trx_desc [STOCK DESCR],
itm_trx_partno [PART NUM],
itm_trx_uom [UOM],
isnull(puo_ls1_ord_qty,0) [PO QTY],
itm_trx_rcv_qty [RECEIVE QTY],
0.0 [BALANCE QTY] ,
itm_trx_item_cost [ITEM COST (RM)] ,
isnull(pur_mst_tot_cost,isnull(puo_mst_tot_cost,isnull(itm_trx_ext_cost ,0.0))) [TOTAL COST (RM)],
itm_trx_grn_no [GRN NUM],
isnull(itm_trx_pkg_slip_no ,'') [SUPPLIER DO NUM],
'' [SUPPLIER  INVOICE NUM],
isnull(pur_ls1_wo_no,isnull(puo_ls1_wo_no,isnull(itm_trx_wo,''))) [WO NUM],
isnull(pur_ls1_mr_no ,'') [MR NUM],
isnull(pur_mst_porqnnum,isnull(puo_ls1_pr_no,isnull(itm_trx_porqnnum,''))) [PR NUM],
isnull(itm_trx_supplier,'') [SUPPLIER NAME],
isnull(itm_trx_login_id,'') [GRN BY],
isnull(puo_det_terms,'')  [PO CREDIT TERM],
isnull(puo_mst_status,'') [PO STATUS],
isnull(puo_ls1_item_category,'') [PO TYPE]
FROM  
(select * from itm_trx (nolock) 
where itm_trx.site_cd = 'QMS'
and itm_trx_trx_type = 'MT41'
and itm_trx_doc_no in (select itm_mtr_doc_no from itm_mtr (nolock) where itm_mtr.rowid > 844
and itm_mtr.site_cd = 'QMS')) itm_trx
left join 
(select  puo_mst.site_cd ,puo_ls1.mst_rowid , puo_mst_po_no ,puo_mst_status,puo_mst_po_date ,puo_mst_supplier ,puo_mst_tot_cost , puo_ls1_po_lineno , puo_ls1_pr_no ,puo_ls1_pr_lineno,puo_ls1_ord_uom,puo_det_terms,
puo_ls1_stockno,puo_ls1_stk_locn,puo_ls1_description,puo_ls1_item_category,puo_ls1_ord_qty,puo_ls1_chg_costcenter, puo_ls1_item_cost ,puo_ls1_invoice_qty,puo_ls1_inv_total_cost , puo_ls1_wo_no
from puo_mst (nolock),
puo_ls1 (nolock) ,
puo_det (nolock)
where puo_ls1.site_cd = 'QMS'
and puo_ls1.site_cd = puo_mst.site_cd
and puo_ls1.mst_rowid = puo_mst.rowid 
and puo_det.site_cd = puo_mst.site_cd
and puo_det.mst_rowid = puo_mst.rowid  ) puo
on   itm_trx.site_cd = 'QMS'
and itm_trx.site_cd = puo.site_cd
and itm_trx_pono = puo_mst_po_no
and itm_trx_po_lineno = puo_ls1_po_lineno
left join 
(select  pur_ls1.site_cd ,pur_ls1.mst_rowid , pur_mst_porqnnum,pur_mst_rqn_date ,pur_mst_chg_costcenter ,pur_mst_tot_cost , pur_ls1_pr_lineno , pur_ls1_po_no ,pur_ls1_po_lineno,pur_ls1_item_category,
pur_ls1_stockno,pur_ls1_stk_locn,pur_ls1_desc,pur_ls1_ord_uom,pur_ls1_ord_qty,pur_ls1_supplier, pur_ls1_item_cost ,pur_ls1_wo_no , pur_ls1_mr_no
from pur_mst (nolock),
pur_ls1 (nolock)
where pur_ls1.site_cd = 'QMS'
and pur_ls1.site_cd = pur_mst.site_cd
and pur_ls1.mst_rowid = pur_mst.rowid ) pur
on  itm_trx.site_cd = 'QMS'
and itm_trx.site_cd = pur.site_cd
and pur_mst_porqnnum = puo_ls1_pr_no
and puo_ls1_pr_lineno = pur_ls1_pr_lineno
where   convert(date,itm_trx.itm_trx_trx_date ) between @receivefrom and @receiveto
*/

insert into qms_mmd_grn_tab 
([GUID]
,[NUM]
,[STATE NAME]
,[EMPLOYEE ID]
,[STOCK LOCATION]
,[COST CENTER]
,[RECEIVE DATE]
,[GRN DATE]
,[SOURCE]
,[STOCK NUM]
,[STOCK DESCR]
,[PART NUM]
,[UOM]
,[PO QTY]
,[RECEIVE QTY]
,[BALANCE QTY]
,[ITEM COST (RM)]
,[TOTAL COST (RM)]
,[GRN NUM]
,[SUPPLIER DO NUM]
,[SUPPLIER  INVOICE NUM]
,[WO NUM]
,[MR NUM]
,[PR NUM]
,[SUPPLIER NAME]
,[GRN BY]
,[PARTS DELIVERED BY]
,[DELIVERY STATUS]
--,[INVOICE NUM]
--,[INVOICE STATUS]
--,[INVOICE UPDATE BY]
,[RTS QTY]
,[RTS VALUE (RM)]
,[PO CREDIT TERM]
,[PO STATUS]
,[PO TYPE]
,[PO INVOICE CLOSE DATE]
,[AGING RECEIVE DATE TO GRN]
)

select 
@guid,
DENSE_RANK() over ( order by itm_trx_grn_no ) [NUM], 
NULL [STATE NAME],
isnull(itm_trx_rcv_empl_id,'') [EMPLOYEE ID],
isnull(itm_trx_stk_locn ,'') [STOCK LOCATION],
itm_trx_chg_costcenter [COST CENTER],
convert(varchar ,itm_trx_trx_date,120)  [RECEIVE DATE],
convert(varchar ,itm_trx_curr_date,120)  [GRN DATE],
isnull(itm_trx_pono ,'' ) [SOURCE],
isnull(itm_trx_stockno ,'') [STOCK NUM],
itm_trx_desc [STOCK DESCR],
itm_trx_partno [PART NUM],
itm_trx_uom [UOM],
isnull(puo_ls1_ord_qty,0) [PO QTY],
itm_trx_rcv_qty [RECEIVE QTY],
isnull(puo_ls1_bo_qty,0.0) [BALANCE QTY] ,
itm_trx_item_cost [ITEM COST (RM)] ,
isnull(pur_mst_tot_cost,isnull(puo_mst_tot_cost,isnull(itm_trx_ext_cost ,0.0))) [TOTAL COST (RM)],
itm_trx_grn_no [GRN NUM],
isnull(itm_trx_pkg_slip_no ,'') [SUPPLIER DO NUM],
'' [SUPPLIER  INVOICE NUM],
isnull(pur_ls1_wo_no,isnull(puo_ls1_wo_no,isnull(itm_trx_wo,''))) [WO NUM],
isnull(pur_ls1_mr_no ,'') [MR NUM],
isnull(pur_mst_porqnnum,isnull(puo_ls1_pr_no,isnull(itm_trx_porqnnum,''))) [PR NUM],
isnull(itm_trx_supplier,'') [SUPPLIER NAME],
isnull(itm_trx_login_id,'') [GRN BY],
isnull(itm_trx_remark,'') [PARTS DELIVERED BY] ,
isnull(pur_det_varchar3,'') [DELIVERY STATUS] ,
isnull(itm_trx_rtn_qty,0.0) [RTS QTY],
(isnull(itm_trx_item_cost,0.0) * isnull(itm_trx_rtn_qty,0.0))  [RTS VALUE (RM)],
isnull(puo_det_terms,'')  [PO CREDIT TERM],
isnull(puo_mst_status,'') [PO STATUS],
isnull(pur_ls1_chg_account,'') [PO TYPE],
NULL [PO INVOICE CLOSE DATE],
[dbo].[noofworkingdays](itm_trx_trx_date,itm_trx_curr_date) dateofdiff

FROM  
(select * from itm_trx (nolock) 
where itm_trx.site_cd = 'QMS'
and itm_trx_trx_type = 'MT41'
and itm_trx_doc_no in (select itm_mtr_doc_no from itm_mtr (nolock) where itm_mtr.rowid > 844
and itm_mtr.site_cd = 'QMS')) itm_trx
left join 
(select  puo_mst.site_cd ,puo_ls1.mst_rowid , puo_mst_po_no ,puo_mst_status,puo_mst_po_date ,puo_mst_supplier ,puo_mst_tot_cost , puo_ls1_po_lineno , puo_ls1_pr_no ,puo_ls1_pr_lineno,puo_ls1_ord_uom,puo_det_terms,
puo_ls1_stockno,puo_ls1_stk_locn,puo_ls1_description,puo_ls1_item_category,puo_ls1_ord_qty,puo_ls1_bo_qty,puo_ls1_chg_costcenter, puo_ls1_item_cost ,puo_ls1_invoice_qty,puo_ls1_inv_total_cost , puo_ls1_wo_no
from puo_mst (nolock),
puo_ls1 (nolock) ,
puo_det (nolock)
where puo_ls1.site_cd = 'QMS'
and puo_ls1.site_cd = puo_mst.site_cd
and puo_ls1.mst_rowid = puo_mst.rowid 
and puo_det.site_cd = puo_mst.site_cd
and puo_det.mst_rowid = puo_mst.rowid  ) puo
on   itm_trx.site_cd = 'QMS'
and itm_trx.site_cd = puo.site_cd
and itm_trx_pono = puo_mst_po_no
and itm_trx_po_lineno = puo_ls1_po_lineno
left join 
(select  pur_ls1.site_cd ,pur_ls1.mst_rowid , pur_mst_porqnnum,pur_mst_rqn_date ,pur_mst_chg_costcenter ,pur_mst_chg_account,pur_mst_tot_cost , pur_ls1_pr_lineno , pur_ls1_po_no ,pur_ls1_po_lineno,pur_ls1_item_category,
pur_ls1_stockno,pur_ls1_stk_locn,pur_ls1_desc,pur_ls1_chg_account,pur_ls1_ord_uom,pur_ls1_ord_qty,pur_ls1_supplier, pur_ls1_item_cost ,pur_ls1_wo_no , pur_ls1_mr_no , pur_det_varchar2 ,pur_det_varchar3
from pur_mst (nolock),
pur_ls1 (nolock),
pur_det (nolock)
where pur_ls1.site_cd = 'QMS'
and pur_ls1.site_cd = pur_mst.site_cd
and pur_ls1.mst_rowid = pur_mst.rowid
and pur_det.site_cd = pur_mst.site_cd
and pur_det.mst_rowid = pur_mst.rowid  
) pur
on  itm_trx.site_cd = 'QMS'
and itm_trx.site_cd = pur.site_cd
and pur_mst_porqnnum = puo_ls1_pr_no
and puo_ls1_pr_lineno = pur_ls1_pr_lineno
where   convert(date,itm_trx.itm_trx_trx_date ) between @receivefrom and @receiveto
order by itm_trx_grn_no,pur_ls1_pr_lineno


/*Update state name */

update tab
set [STATE NAME] = 'PULAU PINANG KOLEJ' 
from 
qms_mmd_grn_tab  tab (NOLOCK) ,
(select [GRN NUM]
from 
qms_mmd_grn_tab  tab (NOLOCK)
where [Guid] = @Guid
and [COST CENTER] like 'PNG500%' ) tab2
where tab.[GRN NUM] = tab2.[GRN NUM]
and  [Guid] = @Guid 

/*Update Finance Code */
update tab
set [PO TYPE] = account+' - ' + descs 
from 
qms_mmd_grn_tab  tab (NOLOCK),
cf_account mst (NOLOCK)
where [Guid] = @Guid
and [PO TYPE] is NOT NULL
and [PO TYPE] = account

/*Update state name */

update tab
set [STATE NAME] = SatateDesc 
from 
qms_mmd_grn_tab  tab (NOLOCK),
(select [GRN NUM],mst.Statecode , SatateDesc
from 
qms_mmd_grn_tab  tab (NOLOCK),
inv_trans_Location_det det (nolock),
inv_trans_Location_mst mst (nolock)
where [Guid] = @Guid
and tab.[STOCK LOCATION] = Stocklocation
and Stocklocation like @location
and det.Statecode = mst.Statecode
and [STATE NAME] is NULL
)tab2
where tab.[GRN NUM] = tab2.[GRN NUM]
and  [Guid] = @Guid
and [STATE NAME] is NULL


/*Update state name */
if @location = '%'
begin
	update tab
	set [STATE NAME] = Statedesc 
	from 
	qms_mmd_grn_tab  tab (NOLOCK),
	inventory_location_mst mst (NOLOCK)
	where [Guid] = @Guid
	and [STATE NAME] is NULL
	and left([COST CENTER],3 ) = StateCode
end
else
begin 
	Delete from qms_mmd_grn_tab 
	where [Guid] = @Guid
	and [STATE NAME] is NULL
end

/*Update Supplier name*/

update tab
set [SUPPLIER NAME] = sup_mst_desc
from qms_mmd_grn_tab  tab (NOLOCK),
	sup_mst mst (NOLOCK)
	where [Guid] = @Guid
	and [SUPPLIER NAME] = sup_mst_supplier_cd 
	and site_cd = 'QMS'

/* Update Invoice Number and details */

update tab
set [SUPPLIER  INVOICE NUM] = siv_mst_sup_inv_no ,
	[INVOICE NUM] = siv_mst_inv_no ,
	[INVOICE STATUS] =	siv_ls2_varchar2 ,
	[INVOICE UPDATE BY]	= siv_ls2_varchar3 ,
	[PO INVOICE CLOSE DATE]= convert(varchar,siv_mst_create_date,120)
from qms_mmd_grn_tab  tab (NOLOCK),
	siv_mst mst (NOLOCK) , 
	siv_ls2 ls2 (NOLOCK)
	where [Guid] = @Guid
	and mst.site_cd = 'QMS'
	and mst.site_cd = ls2.site_cd
	and mst.rowid = ls2.mst_rowid
	and mst.siv_mst_inv_no = ls2.siv_ls2_varchar1
	and [SOURCE] = siv_mst_po_no 
	and [SOURCE] is not NULL

/*Update GRN By name*/

update tab
set [GRN BY] = emp_mst_name
from qms_mmd_grn_tab  tab (NOLOCK),
	emp_mst mst (NOLOCK)
	where [Guid] = @Guid
	and [GRN BY] = emp_mst_login_id 
	and site_cd = 'QMS'

/*Update Employee Receive by  name*/

update tab
set [EMPLOYEE ID] = emp_mst_name
from qms_mmd_grn_tab  tab (NOLOCK),
	emp_mst mst (NOLOCK)
	where [Guid] = @Guid
	and [EMPLOYEE ID] = emp_mst_login_id 
	and site_cd = 'QMS'

/*Update Invoice status update By name*/

update tab
set [INVOICE UPDATE BY] = emp_mst_name
from qms_mmd_grn_tab  tab (NOLOCK),
	emp_mst mst (NOLOCK)
	where [Guid] = @Guid
	and [INVOICE UPDATE BY] = emp_mst_login_id 
	and site_cd = 'QMS'

update qms_mmd_grn_tab
set [SOURCE] = 'MISC'
where [Guid] = @Guid
and isnull([SOURCE],'') = ''		

update qms_mmd_grn_tab
set [DELIVERY STATUS] = 'Fully Received'
where [Guid] = @Guid
and isnull([PO STATUS],'') = 'CL'	

update qms_mmd_grn_tab
set [DELIVERY STATUS] = 'Partialy Received'
where [Guid] = @Guid
and isnull([PO STATUS],'') = 'APP'	


update tab
set [PART NUM] = itm_mst_partno
from qms_mmd_grn_tab  tab (NOLOCK),
	itm_mst mst (NOLOCK)
	where [STOCK NUM] = itm_mst_stockno 
	and site_cd = 'QMS'
	and [Guid] = @Guid

/*Select statement for Required Columns*/

SELECT [NUM]
,[STATE NAME]
,[EMPLOYEE ID]
,[STOCK LOCATION]
,[COST CENTER]
,[RECEIVE DATE]
,[GRN DATE]
,[AGING RECEIVE DATE TO GRN]
,[SOURCE]
,[STOCK NUM]
,[STOCK DESCR]
,[PART NUM]
,[UOM]
,[PO QTY]
,[RECEIVE QTY]
,[BALANCE QTY]
,[ITEM COST (RM)]
,[TOTAL COST (RM)]
,[GRN NUM]
,[SUPPLIER DO NUM]
,[SUPPLIER  INVOICE NUM]
,[WO NUM]
,[MR NUM]
,[PR NUM]
,[SUPPLIER NAME]
,[GRN BY]
,[DELIVERY STATUS]
,[PARTS DELIVERED BY]
,[INVOICE NUM]
,[PO INVOICE CLOSE DATE]
,[INVOICE STATUS]
,[INVOICE UPDATE BY]
,[RTS QTY]
,[RTS VALUE (RM)]
,[PO CREDIT TERM]
,[PO STATUS]
,[PO TYPE]
 FROM qms_mmd_grn_tab  (NOLOCK)
 where Guid = @guid
 and [STATE NAME] like @state
 order by [GRN NUM]

delete from qms_mmd_grn_tab
where Guid = @guid

end


--Alter table qms_mmd_grn_tab
--add [STATE NAME] varchar(100)

----Alter FUNCTION [dbo].[noofworkingdays]
----(
----    @StartDate as DATETIME, @EndDate as DATETIME
----)
----RETURNS INT
----AS
----BEGIN
    
----Declare @TotalworkDays int
----Declare @intTotalDaysNumber int 
----Declare @intTotalSundaysNumber int 
----Declare @intTotalSaturdaysNumber int 

----select @intTotalDaysNumber		= datediff(day,@StartDate,@EndDate)  
----select @intTotalSundaysNumber	=  (datediff(day, 7, @EndDate)/7 - datediff(day, 6, @StartDate)/7) 
----select @intTotalSaturdaysNumber =  (datediff(day, 6, @EndDate)/7 - datediff(day, 5, @StartDate)/7 )
----select @TotalworkDays = @intTotalDaysNumber	 -@intTotalSundaysNumber 	-@intTotalSaturdaysNumber
    
----	Return @TotalworkDays
----END

--select dbo.[noofworkingdays] ('2017-08-07','2017-08-10')

--select itm_trx_doc_no ,itm_trx_stk_locn ,  itm_trx_pono , itm_trx_stockno , datediff(dd,itm_trx_trx_date,itm_trx_curr_date  ) from itm_trx where  itm_trx_trx_type ='MT41' and datediff(dd,itm_trx_trx_date,itm_trx_curr_date  )  > 10

