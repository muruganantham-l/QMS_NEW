using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

using Syncfusion.EJ.Export;
using Syncfusion.EJ;
using Syncfusion.XlsIO;
using System.Collections;
using System.IO; 
using System.Reflection;

using System.Text;
using System.Xml.Serialization;
using System.Xml;
using FastMember;
using System.ComponentModel;

using System.Web.Script.Services;
using System.Web.Services;
public partial class DownloadWorkOrder : System.Web.UI.Page
{
    List<WorkOrders> WorkOrdersList = new List<WorkOrders>();
    string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["name"] == null)
            {

                Session["prevUrl"] = Request.Url;
                Response.Redirect("~/Login.aspx");

            }
            else
            {
                state_load();
            }


        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        //base.VerifyRenderingInServerForm(control);
    }

    public void state_load()
    {

        SqlConnection con = null;

        try
        {
            con = new SqlConnection(connString);
            /*For State Dropdown Load*/
            string com = "Select 1,ast_lvl_ast_lvl, ast_lvl_ast_lvl  from ast_lvl (nolock) union select 0,'All' , 'All'";

            SqlDataAdapter adpt = new SqlDataAdapter(com, con);
            DataTable dt = new DataTable();
            adpt.Fill(dt);
            State_combobox.DataSource = dt;
            State_combobox.DataBind();
            State_combobox.DataTextField = "ast_lvl_ast_lvl";
            State_combobox.DataValueField = "ast_lvl_ast_lvl";
            State_combobox.DataBind();
        }

        catch (Exception ex)
        {
            //log error 
            //display friendly error to user
            string msg = "Insert Error:";
            msg += ex.Message;
            throw new Exception(msg);

        }
        finally
        {
            con.Close();
        }
    }

    [Serializable]
public class WorkOrders
{
        public WorkOrders()

        {



        }



        public WorkOrders(

            string wko_mst_wo_no
, string wko_mst_assetno
, string wko_det_parent_wo
, string wko_det_pm_grp
, string wko_mst_status
, string wko_mst_descs
, DateTime? wko_mst_org_date
, DateTime? wko_mst_due_date
, string wko_mst_chg_costcenter
, DateTime? wko_det_cmpl_date
, DateTime? wko_det_clo_date
, string wko_det_assign_to
, string wko_det_planner
, string wko_mst_flt_code
, string wko_det_cause_code
, string wko_det_act_code
, string wko_mst_originator
, string wko_mst_phone
, string wko_mst_project_id
, string wko_mst_work_area
, string wko_mst_asset_location
, string wko_mst_asset_level
, string wko_mst_asset_group_code
, string wko_mst_orig_priority
, string wko_mst_plan_priority
, string wko_det_temp_asset
, string wko_det_wr_no
, string wko_det_perm_id
, string wko_det_work_type
, string wko_det_work_grp
, DateTime? wko_det_sc_date
, DateTime? wko_det_sched_date
, string wko_det_contract_no
, string wko_det_delay_cd
, string wko_det_customer_cd
, string wko_det_supv_id
, double? wko_det_est_con_cost
, double? wko_det_con_cost
, double? wko_det_est_mtl_cost
, double? wko_det_mtl_cost
, double? wko_det_est_lab_cost
, double? wko_det_lab_cost
, string wko_det_varchar1
, string wko_det_varchar2
, string wko_det_varchar3
, string wko_det_varchar4
, string wko_det_varchar5
, string wko_det_varchar6
, string wko_det_varchar7
, string wko_det_varchar8
, string wko_det_varchar9
, double? wko_det_numeric1
, double? wko_det_numeric3
, DateTime? wko_det_datetime1
, DateTime? wko_det_datetime4
, DateTime? wko_det_exc_date
, string wko_det_note1
, string wko_mst_create_by
, DateTime? wko_mst_create_date


            )

