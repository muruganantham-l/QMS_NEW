drop table asset_migration_tmp
go
create table asset_migration_tmp
(
 ast_mst_asset_no				nvarchar(1000)
,ast_mst_asset_grpcode			nvarchar(1000)
,ast_mst_asset_status			nvarchar(1000)
,ast_mst_safety_rqmts			nvarchar(1000)
,ast_det_mfg_cd					nvarchar(1000)
,ast_det_modelno				nvarchar(1000)
,ast_det_varchar2				nvarchar(1000)
,ast_det_varchar4				nvarchar(1000)
,ast_det_varchar9				nvarchar(1000)
,ast_det_cus_code				nvarchar(1000)
,ast_det_varchar15				nvarchar(1000)
,ast_det_varchar16				nvarchar(1000)
,ast_det_varchar5				nvarchar(1000)
,ast_det_varchar24				nvarchar(1000)
,ast_det_varchar25				nvarchar(1000)
,ast_det_varchar21				nvarchar(1000)
,ast_det_datetime1				datetime
,ast_det_warranty_date			datetime
,ast_det_datetime3				datetime
,ast_det_datetime4				datetime
,ast_det_datetime5				datetime
,ast_det_datetime6				datetime
,ast_det_datetime7				datetime
,ast_det_datetime8				datetime
,ast_det_varchar22				nvarchar(1000)
,ast_det_purchase_date			datetime
,ast_det_datetime19				datetime
,ast_det_datetime20				datetime
,error_flag						varchar(10) default 'N'
,error_desc						nvarchar(max)
)
