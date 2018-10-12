update itm_mtc
set itm_mtc_stk_locn ='DEN-LAB-0001' 
 WHERE site_cd = 'QMS' 
AND itm_mtc_stockno in (select itm_mst_stockno from itm_mst where itm_mst_mstr_locn = 'DEN-LAB-0001')
AND itm_mtc_stk_locn ='HQ-TSD-001' 
and itm_mtc_stockno not in ('STK108339')

select itm_mst_stockno from 
itm_mst , itm_loc 
where itm_mst.rowid = mst_rowid and itm_mst_mstr_locn = 'DEN-LAB-0001'
and itm_loc_stk_loc = 'HQ-TSD-001' 


Select itm_mtc_stockno, itm_mtc_stk_locn, COALESCE ( sum ( itm_mtc_rcv_qty - itm_mtc_isu_qty ) , 0 ) 
from itm_mtc WHERE  site_cd = 'QMS'
--and  itm_mtc_stk_locn ='DEN-LAB-0001' 
and itm_mtc_stockno in (select itm_mst_stockno from itm_mst where itm_mst_mstr_locn = 'DEN-LAB-0001')
group by itm_mtc_stockno,itm_mtc_stk_locn