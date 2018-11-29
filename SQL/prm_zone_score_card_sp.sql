CREATE proc prm_zone_score_card_sp
 @equip_type varchar(50) = 'Existing'
as
begin
set nocount on 
truncate table prm_zone_Scorecard_view_all_tmp
 
 
insert prm_zone_Scorecard_view_all_tmp
--SELECT * from zone_Scorecard_view_all
 
 SELECT   l.ast_loc_zone   ,[Equip.Type],Types,sum([NumberOf WO] )
 from  prm_Scorecard_view_All_temp t   (nolock)
 join Stock_Location_mst_report lm (nolock)
 on t.[State Name] = lm.Statecode
 join (SELECT DISTINCT ast_loc_zone, ast_loc_state from ast_loc (NOLOCK)) l  on lm.SatateDesc = l.ast_loc_state
 group by  l.ast_loc_zone  ,[Equip.Type],Types
  
 
SELECT * from prm_zone_Scorecard_view_all_tmp (NOLOCK) where [Equip.Type] = @equip_type
 
 
--alter table prm_zone_Scorecard_view_all_tmp  alter column types varchar(20)
--where [Year OF WO] = 2017 

set nocount OFF
end

