alter proc agm_score_card_sp
 @equip_type varchar(50) = 'Existing'
as
begin
set nocount on 
truncate table AGM_Scorecard_view_all_tmp

insert AGM_Scorecard_view_all_tmp
--SELECT * from AGM_Scorecard_view_all
 
 SELECT case when  l.ast_loc_zone in ('SOUTHERN','CENTRAL') then 'Southern & Central' else 'Northern & East M''sia' end ,[Equip.Type],Types,sum([NumberOf WO] )
 from  Scorecard_view_All_temp t   (nolock)
 join Stock_Location_mst_report lm (nolock)
 on t.[State Name] = lm.Statecode
 join (SELECT DISTINCT ast_loc_zone, ast_loc_state from ast_loc (NOLOCK)) l  on lm.SatateDesc = l.ast_loc_state
 group by case when  l.ast_loc_zone in ('SOUTHERN','CENTRAL') then 'Southern & Central' else 'Northern & East M''sia' end,[Equip.Type],Types
  
 
SELECT * from AGM_Scorecard_view_all_tmp (NOLOCK) where [Equip.Type] = @equip_type
 
--where [Year OF WO] = 2017 
--alter table AGM_Scorecard_view_all_tmp alter column types varchar(50)
set nocount OFF
end

