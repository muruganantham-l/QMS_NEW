ALTER proc prm_agm_score_card_sp
 @equip_type varchar(50) = 'Existing'
as
begin
set nocount on 
truncate table prm_AGM_Scorecard_view_all_tmp
--select * into prm_AGM_Scorecard_view_all_tmp from AGM_Scorecard_view_all_tmp

insert prm_AGM_Scorecard_view_all_tmp
--SELECT * from AGM_Scorecard_view_all
 
 SELECT case when  l.ast_loc_zone in ('SOUTHERN','CENTRAL') then 'Southern & Central' else 'Northern & East M''sia' end ,[Equip.Type],Types,sum([NumberOf WO] )
 from  prm_Scorecard_view_All_temp t   (nolock)
 join Stock_Location_mst_report lm (nolock)
 on t.[State Name] = lm.Statecode
 join (SELECT DISTINCT ast_loc_zone, ast_loc_state from ast_loc (NOLOCK)) l  on lm.SatateDesc = l.ast_loc_state
 group by case when  l.ast_loc_zone in ('SOUTHERN','CENTRAL') then 'Southern & Central' else 'Northern & East M''sia' end,[Equip.Type],Types
  
 
SELECT * from prm_AGM_Scorecard_view_all_tmp (NOLOCK) where [Equip.Type] = @equip_type
 
--where [Year OF WO] = 2017 

set nocount OFF
end

