select *     from  emp_ls2 where  RowID = '74277'-- emp_ls2_empl_id = 'QHQAGM1' and cast(audit_date as date) = '2018-10-22'

select * from emp_mst where rowid = 74359
--select * from QHQAGM1
/*********************************************note to do *******************/
--CREATE separate table for each user and insert to the below tables and hardcode the lelen and limit based on requirement
insert emp_ls2 (site_cd,mst_RowID,emp_ls2_costcenter,emp_ls2_pr_approval_limit,audit_user,audit_date,emp_ls2_empl_id,emp_ls2_approver,emp_ls2_level)
select 'QMS',751,cost_centre,999999999.9900,'tomms',getdate(),'QHQCEO',1,4
FROM QHQAGM2

/*******************************    script from trace               ***********************************/
/*
update QHQAGM1 set 
cost_centre=  replace(replace(REPLACE(cost_centre,char(9),''),CHAR(10),''),CHAR(13),'')

exec sp_executesql N'DELETE pur_app WHERE site_cd =@P1 AND mst_RowID =@P2 ',N'@P1 nvarchar(4),@P2 int',N'QMS',74277
 

exec sp_executesql N'Insert pur_app ( site_cd , mst_RowID , pur_app_level , pur_app_cost_center , pur_app_empl_id , pur_app_pr_limit , pur_app_date , pur_app_status , pur_app_approval , audit_user , audit_date ) 
Values ( @P1 , @P2 , @P3 , @P4 , @P5 , @P6 , NULL , ''P'' , NULL , @P7 , GetDate ( ) ) ',N'@P1 nvarchar(4),@P2 int,@P3 int,@P4 nvarchar(50),@P5 nvarchar(25),@P6 nvarchar(79),@P7 nvarchar(50)'
,N'QMS',74277,1,N'SWK700-P-BTG',N'MMD2',N'1.0000',N'tomms'

exec sp_executesql N'Insert pur_app ( site_cd , mst_RowID , pur_app_level , pur_app_cost_center , pur_app_empl_id , pur_app_pr_limit , pur_app_date , pur_app_status , pur_app_approval , audit_user , audit_date )
 Values ( @P1 , @P2 , @P3 , @P4 , @P5 , @P6 , NULL , ''P'' , NULL , @P7 , GetDate ( ) ) ',N'@P1 nvarchar(4),@P2 int,@P3 int,@P4 nvarchar(50),@P5 nvarchar(25),@P6 nvarchar(79),@P7 nvarchar(50)'
 ,N'QMS',74277,2,N'SWK700-P-BTG',N'QHQAGM1',N'2.0000',N'tomms'

exec sp_executesql N'Insert pur_app ( site_cd , mst_RowID , pur_app_level , pur_app_cost_center , pur_app_empl_id , pur_app_pr_limit , pur_app_date , pur_app_status , pur_app_approval , audit_user , audit_date )
 Values ( @P1 , @P2 , @P3 , @P4 , @P5 , @P6 , NULL , ''P'' , NULL , @P7 , GetDate ( ) ) ',N'@P1 nvarchar(4),@P2 int,@P3 int,@P4 nvarchar(50),@P5 nvarchar(25),@P6 nvarchar(79),@P7 nvarchar(50)'
 ,N'QMS',74277,3,N'SWK700-P-BTG',N'FIN1',N'3.0000',N'tomms'

 exec sp_executesql N'Insert pur_app ( site_cd , mst_RowID , pur_app_level , pur_app_cost_center , pur_app_empl_id , pur_app_pr_limit , pur_app_date , pur_app_status , pur_app_approval , audit_user , audit_date ) 
 Values ( @P1 , @P2 , @P3 , @P4 , @P5 , @P6 , NULL , ''P'' , NULL , @P7 , GetDate ( ) ) ',N'@P1 nvarchar(4),@P2 int,@P3 int,@P4 nvarchar(50),@P5 nvarchar(25),@P6 nvarchar(79),@P7 nvarchar(50)'
 ,N'QMS',74277,4,N'SWK700-P-BTG',N'QHQCEO',N'999999999.9900',N'tomms'

 exec sp_executesql N'update pur_mst SET pur_mst_purq_approve =''W'' , pur_mst_app_level =@P1 , pur_mst_cur_app_level =0 , pur_mst_approver =@P2 WHERE site_cd =@P3 AND RowID =@P4 ',N'@P1 int,@P2 nvarchar(25),@P3 nvarchar(4),@P4 int'
 ,4,N'MMD2',N'QMS',74277

 select * from pur_mst where rowid in ( 74277,74359 )

 select * from pur_mst where pur_mst_approver = 'QHQAGM1'

 select * from emp_mst where emp_mst_empl_id = 'QHQCEO'
 --select * into pur_app_bak_2018_10_23 from pur_app
-- select * into pur_mst_bak_2018_10_23 from pur_mst


 select * from pur_app where mst_rowid = 74277
 exec sp_executesql N'SELECT		pur_mst.RowID
FROM 		pur_mst   
WHERE		pur_mst.site_cd = @P1
AND			pur_mst.pur_mst_chg_costcenter = @P2
AND			pur_mst.pur_mst_purq_approve IN (''W'', ''N'')',N'@P1 nvarchar(4),@P2 nvarchar(50)',N'QMS',N'SWK700-P-BTG'
*/
DELETE p 

