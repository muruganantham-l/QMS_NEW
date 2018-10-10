using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Syncfusion.EJ.Export;
using Syncfusion.EJ;
using Syncfusion.XlsIO;
using System.Collections;
using System.IO;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
 
using System.Text;
using System.Xml.Serialization;
using System.Xml;
using FastMember;
using System.ComponentModel;

using System.Web.Script.Services;
using System.Web.Services;

public partial class DownloadMasters : System.Web.UI.Page
{
    List<Orders> order = new List<Orders>();
    List<Assets> AssetList = new List<Assets>();
    List<Assets> GridAssetList = new List<Assets>();
    string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
    Syncfusion.JavaScript.DataSources.DataOperations ds = new Syncfusion.JavaScript.DataSources.DataOperations();
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
    public override void VerifyRenderingInServerForm(Control control)
    {
        //base.VerifyRenderingInServerForm(control);
    }

    


    private List<Assets> BindDataSource1()
    {
         
        DataTable dt =null;
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select_ast_master", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@state_name", State_combobox.Value);
                
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                      dt = new DataTable();

                    da.Fill(dt);
                }
            }
        }
        //List<Assets> AssetList = new List<Assets>();
        AssetList = (from DataRow dr in dt.Rows
                       select new Assets()
                       {
                           ast_mst_asset_no = Convert.IsDBNull(dr["ast_mst_asset_no"]) ? null : dr["ast_mst_asset_no"].ToString(),
                           ast_mst_asset_type = Convert.IsDBNull(dr["ast_mst_asset_type"]) ? null : dr["ast_mst_asset_type"].ToString(),
                           ast_mst_asset_grpcode = Convert.IsDBNull(dr["ast_mst_asset_grpcode"]) ? null : dr["ast_mst_asset_grpcode"].ToString(),
                           ast_mst_asset_code = Convert.IsDBNull(dr["ast_mst_asset_code"]) ? null : dr["ast_mst_asset_code"].ToString(),
                           ast_mst_assigned_to = Convert.IsDBNull(dr["ast_mst_assigned_to"]) ? null : dr["ast_mst_assigned_to"].ToString(),
                           ast_mst_asset_shortdesc = Convert.IsDBNull(dr["ast_mst_asset_shortdesc"]) ? null : dr["ast_mst_asset_shortdesc"].ToString(),
                           ast_mst_asset_longdesc = Convert.IsDBNull(dr["ast_mst_asset_longdesc"]) ? null : dr["ast_mst_asset_longdesc"].ToString(),
                           ast_mst_perm_id = Convert.IsDBNull(dr["ast_mst_perm_id"]) ? null : dr["ast_mst_perm_id"].ToString(),
                           ast_mst_cost_center = Convert.IsDBNull(dr["ast_mst_cost_center"]) ? null : dr["ast_mst_cost_center"].ToString(),
                           ast_det_cus_code = Convert.IsDBNull(dr["ast_det_cus_code"]) ? null : dr["ast_det_cus_code"].ToString(),
                           ast_mst_asset_locn = Convert.IsDBNull(dr["ast_mst_asset_locn"]) ? null : dr["ast_mst_asset_locn"].ToString(),
                           ast_mst_safety_rqmts = Convert.IsDBNull(dr["ast_mst_safety_rqmts"]) ? null : dr["ast_mst_safety_rqmts"].ToString(),
                           ast_mst_work_area = Convert.IsDBNull(dr["ast_mst_work_area"]) ? null : dr["ast_mst_work_area"].ToString(),
                           ast_mst_cri_factor = Convert.IsDBNull(dr["ast_mst_cri_factor"]) ? null : dr["ast_mst_cri_factor"].ToString(),
                           ast_det_datetime8 = Convert.IsDBNull(dr["ast_det_datetime8"]) ? null : dr["ast_det_datetime8"] as DateTime?,
                           ast_det_datetime9 = Convert.IsDBNull(dr["ast_det_datetime9"]) ? null : dr["ast_det_datetime9"] as DateTime?,
                           ast_det_datetime10 = Convert.IsDBNull(dr["ast_det_datetime10"]) ? null : dr["ast_det_datetime10"] as DateTime?,
                           ast_det_datetime5 = Convert.IsDBNull(dr["ast_det_datetime5"]) ? null : dr["ast_det_datetime5"] as DateTime?,
                           ast_det_datetime6 = Convert.IsDBNull(dr["ast_det_datetime6"]) ? null : dr["ast_det_datetime6"] as DateTime?,
                           ast_det_datetime7 = Convert.IsDBNull(dr["ast_det_datetime7"]) ? null : dr["ast_det_datetime7"] as DateTime?,
                           ast_det_datetime2 = Convert.IsDBNull(dr["ast_det_datetime2"]) ? null : dr["ast_det_datetime2"] as DateTime?,
                           ast_det_datetime3 = Convert.IsDBNull(dr["ast_det_datetime3"]) ? null : dr["ast_det_datetime3"] as DateTime?,
                           ast_det_warranty_date = Convert.IsDBNull(dr["ast_det_warranty_date"]) ? null : dr["ast_det_warranty_date"] as DateTime?,
                           ast_det_datetime1 = Convert.IsDBNull(dr["ast_det_datetime1"]) ? null : dr["ast_det_datetime1"] as DateTime?,
                           ast_mst_wrk_grp = Convert.IsDBNull(dr["ast_mst_wrk_grp"]) ? null : dr["ast_mst_wrk_grp"].ToString(),
                           ast_mst_create_by = Convert.IsDBNull(dr["ast_mst_create_by"]) ? null : dr["ast_mst_create_by"].ToString(),
                           ast_mst_create_date = Convert.IsDBNull(dr["ast_mst_create_date"]) ? null : dr["ast_mst_create_date"] as DateTime?,
                           ast_det_purchase_date = Convert.IsDBNull(dr["ast_det_purchase_date"]) ? null : dr["ast_det_purchase_date"] as DateTime?,
                           ast_det_numeric2 = dr["ast_det_numeric2"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["ast_det_numeric2"])),
                           ast_det_varchar1 = Convert.IsDBNull(dr["ast_det_varchar1"]) ? null : dr["ast_det_varchar1"].ToString(),
                           ast_mst_asset_status = Convert.IsDBNull(dr["ast_mst_asset_status"]) ? null : dr["ast_mst_asset_status"].ToString(),
                           ast_mst_ast_lvl = Convert.IsDBNull(dr["ast_mst_ast_lvl"]) ? null : dr["ast_mst_ast_lvl"].ToString(),
                           ast_mst_parent_flag = Convert.IsDBNull(dr["ast_mst_parent_flag"]) ? null : dr["ast_mst_parent_flag"].ToString(),
                           ast_det_numeric8 = dr["ast_det_numeric8"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["ast_det_numeric8"])),

                           ast_det_numeric9 = dr["ast_det_numeric9"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["ast_det_numeric9"])),
                           ast_det_numeric1 = dr["ast_det_numeric1"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["ast_det_numeric1"])),
                           ast_det_note3 = Convert.IsDBNull(dr["ast_det_note3"]) ? null : dr["ast_det_note3"].ToString(),
                           ast_det_varchar30 = Convert.IsDBNull(dr["ast_det_varchar30"]) ? null : dr["ast_det_varchar30"].ToString(),
                           ast_det_note1 = Convert.IsDBNull(dr["ast_det_note1"]) ? null : dr["ast_det_note1"].ToString(),
                           ast_det_note2 = Convert.IsDBNull(dr["ast_det_note2"]) ? null : dr["ast_det_note2"].ToString(),
                           ast_det_varchar21 = Convert.IsDBNull(dr["ast_det_varchar21"]) ? null : dr["ast_det_varchar21"].ToString(),
                           ast_det_varchar22 = Convert.IsDBNull(dr["ast_det_varchar22"]) ? null : dr["ast_det_varchar22"].ToString(),
                           ast_det_varchar18 = Convert.IsDBNull(dr["ast_det_varchar18"]) ? null : dr["ast_det_varchar18"].ToString(),
                           ast_det_varchar19 = Convert.IsDBNull(dr["ast_det_varchar19"]) ? null : dr["ast_det_varchar19"].ToString(),
                           ast_det_varchar20 = Convert.IsDBNull(dr["ast_det_varchar20"]) ? null : dr["ast_det_varchar20"].ToString(),
                           ast_det_varchar15 = Convert.IsDBNull(dr["ast_det_varchar15"]) ? null : dr["ast_det_varchar15"].ToString(),
                           ast_det_asset_cost = dr["ast_det_asset_cost"] is DBNull ? 0 : double.Parse(Convert.ToString(dr["ast_det_asset_cost"])),
                           ast_det_mfg_cd = Convert.IsDBNull(dr["ast_det_mfg_cd"]) ? null : dr["ast_det_mfg_cd"].ToString(),
                           ast_det_modelno = Convert.IsDBNull(dr["ast_det_modelno"]) ? null : dr["ast_det_modelno"].ToString(),
                           ast_det_varchar2 = Convert.IsDBNull(dr["ast_det_varchar2"]) ? null : dr["ast_det_varchar2"].ToString(),
                           ast_det_varchar16 = Convert.IsDBNull(dr["ast_det_varchar16"]) ? null : dr["ast_det_varchar16"].ToString(),
                           ast_det_varchar17 = Convert.IsDBNull(dr["ast_det_varchar17"]) ? null : dr["ast_det_varchar17"].ToString(),
                           ast_det_varchar12 = Convert.IsDBNull(dr["ast_det_varchar12"]) ? null : dr["ast_det_varchar12"].ToString(),
                           ast_det_varchar13 = Convert.IsDBNull(dr["ast_det_varchar13"]) ? null : dr["ast_det_varchar13"].ToString(),
                           ast_det_varchar14 = Convert.IsDBNull(dr["ast_det_varchar14"]) ? null : dr["ast_det_varchar14"].ToString(),
                           ast_det_varchar9 = Convert.IsDBNull(dr["ast_det_varchar9"]) ? null : dr["ast_det_varchar9"].ToString(),
                           ast_det_varchar10 = Convert.IsDBNull(dr["ast_det_varchar10"]) ? null : dr["ast_det_varchar10"].ToString(),
                           ast_det_varchar11 = Convert.IsDBNull(dr["ast_det_varchar11"]) ? null : dr["ast_det_varchar11"].ToString(),
                           ast_det_varchar6 = Convert.IsDBNull(dr["ast_det_varchar6"]) ? null : dr["ast_det_varchar6"].ToString(),
                           ast_det_varchar7 = Convert.IsDBNull(dr["ast_det_varchar7"]) ? null : dr["ast_det_varchar7"].ToString(),
                           ast_det_varchar8 = Convert.IsDBNull(dr["ast_det_varchar8"]) ? null : dr["ast_det_varchar8"].ToString(),
                           ast_det_varchar5 = Convert.IsDBNull(dr["ast_det_varchar5"]) ? null : dr["ast_det_varchar5"].ToString(),
                           ast_det_taxable = Convert.IsDBNull(dr["ast_det_taxable"]) ? null : dr["ast_det_taxable"].ToString(),
                           ast_det_l_account = Convert.IsDBNull(dr["ast_det_l_account"]) ? null : dr["ast_det_l_account"].ToString(),
                           ast_det_m_account = Convert.IsDBNull(dr["ast_det_m_account"]) ? null : dr["ast_det_m_account"].ToString(),
                           ast_mst_print_count = Convert.IsDBNull(dr["ast_mst_print_count"]) ? null : dr["ast_mst_print_count"].ToString(),
                           ast_det_datetime4 = Convert.IsDBNull(dr["ast_det_datetime4"]) ? null : dr["ast_det_datetime4"] as DateTime?




                       }).ToList();
        return AssetList;
        //this.FlatGrid.DataSource = AssetList;

        //this.FlatGrid.DataBind();

    }
    [Serializable]

    public class Assets
    {
        public Assets()

        {



        }

        public Assets(
string ast_mst_asset_no
, string ast_mst_asset_type
, string ast_mst_asset_grpcode
, string ast_mst_asset_code
, string ast_mst_assigned_to
, string ast_mst_asset_shortdesc
, string ast_mst_asset_longdesc
, string ast_mst_perm_id
, string ast_mst_cost_center
, string ast_det_cus_code
, string ast_mst_asset_locn
, string ast_mst_safety_rqmts
, string ast_mst_work_area
, string ast_mst_cri_factor
, DateTime? ast_det_datetime8
, DateTime? ast_det_datetime9
, DateTime? ast_det_datetime10
, DateTime? ast_det_datetime5
, DateTime? ast_det_datetime6
, DateTime? ast_det_datetime7
, DateTime? ast_det_datetime2
, DateTime? ast_det_datetime3
, DateTime? ast_det_warranty_date
, DateTime? ast_det_datetime1
, string ast_mst_wrk_grp
, string ast_mst_create_by
, DateTime? ast_mst_create_date
, DateTime? ast_det_purchase_date
, double ast_det_numeric2
, string ast_det_varchar1
, string ast_mst_asset_status
, string ast_mst_ast_lvl
, string ast_mst_parent_flag
, double ast_det_numeric8
, double ast_det_numeric9
, double ast_det_numeric1
, string ast_det_note3
, string ast_det_varchar30
, string ast_det_note1
, string ast_det_note2
, string ast_det_varchar21
, string ast_det_varchar22
, string ast_det_varchar18
, string ast_det_varchar19
, string ast_det_varchar20
, string ast_det_varchar15
, double ast_det_asset_cost
, string ast_det_mfg_cd
, string ast_det_modelno
, string ast_det_varchar2
, string ast_det_varchar16
, string ast_det_varchar17
, string ast_det_varchar12
, string ast_det_varchar13
, string ast_det_varchar14
, string ast_det_varchar9
, string ast_det_varchar10
, string ast_det_varchar11
, string ast_det_varchar6
, string ast_det_varchar7
, string ast_det_varchar8
, string ast_det_varchar5
, string ast_det_taxable
, string ast_det_l_account
, string ast_det_m_account
, string ast_mst_print_count
, DateTime? ast_det_datetime4
)

        {

            this.ast_mst_asset_no = ast_mst_asset_no;
            this.ast_mst_asset_type = ast_mst_asset_type;
            this.ast_mst_asset_grpcode = ast_mst_asset_grpcode;
            this.ast_mst_asset_code = ast_mst_asset_code;
            this.ast_mst_assigned_to = ast_mst_assigned_to;
            this.ast_mst_asset_shortdesc = ast_mst_asset_shortdesc;
            this.ast_mst_asset_longdesc = ast_mst_asset_longdesc;
            this.ast_mst_perm_id = ast_mst_perm_id;
            this.ast_mst_cost_center = ast_mst_cost_center;
            this.ast_det_cus_code = ast_det_cus_code;
            this.ast_mst_asset_locn = ast_mst_asset_locn;
            this.ast_mst_safety_rqmts = ast_mst_safety_rqmts;
            this.ast_mst_work_area = ast_mst_work_area;
            this.ast_mst_cri_factor = ast_mst_cri_factor;
            this.ast_det_datetime8 = ast_det_datetime8;
            this.ast_det_datetime9 = ast_det_datetime9;
            this.ast_det_datetime10 = ast_det_datetime10;
            this.ast_det_datetime5 = ast_det_datetime5;
            this.ast_det_datetime6 = ast_det_datetime6;
            this.ast_det_datetime7 = ast_det_datetime7;
            this.ast_det_datetime2 = ast_det_datetime2;
            this.ast_det_datetime3 = ast_det_datetime3;
            this.ast_det_warranty_date = ast_det_warranty_date;
            this.ast_det_datetime1 = ast_det_datetime1;
            this.ast_mst_wrk_grp = ast_mst_wrk_grp;
            this.ast_mst_create_by = ast_mst_create_by;
            this.ast_mst_create_date = ast_mst_create_date;
            this.ast_det_purchase_date = ast_det_purchase_date;
            this.ast_det_numeric2 = ast_det_numeric2;
            this.ast_det_varchar1 = ast_det_varchar1;
            this.ast_mst_asset_status = ast_mst_asset_status;
            this.ast_mst_ast_lvl = ast_mst_ast_lvl;
            this.ast_mst_parent_flag = ast_mst_parent_flag;
            this.ast_det_numeric8 = ast_det_numeric8;
            this.ast_det_numeric9 = ast_det_numeric9;
            this.ast_det_numeric1 = ast_det_numeric1;
            this.ast_det_note3 = ast_det_note3;
            this.ast_det_varchar30 = ast_det_varchar30;
            this.ast_det_note1 = ast_det_note1;
            this.ast_det_note2 = ast_det_note2;
            this.ast_det_varchar21 = ast_det_varchar21;
            this.ast_det_varchar22 = ast_det_varchar22;
            this.ast_det_varchar18 = ast_det_varchar18;
            this.ast_det_varchar19 = ast_det_varchar19;
            this.ast_det_varchar20 = ast_det_varchar20;
            this.ast_det_varchar15 = ast_det_varchar15;
            this.ast_det_asset_cost = ast_det_asset_cost;
            this.ast_det_mfg_cd = ast_det_mfg_cd;
            this.ast_det_modelno = ast_det_modelno;
            this.ast_det_varchar2 = ast_det_varchar2;
            this.ast_det_varchar16 = ast_det_varchar16;
            this.ast_det_varchar17 = ast_det_varchar17;
            this.ast_det_varchar12 = ast_det_varchar12;
            this.ast_det_varchar13 = ast_det_varchar13;
            this.ast_det_varchar14 = ast_det_varchar14;
            this.ast_det_varchar9 = ast_det_varchar9;
            this.ast_det_varchar10 = ast_det_varchar10;
            this.ast_det_varchar11 = ast_det_varchar11;
            this.ast_det_varchar6 = ast_det_varchar6;
            this.ast_det_varchar7 = ast_det_varchar7;
            this.ast_det_varchar8 = ast_det_varchar8;
            this.ast_det_varchar5 = ast_det_varchar5;
            this.ast_det_taxable = ast_det_taxable;
            this.ast_det_l_account = ast_det_l_account;
            this.ast_det_m_account = ast_det_m_account;
            this.ast_mst_print_count = ast_mst_print_count;
            this.ast_det_datetime4 = ast_det_datetime4;


        }


        public string ast_mst_asset_no { get; set; }
        public string ast_mst_asset_type { get; set; }
        public string ast_mst_asset_grpcode { get; set; }
        public string ast_mst_asset_code { get; set; }
        public string ast_mst_assigned_to { get; set; }
        public string ast_mst_asset_shortdesc { get; set; }
        public string ast_mst_asset_longdesc { get; set; }
        public string ast_mst_perm_id { get; set; }
        public string ast_mst_cost_center { get; set; }
        public string ast_det_cus_code { get; set; }
        public string ast_mst_asset_locn { get; set; }
        public string ast_mst_safety_rqmts { get; set; }
        public string ast_mst_work_area { get; set; }
        public string ast_mst_cri_factor { get; set; }
        public DateTime? ast_det_datetime8 { get; set; }
        public DateTime? ast_det_datetime9 { get; set; }
        public DateTime? ast_det_datetime10 { get; set; }
        public DateTime? ast_det_datetime5 { get; set; }
        public DateTime? ast_det_datetime6 { get; set; }
        public DateTime? ast_det_datetime7 { get; set; }
        public DateTime? ast_det_datetime2 { get; set; }
        public DateTime? ast_det_datetime3 { get; set; }
        public DateTime? ast_det_warranty_date { get; set; }
        public DateTime? ast_det_datetime1 { get; set; }
        public string ast_mst_wrk_grp { get; set; }
        public string ast_mst_create_by { get; set; }
        public DateTime? ast_mst_create_date { get; set; }
        public DateTime? ast_det_purchase_date { get; set; }
        public double ast_det_numeric2 { get; set; }
        public string ast_det_varchar1 { get; set; }
        public string ast_mst_asset_status { get; set; }
        public string ast_mst_ast_lvl { get; set; }
        public string ast_mst_parent_flag { get; set; }
        public double ast_det_numeric8 { get; set; }
        public double ast_det_numeric9 { get; set; }
        public double ast_det_numeric1 { get; set; }
        public string ast_det_note3 { get; set; }
        public string ast_det_varchar30 { get; set; }
        public string ast_det_note1 { get; set; }
        public string ast_det_note2 { get; set; }
        public string ast_det_varchar21 { get; set; }
        public string ast_det_varchar22 { get; set; }
        public string ast_det_varchar18 { get; set; }
        public string ast_det_varchar19 { get; set; }
        public string ast_det_varchar20 { get; set; }
        public string ast_det_varchar15 { get; set; }
        public double ast_det_asset_cost { get; set; }
        public string ast_det_mfg_cd { get; set; }
        public string ast_det_modelno { get; set; }
        public string ast_det_varchar2 { get; set; }
        public string ast_det_varchar16 { get; set; }
        public string ast_det_varchar17 { get; set; }
        public string ast_det_varchar12 { get; set; }
        public string ast_det_varchar13 { get; set; }
        public string ast_det_varchar14 { get; set; }
        public string ast_det_varchar9 { get; set; }
        public string ast_det_varchar10 { get; set; }
        public string ast_det_varchar11 { get; set; }
        public string ast_det_varchar6 { get; set; }
        public string ast_det_varchar7 { get; set; }
        public string ast_det_varchar8 { get; set; }
        public string ast_det_varchar5 { get; set; }
        public string ast_det_taxable { get; set; }
        public string ast_det_l_account { get; set; }
        public string ast_det_m_account { get; set; }
        public string ast_mst_print_count { get; set; }
        public DateTime? ast_det_datetime4 { get; set; }

    }
    
    [Serializable]
    public class Orders

    {

        public Orders()

        {



        }

        public Orders(long OrderId, string CustomerId, int EmployeeId, double Freight, DateTime OrderDate, string ShipCity)

        {

            this.OrderID = OrderId;

            this.CustomerID = CustomerId;

            this.EmployeeID = EmployeeId;

            this.Freight = Freight;

            this.OrderDate = OrderDate;

            this.ShipCity = ShipCity;

        }

        public long OrderID { get; set; }

        public string CustomerID { get; set; }

        public int EmployeeID { get; set; }

        public double Freight { get; set; }

        public DateTime OrderDate { get; set; }

        public string ShipCity { get; set; }

    }

    protected void FlatGrid_ServerExcelExporting(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)

    {

        //ExcelExport exp = new ExcelExport();

        //exp.Export(FlatGrid.Model, (IEnumerable)FlatGrid.DataSource, "Export.xlsx", ExcelVersion.Excel2013, true, true, "flat-lime");
        ExportExcel_Click();

    }


    public class ListtoDataTable
    {
        public DataTable ToDataTable<T>(List<T> items)
        {
            DataTable dataTable = new DataTable(typeof(T).Name);
            //Get all the properties by using reflection   
            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Setting column names as Property names  
                dataTable.Columns.Add(prop.Name);
            }
            foreach (T item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {

                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }

            return dataTable;
        }
    }


    public void ExportExcel_Click()
    {
        state_load();
        //foreach (char gr in   FlatGrid.Model.ColumnSelected.ToList())
        //  {
        //      TextBox1.Text = gr.ToString();
        //  }
        BindDataSource1();//this is importent kanna
        //GridAssetList = this.FlatGrid.DataSource as List<Assets>;//this is importent kanna
        Syncfusion.JavaScript.DataSources.DataOperations ds = new Syncfusion.JavaScript.DataSources.DataOperations();
        var data1 = ds.Execute(AssetList, this.FlatGrid.Model); // passed the grid dataSource and grid dataSource in DataOperations execute method
        //var data1 = ds.Execute(GridAssetList, this.FlatGrid.Model); // passed the grid dataSource and grid dataSource in DataOperations execute method
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=AssetRegister.xls");
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


    

    protected void search_btn_Click(object sender, EventArgs e)
    {
        state_load(); 
        //BindDataSource1();
        this.FlatGrid.DataSource = BindDataSource1(); ;// AssetList;

        this.FlatGrid.DataBind();
    }
}