        {

            this.wko_mst_wo_no = wko_mst_wo_no;
            this.wko_mst_assetno = wko_mst_assetno;
            this.wko_det_parent_wo = wko_det_parent_wo;
            this.wko_det_pm_grp = wko_det_pm_grp;
            this.wko_mst_status = wko_mst_status;
            this.wko_mst_descs = wko_mst_descs;
            this.wko_mst_org_date = wko_mst_org_date;
            this.wko_mst_due_date = wko_mst_due_date;
            this.wko_mst_chg_costcenter = wko_mst_chg_costcenter;
            this.wko_det_cmpl_date = wko_det_cmpl_date;
            this.wko_det_clo_date = wko_det_clo_date;
            this.wko_det_assign_to = wko_det_assign_to;
            this.wko_det_planner = wko_det_planner;
            this.wko_mst_flt_code = wko_mst_flt_code;
            this.wko_det_cause_code = wko_det_cause_code;
            this.wko_det_act_code = wko_det_act_code;
            this.wko_mst_originator = wko_mst_originator;
            this.wko_mst_phone = wko_mst_phone;
            this.wko_mst_project_id = wko_mst_project_id;
            this.wko_mst_work_area = wko_mst_work_area;
            this.wko_mst_asset_location = wko_mst_asset_location;
            this.wko_mst_asset_level = wko_mst_asset_level;
            this.wko_mst_asset_group_code = wko_mst_asset_group_code;
            this.wko_mst_orig_priority = wko_mst_orig_priority;
            this.wko_mst_plan_priority = wko_mst_plan_priority;
            this.wko_det_temp_asset = wko_det_temp_asset;
            this.wko_det_wr_no = wko_det_wr_no;
            this.wko_det_perm_id = wko_det_perm_id;
            this.wko_det_work_type = wko_det_work_type;
            this.wko_det_work_grp = wko_det_work_grp;
            this.wko_det_sc_date = wko_det_sc_date;
            this.wko_det_sched_date = wko_det_sched_date;
            this.wko_det_contract_no = wko_det_contract_no;
            this.wko_det_delay_cd = wko_det_delay_cd;
            this.wko_det_customer_cd = wko_det_customer_cd;
            this.wko_det_supv_id = wko_det_supv_id;
            this.wko_det_est_con_cost = wko_det_est_con_cost;
            this.wko_det_con_cost = wko_det_con_cost;
            this.wko_det_est_mtl_cost = wko_det_est_mtl_cost;
            this.wko_det_mtl_cost = wko_det_mtl_cost;
            this.wko_det_est_lab_cost = wko_det_est_lab_cost;
            this.wko_det_lab_cost = wko_det_lab_cost;
            this.wko_det_varchar1 = wko_det_varchar1;
            this.wko_det_varchar2 = wko_det_varchar2;
            this.wko_det_varchar3 = wko_det_varchar3;
            this.wko_det_varchar4 = wko_det_varchar4;
            this.wko_det_varchar5 = wko_det_varchar5;
            this.wko_det_varchar6 = wko_det_varchar6;
            this.wko_det_varchar7 = wko_det_varchar7;
            this.wko_det_varchar8 = wko_det_varchar8;
            this.wko_det_varchar9 = wko_det_varchar9;
            this.wko_det_numeric1 = wko_det_numeric1;
            this.wko_det_numeric3 = wko_det_numeric3;
            this.wko_det_datetime1 = wko_det_datetime1;
            this.wko_det_datetime4 = wko_det_datetime4;
            this.wko_det_exc_date = wko_det_exc_date;
            this.wko_det_note1 = wko_det_note1;
            this.wko_mst_create_by = wko_mst_create_by;
            this.wko_mst_create_date = wko_mst_create_date;

        }
        #region Instance Properties
        public string wko_mst_wo_no { get; set; }

        public string wko_mst_assetno { get; set; }

        public string wko_det_parent_wo { get; set; }

        public string wko_det_pm_grp { get; set; }

        public string wko_mst_status { get; set; }

        public string wko_mst_descs { get; set; }

        public DateTime? wko_mst_org_date { get; set; }

        public DateTime? wko_mst_due_date { get; set; }

        public string wko_mst_chg_costcenter { get; set; }

        public DateTime? wko_det_cmpl_date { get; set; }

        public DateTime? wko_det_clo_date { get; set; }

        public string wko_det_assign_to { get; set; }

        public string wko_det_planner { get; set; }

        public string wko_mst_flt_code { get; set; }

        public string wko_det_cause_code { get; set; }

        public string wko_det_act_code { get; set; }

        public string wko_mst_originator { get; set; }

        public string wko_mst_phone { get; set; }

        public string wko_mst_project_id { get; set; }

        public string wko_mst_work_area { get; set; }

        public string wko_mst_asset_location { get; set; }

        public string wko_mst_asset_level { get; set; }

        public string wko_mst_asset_group_code { get; set; }

        public string wko_mst_orig_priority { get; set; }

        public string wko_mst_plan_priority { get; set; }

        public string wko_det_temp_asset { get; set; }

        public string wko_det_wr_no { get; set; }

