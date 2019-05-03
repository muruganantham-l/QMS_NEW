alter view prm_KKKP_ALL_view
as

SELECT s.statename 'State Name','Total' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wo_no) 'NumberOf PWO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
and wko_mst_status in ('OPE','RFS')
GROUP by s.statename,equipment_type,wko_mst_ast_cod 
 
 
 
  

union  all


SELECT s.statename 'State Name','Total' category,equipment_type 'Equip.Type',
 'Pending PWO (KP+KK)' Types, Count(wo_no) 'NumberOf PWO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
and wko_mst_status in ('OPE','RFS')
GROUP by s.statename,equipment_type,wko_mst_ast_cod 

 
  
union all
 -- > 3 month
 
SELECT s.statename 'State Name','> 1 month' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wo_no) 'NumberOf PWO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-1--Datediff(mm,0,getdate())-3
GROUP by s.statename,equipment_type,wko_mst_ast_cod 
 
  

union  all


SELECT s.statename 'State Name','> 1 month' category,equipment_type 'Equip.Type',
 'Pending PWO (KP+KK)' Types, Count(wo_no) 'NumberOf PWO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-1--Datediff(mm,0,getdate())-3
GROUP by   s.statename,equipment_type 
 

  

 

--> 3 month end
 
union  all

select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wo_no) 'NumberOf PWO'

from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type ,wko_mst_ast_cod
 
union  all

select 
'Z.Total' 'State Name','> 1 month' category, equipment_type 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wo_no) 'NumberOf PWO'

from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-1--Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type ,wko_mst_ast_cod
 
union  all


SELECT 'Z.Total' 'State Name','> 1 month' category,equipment_type 'Equip.Type',
 'Pending PWO (KP+KK)' Types, Count(wo_no) 'NumberOf PWO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-1--Datediff(mm,0,getdate())-3
GROUP by    equipment_type 

union all

select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',   'Pending PWO (KP+KK)' Types, Count(wo_no) 'NumberOf PWO'

from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type  

 
   









