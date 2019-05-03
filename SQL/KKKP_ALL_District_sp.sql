alter proc KKKP_ALL_District_sp
@state_code  varchar(100) = 'MLK'
,@eqip_type  varchar(100) = 'EXISTING'
as
begin
set nocount on
SELECT s.district_code 'State Name','Total' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending CWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending CWO (KP)'
							end as Types, Count(wo_no) 'NumberOf CWO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
and wko_mst_status in ('OPE','RFS')
and s.statename = @state_code
and s.equipment_type = @eqip_type
GROUP by s.district_code,equipment_type,wko_mst_ast_cod 
 
 UNION ALL

 SELECT s.district_code 'State Name','Total' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending CWO (KK) No MR'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending CWO (KP) No MR'
							end as Types, Count(wo_no) 'NumberOf CWO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
and wko_mst_status in ('OPE','RFS')
and s.statename = @state_code
and s.equipment_type = @eqip_type
and s.mr_no is NULL
GROUP by s.district_code,equipment_type,wko_mst_ast_cod 

 
  

union  all


SELECT s.district_code 'State Name','Total' category,equipment_type 'Equip.Type',
 'Pending CWO (KP+KK)' Types, Count(wo_no) 'NumberOf CWO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
and wko_mst_status in ('OPE','RFS')
and s.statename = @state_code
and s.equipment_type = @eqip_type
GROUP by s.district_code,equipment_type--,wko_mst_ast_cod 

 union  all


SELECT s.district_code 'State Name','Total' category,equipment_type 'Equip.Type',
 'Pending CWO (KP+KK) No MR' Types, Count(wo_no) 'NumberOf CWO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
and wko_mst_status in ('OPE','RFS')
and s.statename = @state_code
and s.equipment_type = @eqip_type
and s.mr_no is NULL
GROUP by s.district_code,equipment_type--,wko_mst_ast_cod 
  
union all
 -- > 3 month
 
SELECT s.district_code 'State Name','> 3 month' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending CWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending CWO (KP)'
							end as Types, Count(wo_no) 'NumberOf CWO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and s.statename = @state_code
and s.equipment_type = @eqip_type
GROUP by s.district_code,equipment_type,wko_mst_ast_cod 
 
union all
 -- > 3 month
 
SELECT s.district_code 'State Name','> 3 month' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending CWO (KK) No MR'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending CWO (KP) No MR'
							end as Types, Count(wo_no) 'NumberOf CWO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and s.statename = @state_code
and s.equipment_type = @eqip_type
and s.mr_no is NULL
GROUP by s.district_code,equipment_type,wko_mst_ast_cod   

union  all


SELECT s.district_code 'State Name','> 3 month' category,equipment_type 'Equip.Type',
 'Pending CWO (KP+KK)' Types, Count(wo_no) 'NumberOf CWO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and s.statename = @state_code
and s.equipment_type = @eqip_type
GROUP by   s.district_code,equipment_type 
 

union  all


SELECT s.district_code 'State Name','> 3 month' category,equipment_type 'Equip.Type',
 'Pending CWO (KP+KK) No MR' Types, Count(wo_no) 'NumberOf CWO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and s.statename = @state_code
and s.equipment_type = @eqip_type
and s.mr_no is NULL
GROUP by   s.district_code,equipment_type 
  

 

--> 3 month end
 
union  all

select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending CWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending CWO (KP)'
							end as Types, Count(wo_no) 'NumberOf CWO'

from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
 and s.statename = @state_code
and s.equipment_type = @eqip_type
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type ,wko_mst_ast_cod

union  all

select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending CWO (KK) No MR'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending CWO (KP) No MR'
							end as Types, Count(wo_no) 'NumberOf CWO'

from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
 and s.statename = @state_code
and s.equipment_type = @eqip_type
and wko_mst_status in ('OPE','RFS')
and s.mr_no is NULL
GROUP by  equipment_type ,wko_mst_ast_cod
 
 
union  all

select 
'Z.Total' 'State Name','> 3 month' category, equipment_type 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending CWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending CWO (KP)'
							end as Types, Count(wo_no) 'NumberOf CWO'

from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
 and s.statename = @state_code
and s.equipment_type = @eqip_type
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type ,wko_mst_ast_cod

 
union  all

select 
'Z.Total' 'State Name','> 3 month' category, equipment_type 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending CWO (KK) No MR'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending CWO (KP) No MR'
							end as Types, Count(wo_no) 'NumberOf CWO'

from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
 and s.statename = @state_code
and s.equipment_type = @eqip_type
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
and s.mr_no is NULL
GROUP by  equipment_type ,wko_mst_ast_cod
union  all

select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',   'Pending CWO (KP+KK)' Types, Count(wo_no) 'NumberOf CWO'

from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
 and s.statename = @state_code
and s.equipment_type = @eqip_type
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type  
union  all

select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',   'Pending CWO (KP+KK) No MR' Types, Count(wo_no) 'NumberOf CWO'

from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
 and s.statename = @state_code
and s.equipment_type = @eqip_type
and wko_mst_status in ('OPE','RFS')
and s.mr_no is null
GROUP by  equipment_type  

union  all

select 
'Z.Total' 'State Name','> 3 month'  category, equipment_type 'Equip.Type',   'Pending CWO (KP+KK)' Types, Count(wo_no) 'NumberOf CWO'

from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
 and s.statename = @state_code
and s.equipment_type = @eqip_type
and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
GROUP by  equipment_type  


union  all

select 
'Z.Total' 'State Name','> 3 month'  category, equipment_type 'Equip.Type',   'Pending CWO (KP+KK) No MR' Types, Count(wo_no) 'NumberOf CWO'

from score_card_tbl (NOLOCK) s
where wo_type = 'CWO'
 and s.statename = @state_code
and s.equipment_type = @eqip_type
and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and s.mr_no is NULL
GROUP by  equipment_type  
 
  set NOCOUNT OFF
end   









