SELECT 
 replace(replace(replace(m.pur_mst_porqnnum			,char(9),''),char(10),''),char(13),'')		'PR No'
,replace(replace(replace(m.pur_mst_status			,char(9),''),char(10),''),char(13),'')		 'Status'
,replace(replace(replace(format(m.pur_mst_rqn_date	,'dd/MM/yyyy hh:mm:ss')			,char(9),''),char(10),''),char(13),'')		'Request Date'
,replace(replace(replace(format(m.pur_mst_req_date	,'dd/MM/yyyy hh:mm:ss')			,char(9),''),char(10),''),char(13),'')			 'Required Date'
,replace(replace(replace(m.pur_mst_requested_by		,char(9),''),char(10),''),char(13),'')			'Requested By'
,replace(replace(replace(m.pur_mst_entered_by		,char(9),''),char(10),''),char(13),'')				'Entered By'
,replace(replace(replace( m.pur_mst_chg_costcenter	,char(9),''),char(10),''),char(13),'')					 'Cost Center'
,replace(replace(replace(m.pur_mst_chg_account		,char(9),''),char(10),''),char(13),'')				'Financial Code'
,replace(replace(replace(m.pur_mst_dept				,char(9),''),char(10),''),char(13),'')			'Department'
,replace(replace(replace(m.pur_mst_notes			,char(9),''),char(10),''),char(13),'')					'PR Category'
,replace(replace(replace(m.pur_mst_sub_tot_cost		,char(9),''),char(10),''),char(13),'')					'Sub Total'
,replace(replace(replace(l.pur_ls1_pr_lineno		,char(9),''),char(10),''),char(13),'')				 'PR Line No'
,replace(replace(replace(l.pur_ls1_item_category	,char(9),''),char(10),''),char(13),'')					 'Item Category'
,replace(replace(replace(l.pur_ls1_stockno			,char(9),''),char(10),''),char(13),'')				 'Stock No'
,replace(replace(replace(l.pur_ls1_supplier			,char(9),''),char(10),''),char(13),'')				 'Supplier'
,replace(replace(replace(l.pur_ls1_last_item_cost	,char(9),''),char(10),''),char(13),'')						'Last Purchase Cost'
,replace(replace(replace(l.pur_ls1_desc				,char(9),''),char(10),''),char(13),'')						'Description'
,replace(replace(replace(l.pur_ls1_ord_uom			,char(9),''),char(10),''),char(13),'')										'Order UOM'
,replace(replace(replace(l.pur_ls1_cur_code			,char(9),''),char(10),''),char(13),'')							'Currency Code'
,replace(replace(replace(l.pur_ls1_ord_qty			,char(9),''),char(10),''),char(13),'')										'Order Qty'
,replace(replace(replace(l.pur_ls1_retail_price		,char(9),''),char(10),''),char(13),'')								'Retail Price'
,replace(replace(replace(l.pur_ls1_item_cost		,char(9),''),char(10),''),char(13),'')								'Item Cost'
,replace(replace(replace(l.pur_ls1_cur_exchange_rate,char(9),''),char(10),''),char(13),'')										'Currency Rate'
,replace(replace(replace(l.pur_ls1_chg_costcenter	,char(9),''),char(10),''),char(13),'')						'Charge Cost Center'
,replace(replace(replace(l.pur_ls1_chg_account		,char(9),''),char(10),''),char(13),'')							'Charge Account'
,replace(replace(replace(l.pur_ls1_wo_no			,char(9),''),char(10),''),char(13),'')						'WO No'
,replace(replace(replace(l.pur_ls1_po_no			,char(9),''),char(10),''),char(13),'')									 'PO No'
,replace(replace(replace(l.pur_ls1_po_lineno		,char(9),''),char(10),''),char(13),'')					'PO Line No'
,replace(replace(replace(l.pur_ls1_mr_no			,char(9),''),char(10),''),char(13),'')								'MR No'
,replace(replace(replace(l.pur_ls1_mr_lineno		,char(9),''),char(10),''),char(13),'')					 'MR No'
,replace(replace(replace(l.pur_ls1_stk_locn			,char(9),''),char(10),''),char(13),'')							'Stock Location'
from pur_mst m (NOLOCK)
join pur_ls1 l (NOLOCK) on m.RowID = l.mst_RowID
where 
-- left(m.pur_mst_chg_costcenter,3)  !=left(l.pur_ls1_chg_costcenter,3)
--and left(l.pur_ls1_stk_locn,3) != left(m.pur_mst_chg_costcenter,3)
  YEAR(pur_mst_rqn_date) = 2018
  and pur_mst_chg_costcenter like '%-TSD-001'