        public string wko_det_perm_id { get; set; }

        public string wko_det_work_type { get; set; }

        public string wko_det_work_grp { get; set; }

        public DateTime? wko_det_sc_date { get; set; }

        public DateTime? wko_det_sched_date { get; set; }

        public string wko_det_contract_no { get; set; }

        public string wko_det_delay_cd { get; set; }

        public string wko_det_customer_cd { get; set; }

        public string wko_det_supv_id { get; set; }

        public double? wko_det_est_con_cost { get; set; }

        public double? wko_det_con_cost { get; set; }

        public double? wko_det_est_mtl_cost { get; set; }

        public double? wko_det_mtl_cost { get; set; }

        public double? wko_det_est_lab_cost { get; set; }

        public double? wko_det_lab_cost { get; set; }

        public string wko_det_varchar1 { get; set; }

        public string wko_det_varchar2 { get; set; }

        public string wko_det_varchar3 { get; set; }

        public string wko_det_varchar4 { get; set; }

        public string wko_det_varchar5 { get; set; }

        public string wko_det_varchar6 { get; set; }

        public string wko_det_varchar7 { get; set; }

        public string wko_det_varchar8 { get; set; }

        public string wko_det_varchar9 { get; set; }

        public double? wko_det_numeric1 { get; set; }

        public double? wko_det_numeric3 { get; set; }

        public DateTime? wko_det_datetime1 { get; set; }

        public DateTime? wko_det_datetime4 { get; set; }

        public DateTime? wko_det_exc_date { get; set; }

        public string wko_det_note1 { get; set; }

        public string wko_mst_create_by { get; set; }

        public DateTime? wko_mst_create_date { get; set; }



        #endregion Instance Properties}

    private List<WorkOrders> BindDataSource1()
    {
        DataTable dt = null;
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select_wo_master", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@state", State_combobox.Value);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    dt = new DataTable();

