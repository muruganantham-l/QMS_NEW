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
DENSE_RANK() over ( order by itm_mtr_doc_no ) [NUM], 
'' [EMPLOYEE ID],
isnull(itm_mtr_stk_locn ,'') [STOCK LOCATION],
itm_mtr_chg_costcenter [COST CENTER],
convert(varchar ,itm_mtr_rcv_date,120)  [RECEIVE DATE],
convert(varchar ,itm_mtr_rcv_date,120)  [GRN DATE],
isnull(itm_mtr_po_no ,'' ) [SOURCE],
isnull(itm_mtr_stockno ,'') [STOCK NUM],
itm_mtr_desc [STOCK DESCR],
itm_mtr_partno [PART NUM],
itm_mtr_rcv_uom [UOM],
isnull(puo_ls1_ord_qty,0) [PO QTY],
itm_mtr_rcv_qty [RECEIVE QTY],
0.0 [BALANCE QTY] ,
itm_mtr_item_cost [ITEM COST (RM)] ,
isnull(pur_mst_tot_cost,isnull(puo_mst_tot_cost,isnull(itm_mtr_item_cost ,0.0))) [TOTAL COST (RM)],
itm_mtr_doc_no [GRN NUM],
isnull(itm_mtr_pkg_slip_no ,'') [SUPPLIER DO NUM],
'' [SUPPLIER  INVOICE NUM],
isnull(pur_ls1_wo_no,isnull(puo_ls1_wo_no,isnull(itm_mtr_wo_no,''))) [WO NUM],
isnull(pur_ls1_mr_no ,'') [MR NUM],
isnull(pur_mst_porqnnum,isnull(puo_ls1_pr_no,isnull(itm_mtr_pr_no,''))) [PR NUM],
isnull(itm_mtr_supplier,'') [SUPPLIER NAME],
isnull(itm_mtr.audit_user,'') [GRN BY],
isnull(puo_det_terms,'')  [PO CREDIT TERM],
isnull(puo_mst_status,'') [PO STATUS],
isnull(puo_ls1_item_category,'') [PO TYPE]
FROM  
itm_mtr (nolock)
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
on  itm_mtr.rowid > 844
and itm_mtr.site_cd = 'QMS'
and itm_mtr.site_cd = puo.site_cd
and itm_mtr_po_no = puo_mst_po_no
and itm_mtr_po_lineno = puo_ls1_po_lineno
left join 
(select  pur_ls1.site_cd ,pur_ls1.mst_rowid , pur_mst_porqnnum,pur_mst_rqn_date ,pur_mst_chg_costcenter ,pur_mst_tot_cost , pur_ls1_pr_lineno , pur_ls1_po_no ,pur_ls1_po_lineno,pur_ls1_item_category,
pur_ls1_stockno,pur_ls1_stk_locn,pur_ls1_desc,pur_ls1_ord_uom,pur_ls1_ord_qty,pur_ls1_supplier, pur_ls1_item_cost ,pur_ls1_wo_no , pur_ls1_mr_no
from pur_mst (nolock),
pur_ls1 (nolock)
where pur_ls1.site_cd = 'QMS'
and pur_ls1.site_cd = pur_mst.site_cd
and pur_ls1.mst_rowid = pur_mst.rowid ) pur
on  itm_mtr.rowid > 844
and itm_mtr.site_cd = 'QMS'
and itm_mtr.site_cd = pur.site_cd
and pur_mst_porqnnum = puo_ls1_pr_no
and puo_ls1_pr_lineno = pur_ls1_pr_lineno
where  itm_mtr.rowid > 844
and convert(date,itm_mtr_rcv_date ) between @receivefrom and @receiveto



SELECT [NUM]
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

delete from qms_mmd_grn_tab
where Guid = @guid

end

