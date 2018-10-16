CREATE proc additional_be_list_ssrs_sp
as
begin
set nocount on

select 
row_number() over(partition by State,Clinic_Code order by State,district,Clinic_Code, BE_Number)  SI_No
,BE_Number
,dbo.InitCap(Be_Category) Be_Category
,Clinic_Code
,dbo.InitCap(Clinic_Name) Clinic_Name
,dbo.InitCap(Clinic_Address) Clinic_Address
,dbo.InitCap([Clinic Category] ) Clinic_Category

,dbo.InitCap(State) State
,dbo.InitCap(District) District
,Purchase_Cost
,Maintenance_Revenue_Month
,dbo.InitCap(Ownership) Ownership
from  additional_be_list_ssrs (nolock)


set nocount off
end

