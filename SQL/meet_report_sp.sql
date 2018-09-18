alter procedure meet_report_sp
@state_name varchar(300) = 'melaka'
,@submission_period date  = '2018-09-06'  
,@clinic_category varchar(300) = null
as
begin
set nocount on
--WILLAYAH PERSEKUTUAN LABUAN

declare @guid nvarchar(300) = newid()

if @state_name = 'All'
select @state_name = null

if @clinic_category = 'all'
select @clinic_category = null


insert meet
(
state
,district
,clinic_category
,session_id
)
select  distinct ast_mst_ast_lvl 'state',ast_mst_asset_locn 'district',ast_mst_asset_code,@guid
from     ast_mst a (nolock)
where   (ast_mst_ast_lvl = @state_name or @state_name is null)
and     (ast_mst_asset_code = @clinic_category or @clinic_category is null)

--insert meet
--(
--state
--,district
--,curr_tot_be
--,curr_mon_be
--,session_id
--)

update m
set 
curr_tot_be = total_item
,curr_mon_be = totalamt
 from meet m (nolock)
 join
 (
select  ast_mst_ast_lvl 'state',ast_mst_asset_locn 'district',ast_mst_asset_code,count(*) 'total_item',sum(b.ast_det_numeric8) 'totalamt' 
from    ast_mst a (nolock)
join    ast_det b (nolock)
on	    a.rowid  = b.mst_rowid
where   (ast_mst_ast_lvl = @state_name or @state_name is null)
and     a.ast_mst_asset_status in ('act','pbr')
and		left(a.ast_mst_safety_rqmts,2) in ('v1','v2')
and     ast_det_varchar15 = 'Existing'
and     (ast_mst_asset_code = @clinic_category or @clinic_category is null)
group by ast_mst_ast_lvl,ast_mst_asset_locn,ast_mst_asset_code
 
 ) b
 on m.state = b.state
 and m.district = b.district
 and m.clinic_category = ast_mst_asset_code
and m.session_id = @guid
 
update m
set    add_no_of_be = b.total_item
		,add_tot_rm = b.totalamt
from   meet m (nolock)
join (
select  ast_mst_ast_lvl 'state',ast_mst_asset_locn 'district',ast_mst_asset_code,count(*) 'total_item',sum(b.ast_det_numeric8) 'totalamt'
from    ast_mst a (nolock)
join    ast_det b (nolock)
on	    a.rowid  = b.mst_rowid
where   (ast_mst_ast_lvl = @state_name or @state_name is null)
and     a.ast_mst_asset_status in ('act','pbr')
and		left(a.ast_mst_safety_rqmts,2) in ('v8')
and     ast_det_varchar15 = 'Existing'
and     (ast_mst_asset_code = @clinic_category or @clinic_category is null)
group by ast_mst_ast_lvl,ast_mst_asset_locn,ast_mst_asset_code

)b
on m.state = b.state
and m.district = b.district
 and m.clinic_category = ast_mst_asset_code
and m.session_id = @guid

 

update meet 
set    omi_no_of_be = 0
		,omi_tot_rm = 0
		,tot_be = add_no_of_be - omi_no_of_be
		,tot_var = add_tot_rm - omi_tot_rm
		,new_tot_be =curr_tot_be + tot_be
		,new_mon_fee = curr_mon_be + tot_var
		,new_year_fee = ( curr_mon_be + tot_var) * 12
where session_id = @guid

select 

convert(varchar(50),@submission_period,103) submission_period
,clinic_category  
,state
,district
,curr_tot_be
,curr_mon_be
,add_no_of_be
,add_tot_rm
,omi_no_of_be
,omi_tot_rm
,tot_be
,tot_var
,new_tot_be
,new_mon_fee
,new_year_fee


from meet (nolock)
where session_id = @guid

delete from meet where session_id = @guid
set nocount off
end

/*
create table meet
(

submission_period   varchar(200)
,state				varchar(200)
,district			varchar(300)
,clinic_category    varchar(300)
,curr_tot_be		int default(0)
,curr_mon_be		numeric(28,2) default(0)
,add_no_of_be		int default(0)
,add_tot_rm			numeric(28,2) default(0)
,omi_no_of_be		int default(0)
,omi_tot_rm			numeric(28,2) default(0)
,tot_be				int default(0)
,tot_var			numeric(28,2) default(0)
,new_tot_be			int default(0)
,new_mon_fee		numeric(28,2) default(0)
,new_year_fee		numeric(28,2) default(0)
,session_id			nvarchar(800)

)

--drop table meet
*/



