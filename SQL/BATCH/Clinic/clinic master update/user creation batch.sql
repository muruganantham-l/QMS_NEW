USE [tomms_prod]
GO
begin tran
INSERT INTO [dbo].[cf_user]
           ([empl_id]
           ,[name]
           ,[default_site]
           ,[default_language]
           ,[sys_admin]
           ,[status]
           ,[supv_empl_id]
           ,[shift]
           ,[work_area]
           ,[work_grp]
           ,[last_login_site]
           ,[last_login]
           ,[last_pwd_changed]
           ,[audit_user]
           ,[audit_date]
           ,[expired_date]
           ,[column1]
           ,[column2]
           ,[column3]
           ,[column4]
           ,[column5]
           ,[cf_user_failed_attempt]
           ,[cf_user_locked])
--     VALUES
select [Clinic Code]
,left([Clinic Name],50)
,'QMS'
,'DEFAULT'
,0
,'ACT'

,NULL
,NULL
,NULL
,NULL
,NULL
,NULL

,GETDATE()
,'tomms'
,getdate()
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,0
,0
from additional_clinic a
where  exists (select null from [cf_user] where a.[Clinic Code] = empl_id)

rollback
begin tran

insert cf_site_user(site_cd,empl_id)

select 'QMS', [Clinic Code]
from     additional_clinic
WHERE [Clinic Code] NOT IN ( 'JHR701','JHR702','NSB716')

rollback



SELECT m.emp_mst_empl_id,m.emp_mst_name,m.emp_mst_status,m.emp_mst_usr_grp,m.emp_mst_login_id,d.emp_det_varchar1,d.emp_det_varchar9
 FROM emp_mst M join emp_det d on m.RowID = d.mst_RowID

begin tran

insert emp_mst
(
 emp_mst_empl_id
,emp_mst_name
,emp_mst_status
,emp_mst_usr_grp
,emp_mst_privilege_template
,emp_mst_login_id
,site_cd
,audit_user
,audit_date
)

SELECT [Clinic Code]
,left([Clinic Name],50)
,'ACT'
,'CLI'
,'CLI'
,[clinic code]
,'QMS'
,'tomms'
,getdate()
from additional_clinic
WHERE [Clinic Code] NOT IN ('NSB716')
-- 'JHR701','JHR702',
insert emp_det
(
mst_RowID
,emp_det_varchar1
,emp_det_varchar9
,site_cd
,audit_user
,audit_date
)
SELECT e.RowID
,a.[Clinic Code]
,1
,'QMS'
,'tomms'
,getdate()
from emp_mst e
join additional_clinic a on e.emp_mst_empl_id = a.[Clinic Code]
ROLLBACK



 DECLARE @temp table
 (
 row_no int identity(1,1)
 ,loginname varchar(200)
 
 )
 insert @temp (loginname)

 SELECT [Clinic Code] from additional_clinic
  

 declare @i as int = 1
 
 declare @loginname nvarchar(200)

 WHILE @i <= 281
 begin
 SELECT @loginname = loginname from @temp where row_no = @i


 declare @sql1 nvarchar(max) = 'ALTER SERVER ROLE [sysadmin] ADD MEMBER '+ @loginname 
 declare @sql2  nvarchar(max) = ' CREATE USER ' +@loginname+' FOR LOGIN '+@loginname
  declare @sql3  nvarchar(max) =' ALTER USER '+ @loginname + ' WITH DEFAULT_SCHEMA = '+ @loginname 
 declare @sql4  nvarchar(max) =  'CREATE SCHEMA '+@loginname +' AUTHORIZATION '+ @loginname
   
EXEC(@sql1)
EXEC(@sql2)
EXEC(@sql3)



exec sp_executesql N'Delete cf_site_user Where site_cd =@P1 And empl_id =@P2 ',N'@P1 nvarchar(4),@P2 nvarchar(25)',N'QMS',@loginname

exec sp_executesql N'Insert into cf_site_user Values ( @P1 , @P2 ) ',N'@P1 nvarchar(4),@P2 nvarchar(25)',N'QMS',@loginname
DELETE from cf_user_access where empl_id = @loginname

Insert cf_user_access (site_cd, empl_id, menuid, exe_flag, view_flag, new_flag, edit_flag, del_flag, print_flag)  Select 'QMS', @loginname, RowID, 1, 1, 1, 1, 1, 1 From cf_menu Where  object_type = 'F'  AND language_cd = 'DEFAULT'

Insert cf_user_access (site_cd, empl_id, menuid, exe_flag, view_flag, new_flag, edit_flag, del_flag, print_flag)  Select 'QMS', @loginname, RowID, 1, 1, 1, 1, 1, 1 From cf_menu Where  object_type = 'R'  AND language_cd = 'DEFAULT'



SELECT @i = @i + 1
END

 
