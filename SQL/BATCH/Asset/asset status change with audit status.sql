begin tran
declare @temp table (asset_no varchar(60))
insert @temp (asset_no)
 
select 'MLPANG022' union
select 'NSPANG002' union
select 'NSPANG004' union
select 'NSPANG007' union
select 'NSPANG016' union
select 'PNPANG002' union
select 'PNPANG033' union
select 'PNPANG036' union
select 'PNPANG039' union
select 'PNPANG050' union
select 'PNPANG054' union
select 'PNPANG057' union
select 'PNPANG062' union
select 'PRPANG004' union
select 'PRPANG006' union
select 'PRPANG008' union
select 'PRPANG010' union
select 'PRPANG012' union
select 'PRPANG014' union
select 'PRPANG016' union
select 'PRPANG019' union
select 'PRPANG021' union
select 'PRPANG023' union
select 'PRPANG025' union
select 'PRPANG027' union
select 'PRPANG029' union
select 'PRPANG031' union
select 'PRPANG034' union
select 'PRPANG051' union
select 'PRPANG074' union
select 'PRPANG082' union
select 'PRPANG090' union
select 'PRPANG109' union
select 'PRPANG205' union
select 'SLPANG002' union
select 'SLPANG004' union
select 'SLPANG006' union
select 'SLPANG008' union
select 'SLPANG010' union
select 'SLPANG012' union
select 'SLPANG014' union
select 'SLPANG019' union
select 'SLPANG022' union
select 'SLPANG023' union
select 'SLPANG057' union
select 'SLPANG072' union
select 'SLPANG075' union
select 'SLPANG078' union
select 'SLPANG081' union
select 'SLPANG085' union
select 'SLPANG091' union
select 'SLPANG098' union
select 'SLPANG104' union
select 'SLPANG107' union
select 'SLPANG110' union
select 'SLPANG114' union
select 'SBPSPL011' union
select 'SBPSPL033' union
select 'SBPSPL034' union
select 'SBPSPL035' union
select 'SBPSPL036' union
select 'SBPSPL037' union
select 'SBPSPL038' union
select 'SBPSPL039' union
select 'SBPSPL040' union
select 'SBPSPL041' union
select 'SBPSPL042' union
select 'SBPSPL043' union
select 'SBPSPL044' union
select 'SBPSPL045' union
select 'SBPSPL046' union
select 'SBPSPL047' union
select 'SBPSPL048' union
select 'SBPSPL049' union
select 'SBPSPL050' union
select 'SBPSPL051' union
select 'SBPSPL052' union
select 'SBPSPL053' union
select 'SBPSPL074' union
select 'SBPSPL075' union
select 'SBPSPL076' union
select 'SBPSPL077' union
select 'SBPSPL078' union
select 'SBPSPL079' union
select 'SBPSPL080' union
select 'SBPSPL081' union
select 'SBPSPL082' union
select 'SBPSPL083' union
select 'SBPSPL084' union
select 'SBPSPL085' union
select 'SBPSPL086' union
select 'SBPSPL129' union
select 'SBPSPL130' union
select 'SBPSPL131' union
select 'SBPSPL132' union
select 'SBPSPL133' union
select 'SBPSPL134' union
select 'SBPSPL135' union
select 'SBPSPL138' union
select 'SBPSPL139' union
select 'SBPSPL140' union
select 'SBPSPL141' union
select 'SBPSPL142' union
select 'SBPSPL143' union
select 'SBPSPL144' union
select 'SBPSPL145' union
select 'SBPSPL146' union
select 'SBPSPL147' union
select 'SBPSPL148' union
select 'SBPSPL149' union
select 'SBPSPL150' union
select 'SBPSPL151' union
select 'SBPSPL152' union
select 'SBPSPL153' union
select 'SBPSPL154' union
select 'SBPSPL155' union
select 'SBPSPL156' union
select 'SBPSPL157' union
select 'SBPSPL158' union
select 'SBPSPL162' union
select 'SBPSPL163' union
select 'SBPSPL164' union
select 'SBPSPL177' union
select 'SBPSPL178' union
select 'SBPSPL181' union
select 'SBPSPL182' union
select 'SBPSPL183' union
select 'SBPSPL184' union
select 'SBPSPL188' union
select 'SBPSPL189' union
select 'SBPSPL191' union
select 'SBPSPL192' union
select 'SBPSPL194' union
select 'SLPSPL006' union
select 'SLPSPL007' union
select 'SLPSPL050' union
select 'SLPSPL051' union
select 'SLPSPL052' union
select 'SLPSPL058' union
select 'SLPSPL059' union
select 'SLPSPL068' union
select 'SLPSPL069' union
select 'SLPSPL070' union
select 'SLPSPL076' union
select 'SLPSPL077' union
select 'SLPSPL083' union
select 'SLPSPL084' union
select 'SLPSPL085' union
select 'SLPSPL086' union
select 'SLPSPL098' union
select 'SLPSPL099' union
select 'SLPSPL104' union
select 'SLPSPL105' union
select 'SLPSPL106' union
select 'SLPSPL111' union
select 'SLPSPL112' union
select 'SLPSPL117' union
select 'SLPSPL118' union
select 'SLPSPL119' union
select 'SLPSPL122' union
select 'SLPSPL123' union
select 'SLPSPL124' union
select 'SLPSPL132' union
select 'SLPSPL133' union
select 'SLPSPL134' union
select 'SLPSPL165' union
select 'SLPSPL166' union
select 'SLPSPL172' union
select 'SLPSPL173' union
select 'SLPSPL174' union
select 'SLPSPL175' union
select 'SLPSPL197' union
select 'SLPSPL198' union
select 'SLPSPL199' union
select 'SLPSPL205' union
select 'SLPSPL206' union
select 'SLPSPL207' union
select 'SLPSPL278' union
select 'SLPSPL279' union
select 'SLPSPL280' union
select 'SLPSPL285' union
select 'SLPSPL286' union
select 'SLPSPL287' union
select 'SLPSPL288' union
select 'SLPSPL293' union
select 'SLPSPL332' union
select 'SLPSPL333' union
select 'SLPSPL334' union
select 'SLPSPL335' union
select 'SLPSPL339' union
select 'SLPSPL340' union
select 'SLPSPL348' union
select 'SLPSPL349' union
select 'SLPSPL350' union
select 'SLPSPL376' union
select 'SLPSPL377' union
select 'SLPSPL379' union
select 'SLPSPL380' union
select 'SLPSPL397' union
select 'SLPSPL398' union
select 'SWPSPL111' union
select 'SWPSPL112' union
select 'SWPSPL113' union
select 'SWPSPL114' union
select 'SWPSPL115' union
select 'SWPSPL116' union
select 'SWPSPL117' union
select 'SWPSPL118' union
select 'SWPSPL119' union
select 'SWPSPL120' union
select 'SWPSPL121' union
select 'SWPSPL122' union
select 'SWPSPL123' union
select 'SWPSPL124' union
select 'SWPSPL125' union
select 'SWPSPL126' union
select 'SWPSPL127' union
select 'SWPSPL128' union
select 'SWPSPL129' union
select 'SWPSPL130' union
select 'SWPSPL131' union
select 'SWPSPL132' union
select 'SWPSPL133' union
select 'SWPSPL134' union
select 'SWPSPL135' union
select 'SWPSPL136' union
select 'SWPSPL137' union
select 'SWPSPL138' union
select 'SWPSPL139' union
select 'SWPSPL140' union
select 'SWPSPL141' union
select 'SWPSPL285' union
select 'SWPSPL286' union
select 'SWPSPL287' union
select 'SWPSPL288' union
select 'SWPSPL289' union
select 'SWPSPL290' union
select 'SWPSPL291' union
select 'SWPSPL292' union
select 'SWPSPL293' union
select 'SWPSPL294' union
select 'SWPSPL295' union
select 'SWPSPL296' union
select 'SWPSPL297' union
select 'SWPSPL298' union
select 'SWPSPL299' union
select 'SWPSPL300' union
select 'SWPSPL301' union
select 'SWPSPL302' union
select 'SWPSPL303' union
select 'SWPSPL304' union
select 'SWPSPL305' union
select 'SWPSPL306' union
select 'SWPSPL307' union
select 'SWPSPL308' union
select 'SWPSPL309' union
select 'SWPSPL310' union
select 'SWPSPL311' union
select 'SWPSPL312' union
select 'SWPSPL313' union
select 'SWPSPL314' union
select 'SWPSPL315' union
select 'SWPSPL316' union
select 'SWPSPL317' union
select 'SWPSPL318' union
select 'SWPSPL319' union
select 'SWPSPL374' union
select 'SWPSPL375' union
select 'SWPSPL376' union
select 'SWPSPL377' union
select 'SWPSPL378' union
select 'SWPSPL379' union
select 'SWPSPL380' union
select 'SWPSPL381' union
select 'SWPSPL382' union
select 'SWPSPL383' union
select 'SWPSPL384' union
select 'SWPSPL385' union
select 'SWPSPL386' union
select 'SWPSPL387' union
select 'SWPSPL388' union
select 'SWPSPL395' union
select 'SWPSPL396' union
select 'SWPSPL397' union
select 'SWPSPL398' union
select 'SWPSPL399' union
select 'SWPSPL400' union
select 'SWPSPL401' union
select 'SWPSPL406' union
select 'SWPSPL407' union
select 'SWPSPL408' union
select 'SWPSPL409' union
select 'WKPSPL003' union
select 'WKPSPL004' union
select 'WKPSPL012' union
select 'WKPSPL013' union
select 'WKPSPL019' union
select 'WKPSPL020' union
select 'WKPSPL027' union
select 'WKPSPL028' union
select 'WKPSPL036' union
select 'WKPSPL037' union
select 'WKPSPL038' union
select 'WKPSPL044' union
select 'WKPSPL045' union
select 'WKPSPL054' union
select 'WKPSPL055' union
select 'WKPSPL063' union
select 'WKPSPL064' union
select 'WKPSPL071' union
select 'WKPSPL072' union
select 'WKPSPL078' union
select 'WKPSPL079' union
select 'WKPSPL088' union
select 'WKPSPL089' union
select 'WKPSPL090' union
select 'WKPSPL091' union
select 'WKPSPL096' union
select 'WKPSPL097' union
select 'WKPSPL098' union
select 'WKPSPL106' union
select 'WKPSPL107' union
select 'WKPSPL141' union
select 'WKPSPL142'  

 --SELECT * from @temp

 --update ast_mst set ast_mst_asset_status = 'MNR' WHERE ast_mst_asset_no in (SELECT asset_no from @temp)

 --insert ast_aud (site_cd,ast_aud_asset_no,ast_aud_status,ast_aud_originator,ast_aud_start_date,audit_user,audit_date,mst_RowID)
 --SELECT 'QMS',asset_no,'MNR','tomms',getdate(),'tomms',getdate(),m.RowID
 --from @temp
 -- join ast_mst m on m.ast_mst_asset_no = asset_no

  ;with c2 AS (
 SELECT * from
 (
select a.ast_aud_asset_no,a.mst_RowID,dateadd (SECOND,-1, a.ast_aud_start_date) ast_aud_end_date,ast_aud_start_date,ROW_NUMBER()over(PARTITION by a.mst_RowID,a.ast_aud_asset_no order by a.mst_RowID,a.ast_aud_asset_no,a.ast_aud_start_date) 'rn'
from ast_aud a join @temp on asset_no = ast_aud_asset_no  
where a.ast_aud_end_date is null
) a
where a.rn = 2
 ),c1 as (

SELECT * from
 (
select a.ast_aud_asset_no,a.mst_RowID,  ast_aud_end_date,ast_aud_start_date,ROW_NUMBER()over(PARTITION by a.mst_RowID,a.ast_aud_asset_no order by a.mst_RowID,a.ast_aud_asset_no,a.ast_aud_start_date) 'rn'
from ast_aud a join @temp on asset_no = ast_aud_asset_no  
where a.ast_aud_end_date is null
) b
where b.rn = 1

)
 update a set ast_aud_end_date = b.ast_aud_end_date
 from c1 a
 join c2 b
 on a.ast_aud_asset_no = b.ast_aud_asset_no
 and a.mst_RowID = b.mst_RowID


 SELECT * from
 (
select a.ast_aud_asset_no,a.ast_aud_status,a.mst_RowID, ast_aud_start_date, ast_aud_end_date,ROW_NUMBER()over(PARTITION by a.mst_RowID,a.ast_aud_asset_no order by a.mst_RowID,a.ast_aud_asset_no,a.ast_aud_start_date) 'rn'
from ast_aud a join @temp on asset_no = ast_aud_asset_no  
--where a.ast_aud_end_date is null
) b
--where b.rn = 1

 COMMIT