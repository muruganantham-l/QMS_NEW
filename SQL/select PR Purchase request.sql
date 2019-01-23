SELECT m.pur_mst_porqnnum 'PR No'
,m.pur_mst_status 'Status'
,m.pur_mst_rqn_date 'Request Date'
,m.pur_mst_req_date 'Required Date'
,m.pur_mst_requested_by 'Requested By'
,m.pur_mst_entered_by 'Entered By'
, m.pur_mst_chg_costcenter 'Cost Center'
,m.pur_mst_chg_account 'Financial Code'
,m.pur_mst_dept 'Department'
,m.pur_mst_notes 'PR Category'
,m.pur_mst_sub_tot_cost 'Sub Total'
,l.pur_ls1_pr_lineno 'PR Line No'
,l.pur_ls1_item_category 'Item Category'
,l.pur_ls1_stockno 'Stock No'
,l.pur_ls1_supplier 'Supplier'
,l.pur_ls1_last_item_cost 'Last Purchase Cost'
,l.pur_ls1_desc 'Description'
,l.pur_ls1_ord_uom 'Order UOM'
,l.pur_ls1_cur_code 'Currency Code'
,l.pur_ls1_ord_qty 'Order Qty'
,l.pur_ls1_retail_price 'Retail Price'
,l.pur_ls1_item_cost 'Item Cost'
,l.pur_ls1_cur_exchange_rate 'Currency Rate'


,l.pur_ls1_chg_costcenter 'Charge Cost Center'
,l.pur_ls1_chg_account 'Charge Account'
,l.pur_ls1_wo_no 'WO No'
,l.pur_ls1_po_no 'PO No'
,l.pur_ls1_po_lineno 'PO Line No'
,l.pur_ls1_mr_no 'MR No'
,l.pur_ls1_mr_lineno 'MR No'
,l.pur_ls1_stk_locn 'Stock Location'
from pur_mst m (NOLOCK)
join pur_ls1 l (NOLOCK) on m.RowID = l.mst_RowID
where  left(m.pur_mst_chg_costcenter,3)  !=left(l.pur_ls1_chg_costcenter,3)
and left(l.pur_ls1_stk_locn,3) != left(m.pur_mst_chg_costcenter,3)
and YEAR(pur_mst_rqn_date) = 2018

