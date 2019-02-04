alter proc po_details_rpt_sp
@status varchar(300) = 'PO OPEN'
,@month_year varchar(100) = 'May-18'
--,@tran_type varchar(100) = 'pr'
as
begin

set nocount on

  
  

SELECT 
 replace(replace(replace(m.puo_mst_po_no			,char(9),''),char(10),''),char(13),'')		'PO No'
,replace(replace(replace(m.puo_mst_supplier			,char(9),''),char(10),''),char(13),'')		 'Supplier '
,replace(replace(replace(m.puo_mst_status				,char(9),''),char(10),''),char(13),'')		'Status'
,replace(replace(replace(m.puo_mst_po_grp			,char(9),''),char(10),''),char(13),'')			 'PO Type'
,replace(replace(replace(m.puo_mst_curr_code		,char(9),''),char(10),''),char(13),'')			'Currency Code'
,replace(replace(replace(format(m.puo_mst_po_date,'dd/MM/yyyy hh mm ss')		,char(9),''),char(10),''),char(13),'')				'PO Date'

,replace(replace(replace( format(m.puo_mst_po_expire_date,'dd/MM/yyyy hh mm ss')	,char(9),''),char(10),''),char(13),'')					 'Expire Date'

,replace(replace(replace(format(m.puo_mst_promised_date	,'dd/MM/yyyy hh mm ss')	,char(9),''),char(10),''),char(13),'')				'Delivery Date'
,replace(replace(replace(format(m.puo_mst_followup_date	,'dd/MM/yyyy hh mm ss')			,char(9),''),char(10),''),char(13),'')			'Follow-up Date'

 
,replace(replace(replace(l.puo_ls1_po_lineno		,char(9),''),char(10),''),char(13),'')				 'PO Line '
,replace(replace(replace(l.puo_ls1_item_category	,char(9),''),char(10),''),char(13),'')					 'Item Category '
,replace(replace(replace(l.puo_ls1_stockno			,char(9),''),char(10),''),char(13),'')				 'Stock No'
,replace(replace(replace(l.puo_ls1_description			,char(9),''),char(10),''),char(13),'')				 'Description '
,replace(replace(replace(l.puo_ls1_ord_uom	,char(9),''),char(10),''),char(13),'')						'Order UOM '
,replace(replace(replace(l.puo_ls1_item_cost				,char(9),''),char(10),''),char(13),'')						'Item Cost '


,replace(replace(replace(l.puo_ls1_suggest_qty			,char(9),''),char(10),''),char(13),'')										'Suggest Quantity '
 
,replace(replace(replace(l.puo_ls1_ord_qty			,char(9),''),char(10),''),char(13),'')										'Order Qty'
,replace(replace(replace(l.puo_ls1_rcv_qty		,char(9),''),char(10),''),char(13),'')								'Received Qty '

,replace(replace(replace(l.puo_ls1_invoice_qty		,char(9),''),char(10),''),char(13),'')								'RTS Qty '
,replace(replace(replace(l.puo_ls1_match_qty,char(9),''),char(10),''),char(13),'')										'Matched Qty '


,replace(replace(replace(l.puo_ls1_retail_price	,char(9),''),char(10),''),char(13),'')						'Retail Price '
,replace(replace(replace(l.puo_ls1_discount_pct		,char(9),''),char(10),''),char(13),'')							'Discount'
,replace(replace(replace(l.puo_ls1_discount_amt			,char(9),''),char(10),''),char(13),'')						'Discount Amount '
,replace(replace(replace(l.puo_ls1_net_price			,char(9),''),char(10),''),char(13),'')									 'Net Price '
,replace(replace(replace(l.puo_ls1_cur_code		,char(9),''),char(10),''),char(13),'')					'Currency Code '
,replace(replace(replace(l.puo_ls1_cur_exchange_rate			,char(9),''),char(10),''),char(13),'')								'Currency Rate '
,replace(replace(replace(l.puo_ls1_stk_locn		,char(9),''),char(10),''),char(13),'')					 'Stock Location '
,replace(replace(replace(l.puo_ls1_chg_costcenter			,char(9),''),char(10),''),char(13),'')							'Charge Cost Center '

,replace(replace(replace(l.puo_ls1_chg_account			,char(9),''),char(10),''),char(13),'')	 'Charge Account '
,replace(replace(replace(l.puo_ls1_req_date			,char(9),''),char(10),''),char(13),'')	 'Require Date '
 ,replace(replace(replace(cast(l.puo_ls1_ext_description		as nvarchar(max))	,char(9),''),char(10),''),char(13),'')	 'Extended Description '

  ,replace(replace(replace(l.puo_ls1_wo_no			,char(9),''),char(10),''),char(13),'')	 'WO No '
   ,replace(replace(replace(l.puo_ls1_pr_no			,char(9),''),char(10),''),char(13),'')	 'PR No '
    ,replace(replace(replace(l.puo_ls1_pr_lineno			,char(9),''),char(10),''),char(13),'')	 'PR Line '
	 ,replace(replace(replace(l.puo_ls1_mr_lineno			,char(9),''),char(10),''),char(13),'')	 'MR No '
	  ,replace(replace(replace(format(l.puo_ls1_clo_date ,'dd/MM/yyyy hh mm ss')				,char(9),''),char(10),''),char(13),'')	 'Last Received Date '

from puo_mst m (NOLOCK)
join puo_ls1 l (NOLOCK) on m.RowID = l.mst_RowID
 
---- left(m.puo_mst_chg_costcenter,3)  !=left(l.pur_ls1_chg_costcenter,3)
----and left(l.pur_ls1_stk_locn,3) != left(m.puo_mst_chg_costcenter,3)
--  YEAR(puo_mst_rqn_date) = 2018
--  and puo_mst_chg_costcenter like '%-TSD-001'

join pr_pending_rpt_tbl (NOLOCK) w on  w.po_no = m.puo_mst_po_no
 and (w.po_status = @status or w.supp_name = @status)
 and w.month_year = @month_year

  
set nocount OFF
end