                    da.Fill(dt);
                }
            }
        }

        WorkOrdersList = (from DataRow dr in dt.Rows
                     select new WorkOrders()
                     {

                         wko_mst_wo_no = Convert.IsDBNull(dr["wko_mst_wo_no"]) ? null : dr["wko_mst_wo_no"].ToString(),
                         wko_mst_assetno = Convert.IsDBNull(dr["wko_mst_assetno"]) ? null : dr["wko_mst_assetno"].ToString(),
                         wko_det_parent_wo = Convert.IsDBNull(dr["wko_det_parent_wo"]) ? null : dr["wko_det_parent_wo"].ToString(),
                         wko_det_pm_grp = Convert.IsDBNull(dr["wko_det_pm_grp"]) ? null : dr["wko_det_pm_grp"].ToString(),
                         wko_mst_status = Convert.IsDBNull(dr["wko_mst_status"]) ? null : dr["wko_mst_status"].ToString(),
                         wko_mst_descs = Convert.IsDBNull(dr["wko_mst_descs"]) ? null : dr["wko_mst_descs"].ToString(),
                         wko_mst_org_date = Convert.IsDBNull(dr["wko_mst_org_date"]) ? null : dr["wko_mst_org_date"] as DateTime?,
                         wko_mst_due_date = Convert.IsDBNull(dr["wko_mst_due_date"]) ? null : dr["wko_mst_due_date"] as DateTime?,
                         wko_mst_chg_costcenter = Convert.IsDBNull(dr["wko_mst_chg_costcenter"]) ? null : dr["wko_mst_chg_costcenter"].ToString(),
                         wko_det_cmpl_date = Convert.IsDBNull(dr["wko_det_cmpl_date"]) ? null : dr["wko_det_cmpl_date"] as DateTime?,
                         wko_det_clo_date = Convert.IsDBNull(dr["wko_det_clo_date"]) ? null : dr["wko_det_clo_date"] as DateTime?,
                         wko_det_assign_to = Convert.IsDBNull(dr["wko_det_assign_to"]) ? null : dr["wko_det_assign_to"].ToString(),
                         wko_det_planner = Convert.IsDBNull(dr["wko_det_planner"]) ? null : dr["wko_det_planner"].ToString(),
                         wko_mst_flt_code = Convert.IsDBNull(dr["wko_mst_flt_code"]) ? null : dr["wko_mst_flt_code"].ToString(),
                         wko_det_cause_code = Convert.IsDBNull(dr["wko_det_cause_code"]) ? null : dr["wko_det_cause_code"].ToString(),
                         wko_det_act_code = Convert.IsDBNull(dr["wko_det_act_code"]) ? null : dr["wko_det_act_code"].ToString(),
                         wko_mst_originator = Convert.IsDBNull(dr["wko_mst_originator"]) ? null : dr["wko_mst_originator"].ToString(),
                         wko_mst_phone = Convert.IsDBNull(dr["wko_mst_phone"]) ? null : dr["wko_mst_phone"].ToString(),
                         wko_mst_project_id = Convert.IsDBNull(dr["wko_mst_project_id"]) ? null : dr["wko_mst_project_id"].ToString(),
                         wko_mst_work_area = Convert.IsDBNull(dr["wko_mst_work_area"]) ? null : dr["wko_mst_work_area"].ToString(),
                         wko_mst_asset_location = Convert.IsDBNull(dr["wko_mst_asset_location"]) ? null : dr["wko_mst_asset_location"].ToString(),
                         wko_mst_asset_level = Convert.IsDBNull(dr["wko_mst_asset_level"]) ? null : dr["wko_mst_asset_level"].ToString(),
                         wko_mst_asset_group_code = Convert.IsDBNull(dr["wko_mst_asset_group_code"]) ? null : dr["wko_mst_asset_group_code"].ToString(),
                         wko_mst_orig_priority = Convert.IsDBNull(dr["wko_mst_orig_priority"]) ? null : dr["wko_mst_orig_priority"].ToString(),
                         wko_mst_plan_priority = Convert.IsDBNull(dr["wko_mst_plan_priority"]) ? null : dr["wko_mst_plan_priority"].ToString(),
                         wko_det_temp_asset = Convert.IsDBNull(dr["wko_det_temp_asset"]) ? null : dr["wko_det_temp_asset"].ToString(),
                         wko_det_wr_no = Convert.IsDBNull(dr["wko_det_wr_no"]) ? null : dr["wko_det_wr_no"].ToString(),
                         wko_det_perm_id = Convert.IsDBNull(dr["wko_det_perm_id"]) ? null : dr["wko_det_perm_id"].ToString(),
                         wko_det_work_type = Convert.IsDBNull(dr["wko_det_work_type"]) ? null : dr["wko_det_work_type"].ToString(),
                         wko_det_work_grp = Convert.IsDBNull(dr["wko_det_work_grp"]) ? null : dr["wko_det_work_grp"].ToString(),
                         wko_det_sc_date = Convert.IsDBNull(dr["wko_det_sc_date"]) ? null : dr["wko_det_sc_date"] as DateTime?,
                         wko_det_sched_date = Convert.IsDBNull(dr["wko_det_sched_date"]) ? null : dr["wko_det_sched_date"] as DateTime?,
                         wko_det_contract_no = Convert.IsDBNull(dr["wko_det_contract_no"]) ? null : dr["wko_det_contract_no"].ToString(),
                         wko_det_delay_cd = Convert.IsDBNull(dr["wko_det_delay_cd"]) ? null : dr["wko_det_delay_cd"].ToString(),
                         wko_det_customer_cd = Convert.IsDBNull(dr["wko_det_customer_cd"]) ? null : dr["wko_det_customer_cd"].ToString(),
                         wko_det_supv_id = Convert.IsDBNull(dr["wko_det_supv_id"]) ? null : dr["wko_det_supv_id"].ToString(),
                        
                         wko_det_varchar1 = Convert.IsDBNull(dr["wko_det_varchar1"]) ? null : dr["wko_det_varchar1"].ToString(),
                         wko_det_varchar2 = Convert.IsDBNull(dr["wko_det_varchar2"]) ? null : dr["wko_det_varchar2"].ToString(),
                         wko_det_varchar3 = Convert.IsDBNull(dr["wko_det_varchar3"]) ? null : dr["wko_det_varchar3"].ToString(),
                         wko_det_varchar4 = Convert.IsDBNull(dr["wko_det_varchar4"]) ? null : dr["wko_det_varchar4"].ToString(),
                         wko_det_varchar5 = Convert.IsDBNull(dr["wko_det_varchar5"]) ? null : dr["wko_det_varchar5"].ToString(),
                         wko_det_varchar6 = Convert.IsDBNull(dr["wko_det_varchar6"]) ? null : dr["wko_det_varchar6"].ToString(),
                         wko_det_varchar7 = Convert.IsDBNull(dr["wko_det_varchar7"]) ? null : dr["wko_det_varchar7"].ToString(),
                         wko_det_varchar8 = Convert.IsDBNull(dr["wko_det_varchar8"]) ? null : dr["wko_det_varchar8"].ToString(),
                         wko_det_varchar9 = Convert.IsDBNull(dr["wko_det_varchar9"]) ? null : dr["wko_det_varchar9"].ToString(),
                        
                         wko_det_datetime1 = Convert.IsDBNull(dr["wko_det_datetime1"]) ? null : dr["wko_det_datetime1"] as DateTime ?,
                         wko_det_datetime4 = Convert.IsDBNull(dr["wko_det_datetime4"]) ? null : dr["wko_det_datetime4"] as DateTime ?,
                         wko_det_exc_date = Convert.IsDBNull(dr["wko_det_exc_date"]) ? null : dr["wko_det_exc_date"] as DateTime ?,
                         wko_det_note1 = Convert.IsDBNull(dr["wko_det_note1"]) ? null : dr["wko_det_note1"].ToString(),
                         wko_mst_create_by = Convert.IsDBNull(dr["wko_mst_create_by"]) ? null : dr["wko_mst_create_by"].ToString(),
                         wko_mst_create_date = Convert.IsDBNull(dr["wko_mst_create_date"]) ? null : dr["wko_mst_create_date"] as DateTime?,

                         wko_det_est_con_cost = dr["wko_det_est_con_cost"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["wko_det_est_con_cost"])),


                         wko_det_con_cost = dr["wko_det_con_cost"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["wko_det_con_cost"])),
                         wko_det_est_mtl_cost = dr["wko_det_est_mtl_cost"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["wko_det_est_mtl_cost"])),
                         wko_det_mtl_cost = dr["wko_det_mtl_cost"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["wko_det_mtl_cost"])),
                         wko_det_est_lab_cost = dr["wko_det_est_lab_cost"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["wko_det_est_lab_cost"])),
                         wko_det_lab_cost = dr["wko_det_lab_cost"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["wko_det_lab_cost"])),
                         wko_det_numeric1 = dr["wko_det_numeric1"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["wko_det_numeric1"])),
                         wko_det_numeric3 = dr["wko_det_numeric3"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["wko_det_numeric3"]))

                     }).ToList();

        return WorkOrdersList;
    }
    public void ExportExcel_Click()
    {
        
        //foreach (char gr in   FlatGrid.Model.ColumnSelected.ToList())
        //  {
        //      TextBox1.Text = gr.ToString();
        //  }
        BindDataSource1();//this is importent kanna
        //GridAssetList = this.FlatGrid.DataSource as List<Assets>;//this is importent kanna
        Syncfusion.JavaScript.DataSources.DataOperations ds = new Syncfusion.JavaScript.DataSources.DataOperations();
        var data1 = ds.Execute(WorkOrdersList, this.FlatGrid.Model); // passed the grid dataSource and grid dataSource in DataOperations execute method
        //var data1 = ds.Execute(GridAssetList, this.FlatGrid.Model); // passed the grid dataSource and grid dataSource in DataOperations execute method
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=Work Orders.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {

            HtmlTextWriter hw = new HtmlTextWriter(sw);
            GridView1.AllowPaging = false;
            GridView1.DataSource = data1;
            GridView1.DataBind();
            GridView1.RenderControl(hw);

            string style = @"<style>.textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();

        }
    }
    protected void FlatGrid_ServerWordExporting(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)

    {

        WordExport exp = new WordExport();

        exp.Export(FlatGrid.Model, (IEnumerable)FlatGrid.DataSource, "Export.docx", true, true, "flat-lime");

    }



    protected void FlatGrid_ServerPdfExporting(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)

    {

        PdfExport exp = new PdfExport();

        exp.Export(FlatGrid.Model, (IEnumerable)FlatGrid.DataSource, "Export.pdf", true, true, "flat-lime");

    }



    protected void Button1_Click(object Sender, Syncfusion.JavaScript.Web.ButtonEventArgs e)
    {
        state_load();
        this.FlatGrid.DataSource = BindDataSource1(); ;// AssetList;

        this.FlatGrid.DataBind();
    }

    protected void FlatGrid_ServerWordExporting1(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {

    }
    protected void FlatGrid_ServerExcelExporting(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)

    {
        state_load();
        //ExcelExport exp = new ExcelExport();

        //exp.Export(FlatGrid.Model, (IEnumerable)FlatGrid.DataSource, "Export.xlsx", ExcelVersion.Excel2013, true, true, "flat-lime");
        ExportExcel_Click();

    }

}