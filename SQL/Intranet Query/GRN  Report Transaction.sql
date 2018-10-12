Alter procedure Sp_Grn_Report_out
@state nvarchar(100),
@receivefrom date ,
@receiveto date
as 
begin

Declare @Guid varchar(100)

select @guid = newid()

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
--,[DELIVERY STATUS]
--,[PARTS DELIVERED BY]
--,[INVOICE NUM]
--,[PO INVOICE CLOSE DATE]
--,[INVOICE STATUS]
--,[INVOICE UPDATE BY]
--,[RTS QTY]
--,[RTS VALUE (RM)]
,[PO CREDIT TERM]
,[PO STATUS]
,[PO TYPE])

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


SELECT [NUM]
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
,[AGING RECEIVE DATE TO GRN]
 FROM qms_mmd_grn_tab  (NOLOCK)
 where Guid = @guid
 order by [NUM]

--delete from qms_mmd_grn_tab
--where Guid = @guid

end


--Alter table qms_mmd_grn_tab
--add [STATE NAME] varchar(100)

Create Table inventory_location_mst
(
Row_id int identity(1,1),
StateCode varchar(50),
Statedesc varchar(100),
Costcenter varchar(100),

createby varchar(100) Default 'Patch',
Createdate datetime default getdate()
)

insert into inventory_location_mst (StateCode,Statedesc)
select Statecode , SatateDesc from  Report_location_mst
----Stock_location_mst
