select 
itm_trx_doc_no , itm_trx_trx_date , itm_trx_curr_date , itm_trx_isu_empl_id , itm_trx_stockno , 
replace(replace(itm_trx_desc,char(13),''),char(10),'') itmdesc, itm_trx_chg_costcenter ,itm_trx_stk_locn, itm_trx_to_stk_locn , itm_trx_item_cost,itm_trx_uom, itm_trx_rcv_qty , itm_trx_isu_qty 
from itm_trx (nolock) 
where itm_trx.site_cd = 'QMS'
and itm_trx_trx_type = 'MT61'
and itm_trx_stockno like 'STK%'