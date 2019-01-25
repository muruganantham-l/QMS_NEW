alter proc zone_score_card_sp
 @equip_type varchar(50) = 'Existing'
as
begin
set nocount on 
truncate table zone_Scorecard_view_all_tmp
 
insert zone_Scorecard_view_all_tmp
--SELECT * from zone_Scorecard_view_all
 
 SELECT   l.ast_loc_zone   ,[Equip.Type],Types,sum([NumberOf WO] )
 from  Scorecard_view_All_temp t   (nolock)
 join Stock_Location_mst_report lm (nolock)
 on t.[State Name] = lm.Statecode
 join (SELECT DISTINCT ast_loc_zone, ast_loc_state from ast_loc (NOLOCK)) l  on lm.SatateDesc = l.ast_loc_state
 group by  l.ast_loc_zone  ,[Equip.Type],Types
  
 
SELECT * from zone_Scorecard_view_all_tmp (NOLOCK) where [Equip.Type] = @equip_type
 
 --alter table zone_Scorecard_view_all_tmp alter column types varchar(50)
--where [Year OF WO] = 2017 

set nocount OFF
end

