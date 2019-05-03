alter view KKKP_ALL
as

SELECT s.statename 'State Name','Total' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wo_no) 'NumberOf WO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
and wko_mst_status in ('OPE','RFS')
GROUP by s.statename,equipment_type,wko_mst_ast_cod 
 
UNION ALL
SELECT s.statename 'State Name','Total' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK) No MR'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP) No MR'
							end as Types, Count(wo_no) 'NumberOf WO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
and wko_mst_status in ('OPE','RFS')
and mr_no is null
GROUP by s.statename,equipment_type,wko_mst_ast_cod 
 

union all
select 
Statecode 'State Name','Total' category,'Existing' 'Equip.Type',   'No.of.Engg' Types, NoofEngg 'NumberOf WO'
from scorecard_engineer_detail  (nolock)

union  all


SELECT s.statename 'State Name','Total' category,equipment_type 'Equip.Type',
 'Pending WO (KP+KK)' Types, Count(wo_no) 'NumberOf WO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
and wko_mst_status in ('OPE','RFS')
GROUP by s.statename,equipment_type,wko_mst_ast_cod 


union  all


SELECT s.statename 'State Name','Total' category,equipment_type 'Equip.Type',
 'Pending WO (KP+KK) No MR' Types, Count(wo_no) 'NumberOf WO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
and wko_mst_status in ('OPE','RFS')
and mr_no is null
GROUP by s.statename,equipment_type,wko_mst_ast_cod 

union all

 
select 
Statecode 'State Name','Total' category, 'New & Purchase' 'Equip.Type',  'No.of.Engg' Types, NoofEngg 'NumberOf WO'
from scorecard_engineer_detail  (nolock)
union all
 -- > 3 month
 
SELECT s.statename 'State Name','> 3 month' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wo_no) 'NumberOf WO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
GROUP by s.statename,equipment_type,wko_mst_ast_cod 
 
 UNION ALL
 SELECT s.statename 'State Name','> 3 month' category,equipment_type 'Equip.Type'
,Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK) No MR'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP) No MR'
							end as Types, Count(wo_no) 'NumberOf WO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
AND mr_no is NULL
GROUP by s.statename,equipment_type,wko_mst_ast_cod 
union all
select 
Statecode 'State Name','> 3 month' category,'Existing' 'Equip.Type',   'No.of.Engg' Types, NoofEngg 'NumberOf WO'
from scorecard_engineer_detail  (nolock)

union  all


SELECT s.statename 'State Name','> 3 month' category,equipment_type 'Equip.Type',
 'Pending WO (KP+KK)' Types, Count(wo_no) 'NumberOf WO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
GROUP by   s.statename,equipment_type 

UNION ALL

SELECT s.statename 'State Name','> 3 month' category,equipment_type 'Equip.Type',
 'Pending WO (KP+KK) No MR' Types, Count(wo_no) 'NumberOf WO'
							 
from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
 and wko_mst_status in ('OPE','RFS')
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and MR_NO is null
GROUP by   s.statename,equipment_type 


union all

 
select 
Statecode 'State Name','> 3 month' category, 'New & Purchase' 'Equip.Type',  'No.of.Engg' Types, NoofEngg 'NumberOf WO'
from scorecard_engineer_detail  (nolock)

 

--> 3 month end
 
union  all

select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wo_no) 'NumberOf WO'

from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
 
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type ,wko_mst_ast_cod
--

union  all

select 
'Z.Total' 'State Name','> 3 month' category, equipment_type 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wo_no) 'NumberOf WO'

from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
 and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type ,wko_mst_ast_cod
--
 
 UNION ALL

 
select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK) No MR'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP) No MR'
							end as Types, Count(wo_no) 'NumberOf WO'

from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
 
and wko_mst_status in ('OPE','RFS')
and mr_no is null
GROUP by  equipment_type ,wko_mst_ast_cod

 
 UNION ALL

 ----
select 
'Z.Total' 'State Name','> 3 month' category, equipment_type 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK) No MR'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP) No MR'
							end as Types, Count(wo_no) 'NumberOf WO'

from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
 and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
and mr_no is null
GROUP by  equipment_type ,wko_mst_ast_cod
--------
union 
select 
'Z.Total' 'State Name','Total' category,'Existing' 'Equip.Type',   'No.of.Engg' Types, Sum(NoofEngg) 'NumberOf WO'
from scorecard_engineer_detail  (nolock)

union 

select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',   'Pending WO (KP+KK)' Types, Count(wo_no) 'NumberOf WO'

from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
 
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type  
-----

union 

select 
'Z.Total' 'State Name','> 3 month' category, equipment_type 'Equip.Type',   'Pending WO (KP+KK)' Types, Count(wo_no) 'NumberOf WO'

from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
 and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
GROUP by  equipment_type  
--

UNION ALL

select 
'Z.Total' 'State Name','Total' category, equipment_type 'Equip.Type',   'Pending WO (KP+KK) No MR' Types, Count(wo_no) 'NumberOf WO'

from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
 
and wko_mst_status in ('OPE','RFS')
and mr_no is null
GROUP by  equipment_type  
 
  ---
  
UNION ALL

select 
'Z.Total' 'State Name','> 3 month' category, equipment_type 'Equip.Type',   'Pending WO (KP+KK) No MR' Types, Count(wo_no) 'NumberOf WO'

from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
 and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
and mr_no is null
GROUP by  equipment_type  
--
union 
select 
'Z.Total' 'State Name','Total' category, 'New & Purchase' 'Equip.Type',  'No.of.Engg' Types, Sum(NoofEngg) 'NumberOf WO'
from scorecard_engineer_detail  (nolock)

   