alter proc prm_KKKP_ALL_District_sp
@state_code  varchar(100) = 'MLK'
,@eqip_type  varchar(100) = 'EXISTING'
as
begin
set nocount on
SELECT s.district_code 'State Name','Total' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wo_no) 'NumberOf PWO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
and wko_mst_status in ('OPE','RFS')
and s.statename = @state_code
and s.equipment_type = @eqip_type
GROUP by s.district_code,equipment_type,wko_mst_ast_cod 
 
 
 
  

union  all


SELECT s.district_code 'State Name','Total' category,equipment_type 'Equip.Type',
 'Pending PWO (KP+KK)' Types, Count(wo_no) 'NumberOf PWO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
and wko_mst_status in ('OPE','RFS')
and s.statename = @state_code
and s.equipment_type = @eqip_type
GROUP by s.district_code,equipment_type--,wko_mst_ast_cod 

 
  
union all
 -- > 3 month
 
SELECT s.district_code 'State Name','> 1 month' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wo_no) 'NumberOf PWO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-1-- Datediff(mm,0,getdate())-3
and s.statename = @state_code
and s.equipment_type = @eqip_type
GROUP by s.district_code,equipment_type,wko_mst_ast_cod 
 
  

union  all


SELECT s.district_code 'State Name','> 1 month' category,equipment_type 'Equip.Type',
 'Pending PWO (KP+KK)' Types, Count(wo_no) 'NumberOf PWO'
							 
from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-1--Datediff(mm,0,getdate())-3
and s.statename = @state_code
and s.equipment_type = @eqip_type
GROUP by   s.district_code,equipment_type 
 

  

 

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
 and s.statename = @state_code
and s.equipment_type = @eqip_type
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type ,wko_mst_ast_cod
 
 
union  all

select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',   'Pending PWO (KP+KK)' Types, Count(wo_no) 'NumberOf PWO'

from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 and s.statename = @state_code
and s.equipment_type = @eqip_type
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type  

 
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
 and s.statename = @state_code
and s.equipment_type = @eqip_type
and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-1--Datediff(mm,0,getdate())-3
GROUP by  equipment_type ,wko_mst_ast_cod
 
 
union  all

select 
'Z.Total' 'State Name','> 1 month' category, equipment_type 'Equip.Type',   'Pending PWO (KP+KK)' Types, Count(wo_no) 'NumberOf PWO'

from score_card_prm_tbl (NOLOCK) s
where wo_type = 'pwo'
 and s.statename = @state_code
and s.equipment_type = @eqip_type
and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-1--Datediff(mm,0,getdate())-3
GROUP by  equipment_type  
  set NOCOUNT OFF
end   









