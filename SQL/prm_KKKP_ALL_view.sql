alter view prm_KKKP_ALL_view
as

SELECT s.statename 'State Name','Total' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wo_no) 'NumberOf WO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
and wko_mst_status in ('OPE','RFS')
GROUP by s.statename,equipment_type,wko_mst_ast_cod 
 
 
 
  

union  all


SELECT s.statename 'State Name','Total' category,equipment_type 'Equip.Type',
 'Pending WO (KP+KK)' Types, Count(wo_no) 'NumberOf WO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
and wko_mst_status in ('OPE','RFS')
GROUP by s.statename,equipment_type,wko_mst_ast_cod 

 
  
union all
 -- > 3 month
 
SELECT s.statename 'State Name','> 3 month' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wo_no) 'NumberOf WO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
GROUP by s.statename,equipment_type,wko_mst_ast_cod 
 
  

union  all


SELECT s.statename 'State Name','> 3 month' category,equipment_type 'Equip.Type',
 'Pending WO (KP+KK)' Types, Count(wo_no) 'NumberOf WO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
GROUP by   s.statename,equipment_type 
 

  

 

--> 3 month end
 
union  all

select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wo_no) 'NumberOf WO'

from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type ,wko_mst_ast_cod
 
 
union  all

select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',   'Pending WO (KP+KK)' Types, Count(wo_no) 'NumberOf WO'

from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type  

 
   





