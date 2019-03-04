ALTER proc pr_approval_list_refresh_sp
@pr_no varchar(100) =  NULL
as
--PR124945
begin

--SELECT *
--from emp_mst m join emp_ls2 l on m.RowID = l.mst_RowID where l.RowID = 15619

----delete m  from  wko_mst m --join wko_det d on m.RowID = d.mst_RowID 
----where 
----year(m.wko_mst_org_date) = '2020'
----wko_mst_wo_no = 'pwo416879'
DELETE pur_app WHERE site_cd = 'QMS' AND mst_RowID = (SELECT RowID from pur_mst m where m.pur_mst_porqnnum = @pr_no)
--SELECT* from pur_mst m where m.RowID = '68738'
-- join pur_app p on m.RowID = p.mst_RowID where mst_RowID = '68738'
Insert pur_app ( site_cd , mst_RowID , pur_app_level , pur_app_cost_center 
, pur_app_empl_id , pur_app_pr_limit , pur_app_date , pur_app_status 
, pur_app_approval , audit_user , audit_date ) 
SELECT m.site_cd,m.RowID,l.emp_ls2_level,m.pur_mst_chg_costcenter,
L.emp_ls2_empl_id,l.emp_ls2_pr_approval_limit,NULL,'P',null,'patch',GETDATE()
from   pur_mst m
join  emp_ls2 l on m.pur_mst_chg_costcenter = l.emp_ls2_costcenter
WHERE-- emp_ls2_costcenter = 'png220-p-bda'
  emp_ls2_approver = 1
  and m.pur_mst_porqnnum = @pr_no
order by emp_ls2_level

update pur_mst SET pur_mst_purq_approve ='W'
--, pur_mst_app_level =@P1 
, pur_mst_cur_app_level =0 
--, pur_mst_approver =@P2 
WHERE site_cd = 'QMS' AND RowID =(SELECT RowID from pur_mst m where m.pur_mst_porqnnum = @pr_no)
 

--Values ( @P1 site_cd , @P2 mst_RowID , @P3 pur_app_level , @P4 pur_app_cost_center, @P5 pur_app_empl_id , @P6 pur_app_pr_limit
--, NULL pur_app_date, ''P'' pur_app_status , NULL pur_app_approval , @P7  audit_user, GetDate ( ) audit_date ) 
--',N'@P1 nvarchar(4),@P2 int,@P3 int,@P4 nvarchar(50),@P5 nvarchar(25),@P6 nvarchar(79),@P7 nvarchar(50)'
--,N'QMS',68738,1,N'PNG220-P-BDA',N'MMD2',N'1.0000',N'tomms'

end

go 

exec pr_approval_list_refresh_sp