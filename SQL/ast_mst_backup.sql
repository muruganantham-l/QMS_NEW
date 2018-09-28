ALTER proc ast_mst_backup
as
begin
set nocount on
 
 if  datepart(dd,getdate()) in (1,2,3,4,5)
 begin
  
drop table ast_aud
drop table ast_cod
drop table ast_cri
drop table ast_dep
drop table ast_det
drop table ast_grp
drop table ast_job
drop table ast_loc
drop table ast_ls1
drop table ast_ls2
drop table ast_lvl
drop table ast_mst
drop table ast_rat
--drop table ast_ref
drop table ast_ser
drop table ast_sts
drop table ast_tag
drop table ast_tag_audit
drop table ast_type
drop table ast_usg


select * into  ast_aud			from   camms_prod.tomms_prod.dbo.ast_aud
select * into  ast_cod			from   camms_prod.tomms_prod.dbo.ast_cod
select * into  ast_cri			from   camms_prod.tomms_prod.dbo.ast_cri
select * into  ast_dep			from   camms_prod.tomms_prod.dbo.ast_dep
select * into  ast_det			from   camms_prod.tomms_prod.dbo.ast_det
select * into  ast_grp			from   camms_prod.tomms_prod.dbo.ast_grp
select * into  ast_job			from   camms_prod.tomms_prod.dbo.ast_job
select * into  ast_loc			from   camms_prod.tomms_prod.dbo.ast_loc
select * into  ast_ls1			from   camms_prod.tomms_prod.dbo.ast_ls1
select * into  ast_ls2			from   camms_prod.tomms_prod.dbo.ast_ls2
select * into  ast_lvl			from   camms_prod.tomms_prod.dbo.ast_lvl
select * into  ast_mst			from   camms_prod.tomms_prod.dbo.ast_mst
select * into  ast_rat			from   camms_prod.tomms_prod.dbo.ast_rat
--select * into  ast_ref			from   camms_prod.tomms_prod.dbo.ast_ref
select * into  ast_ser			from   camms_prod.tomms_prod.dbo.ast_ser
select * into  ast_sts			from   camms_prod.tomms_prod.dbo.ast_sts
select * into  ast_tag			from   camms_prod.tomms_prod.dbo.ast_tag
select * into  ast_tag_audit	from   camms_prod.tomms_prod.dbo.ast_tag_audit
select * into  ast_type			from   camms_prod.tomms_prod.dbo.ast_type
select * into  ast_usg			from   camms_prod.tomms_prod.dbo.ast_usg

/*
SET IDENTITY_INSERT ast_ref ON
 
declare @sysdate date = getdate()


insert ast_ref
(
site_cd
,mst_RowID
,file_name
,type
,status
,attachment
,audit_user
,audit_date
,column1
,column2
,column3
,column4
,column5
,RowID



)

SELECT 
site_cd
,mst_RowID
,file_name
,type
,status
,attachment
,audit_user
,audit_date
,column1
,column2
,column3
,column4
,column5
,RowID
from   ast_ref (nolock) 
where month(audit_date) = month(@sysdate)
and   year(@sysdate) =  year(audit_date)

SET IDENTITY_INSERT ast_ref off
*/
  END
set nocount OFF
end

--new bio medical equipment

