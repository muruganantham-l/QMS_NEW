IF OBJECT_ID('TRG_mtr_mst') IS NOT NULL
DROP TRIGGER TRG_mtr_mst
GO

CREATE TRIGGER TRG_mtr_mst 
ON dbo.mtr_mst
AFTER INSERT AS
BEGIN
set nocount on
declare @sysdate date = getdate()
--INSERT INTO EMPLOYEE_BACKUP
if exists(
SELECT '*'
FROM   INSERTED i
join   ast_mst  m (NOLOCK) on i.mtr_mst_assetno = m.ast_mst_asset_no
join   ast_det d (NOLOCK) on m.RowID = d.mst_RowID
join   extended_warrenty_by_supplier_tbl e (NOLOCK) 
on e.BE_GRP_CODE = m.ast_mst_asset_grpcode
and d.ast_det_varchar24 = e.Supplier_Code
and @sysdate BETWEEN ast_det_warranty_date AND dateadd(MONTH,e.EXTENDED_WARNTY_MONTH,ast_det_warranty_date)
)
begin 
delete m from mtr_mst m join INSERTED i on m.RowID = i.RowID
RAISERROR('BE under warrenty',16,1);RETURN

END
set nocount OFF
END 