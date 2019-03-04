ALTER proc inventry_mst_stk_mvmt_rpt_sp
@itemcode  varchar(250)
,@stk_locn varchar(250) 
as
begin
set nocount ON

delete from inventry_mst_stk_mvmt_rpt_tbl

insert inventry_mst_stk_mvmt_rpt_tbl
(
 [Item code]
,[Description]
,[Stock Location]
,[Rcv Transaction date]
,[Rec PO no]
,[Rcv Stock location]
,[Received Qty]
,[Ret Transaction date]
,[CWO no]
,[Ret Stock location]
,[Ret Qty]
,[Ret Sup Transaction date]
,[Ret Sup PO no]
,[Ret Sup Stock location]
,[Ret Sup Qty]
,[Trf Transaction date]
,[Trf Stock location]
,[To stock location]
,[Trf Qty]
)

SELECT
 itm_mst_stockno	
,itm_mst_desc	
,itm_loc_stk_loc
,itm_trx_trx_date	
,itm_trx_pono	
,itm_loc_stk_loc	
,itm_trx_rcv_qty	
,itm_trx_trx_date	
,itm_trx_wo	
,itm_loc_stk_loc	
,itm_trx_rtn_qty	
,itm_trx_trx_date	
,itm_trx_pono	
,itm_loc_stk_loc	
,itm_trx_rtn_qty	
,itm_trx_trx_date	
,itm_trx_stk_location

,NULL,null


from itm_mst m (NOLOCK)
join itm_loc l (NOLOCK)
on	m.RowID = l.mst_RowID
and m.site_cd = l.site_cd
join itm_trx t (NOLOCK)
on m.RowID = t.


select * 
from   inventry_mst_stk_mvmt_rpt_tbl (NOLOCK)



set nocount OFF
end