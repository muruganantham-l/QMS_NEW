IF OBJECT_ID('TRG_mtr_mst') IS NOT NULL
DROP TRIGGER TRG_mtr_mst
GO

CREATE TRIGGER TRG_mtr_mst 
ON dbo.mtr_mst
AFTER INSERT AS
BEGIN
set nocount on
declare @sysdate date = getdate(),@error_msg nvarchar(400) = ''+char(13)+'NOTE : BE ASSET UNDER WARRANTY BY SUPPLIER'
--INSERT INTO EMPLOYEE_BACKUP
if  exists(
SELECT '*'
FROM   INSERTED i
join   ast_mst  m (NOLOCK) on i.mtr_mst_assetno = m.ast_mst_asset_no
join   ast_det d (NOLOCK) on m.RowID = d.mst_RowID
join   extended_warrenty_by_supplier_tbl e (NOLOCK) 
on e.BE_GRP_CODE = m.ast_mst_asset_grpcode
and d.ast_det_varchar24 = e.Supplier_Code
and @sysdate BETWEEN ast_det_warranty_date AND dateadd(MONTH,e.EXTENDED_WARNTY_MONTH,ast_det_warranty_date)
and ast_det_varchar15 in ('New Biomedical','Purchase Biomedical')
union 

SELECT '*'
FROM   INSERTED i
join   ast_mst  m (NOLOCK) on i.mtr_mst_assetno = m.ast_mst_asset_no
join   ast_det d (NOLOCK) on m.RowID = d.mst_RowID
--join   extended_warrenty_by_supplier_tbl e (NOLOCK) 
--on e.BE_GRP_CODE = m.ast_mst_asset_grpcode
--and d.ast_det_varchar24 = e.Supplier_Code
 and @sysdate BETWEEN ast_det_datetime1 AND ast_det_warranty_date
 and ast_det_varchar15 in ('New Biomedical','Purchase Biomedical')
)
begin 
delete m from mtr_mst m join INSERTED i on m.RowID = i.RowID

RAISERROR(@error_msg,16,1);RETURN
--PRINT 'BE Asset Under Warranty by Supplier';RETURN

END
set nocount OFF
END 