from pur_app p join
(

select pur_mst.site_cd,pur_mst.RowID-- ,1,A.COST_CENTRE,'QHQAGM1',1,NULL,'P',NULL,'tomms',getdate()
from QHQAGM1 a
join pur_mst   
ON		pur_mst.site_cd = 'QMS'
AND			pur_mst.pur_mst_chg_costcenter = A.COST_CENTRE
AND			pur_mst.pur_mst_purq_approve IN ('W', 'N')
) b on p.mst_RowID = b.RowID
  

Insert pur_app ( site_cd , mst_RowID , pur_app_level , pur_app_cost_center , pur_app_empl_id , pur_app_pr_limit , pur_app_date , pur_app_status , pur_app_approval , audit_user , audit_date ) 
select pur_mst.site_cd,pur_mst.RowID ,1,A.COST_CENTRE,'QHQAGM1',1.0000,NULL,'P',NULL,'tomms',getdate()
from QHQAGM1 a
join pur_mst   
ON		pur_mst.site_cd = 'QMS'
AND			pur_mst.pur_mst_chg_costcenter = A.COST_CENTRE
AND			pur_mst.pur_mst_purq_approve IN ('W', 'N')

union all
select pur_mst.site_cd,pur_mst.RowID ,2,A.COST_CENTRE,'QHQAGM2',2.0000,NULL,'P',NULL,'tomms',getdate()
from QHQAGM1 a
join pur_mst   
ON		pur_mst.site_cd = 'QMS'
AND			pur_mst.pur_mst_chg_costcenter = A.COST_CENTRE
AND			pur_mst.pur_mst_purq_approve IN ('W', 'N')


union all
select pur_mst.site_cd,pur_mst.RowID ,3,A.COST_CENTRE,'FIN1',3.0000,NULL,'P',NULL,'tomms',getdate()
from QHQAGM1 a
join pur_mst   
ON		pur_mst.site_cd = 'QMS'
AND			pur_mst.pur_mst_chg_costcenter = A.COST_CENTRE
AND			pur_mst.pur_mst_purq_approve IN ('W', 'N')



 
union all
select pur_mst.site_cd,pur_mst.RowID ,4,A.COST_CENTRE,'QHQCEO',999999999.9900,NULL,'P',NULL,'tomms',getdate()
from QHQAGM1 a
join pur_mst   
ON		pur_mst.site_cd = 'QMS'
AND			pur_mst.pur_mst_chg_costcenter = A.COST_CENTRE
AND			pur_mst.pur_mst_purq_approve IN ('W', 'N')





update P SET pur_mst_purq_approve ='W' 
, pur_mst_app_level =4 
, pur_mst_cur_app_level =0
 , pur_mst_approver ='QHQAGM1'
 from
pur_mst p join
(

select pur_mst.site_cd,pur_mst.RowID-- ,1,A.COST_CENTRE,'QHQAGM1',1,NULL,'P',NULL,'tomms',getdate()
from QHQAGM1 a
join pur_mst   
ON		pur_mst.site_cd = 'QMS'
AND			pur_mst.pur_mst_chg_costcenter = A.COST_CENTRE
AND			pur_mst.pur_mst_purq_approve IN ('W', 'N')
) b on p.RowID = b.RowID

  --WHERE site_cd ='QMS' AND RowID =@P4 ',N'@P1 int,@P2 nvarchar(25),@P3 nvarchar(4),@P4 int',4,N'MMD2',N'QMS',74277
