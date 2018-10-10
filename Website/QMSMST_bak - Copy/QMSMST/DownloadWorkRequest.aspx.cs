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

public partial class DownloadWorkRequest : System.Web.UI.Page
{
    List<WorkRequests> WorkRequestsList = new List<WorkRequests>();
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
    public class WorkRequests
    {
        public WorkRequests()

        {



        }

        public WorkRequests(

         string wkr_mst_wr_no

, DateTime? wkr_mst_org_date

, string wkr_mst_assetno

, string wkr_mst_location
, string wkr_mst_assetlocn
, string wkr_mst_create_by
, string wkr_det_cus_code
, string wkr_det_note1



         )

        {

            this.wkr_mst_wr_no = wkr_mst_wr_no;
            this.wkr_mst_org_date = wkr_mst_org_date;
            this.wkr_mst_assetno = wkr_mst_assetno;
            this.wkr_mst_location = wkr_mst_location;
            this.wkr_mst_assetlocn = wkr_mst_assetlocn;
            this.wkr_mst_create_by = wkr_mst_create_by;
            this.wkr_det_cus_code = wkr_det_cus_code;
            this.wkr_det_note1 = wkr_det_note1;
            

        }
        #region Instance Properties
        public string wkr_mst_wr_no { get; set; }

        

        public DateTime? wkr_mst_org_date { get; set; }

       

        public string wkr_mst_location { get; set; }

       
        public string wkr_mst_assetlocn { get; set; }

        public string wkr_mst_create_by { get; set; }

        public string wkr_det_cus_code { get; set; }

        public string wkr_det_note1 { get; set; }

        public string wkr_mst_assetno { get; set; }

       


        #endregion Instance Properties}

    protected void Button1_Click(object Sender, Syncfusion.JavaScript.Web.ButtonEventArgs e)
    {
        state_load();
        this.FlatGrid.DataSource = BindDataSource1(); ;// AssetList;

        this.FlatGrid.DataBind();
    }

    private List<WorkRequests> BindDataSource1()
    {
        DataTable dt = null;
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select_wr_master", sqlcon))
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

        WorkRequestsList = (from DataRow dr in dt.Rows
                          select new WorkRequests()
                          {

                              wkr_mst_wr_no = Convert.IsDBNull(dr["wkr_mst_wr_no"]) ? null : dr["wkr_mst_wr_no"].ToString(),
                              wkr_mst_org_date = Convert.IsDBNull(dr["wkr_mst_org_date"]) ? null : dr["wkr_mst_org_date"] as DateTime?,


                              wkr_mst_assetno = Convert.IsDBNull(dr["wkr_mst_assetno"]) ? null : dr["wkr_mst_assetno"].ToString(),
                              wkr_mst_location = Convert.IsDBNull(dr["wkr_mst_location"]) ? null : dr["wkr_mst_location"].ToString(),
                              wkr_mst_assetlocn = Convert.IsDBNull(dr["wkr_mst_assetlocn"]) ? null : dr["wkr_mst_assetlocn"].ToString(),
                              wkr_mst_create_by = Convert.IsDBNull(dr["wkr_mst_create_by"]) ? null : dr["wkr_mst_create_by"].ToString(),
                              wkr_det_cus_code = Convert.IsDBNull(dr["wkr_det_cus_code"]) ? null : dr["wkr_det_cus_code"].ToString(),
                              wkr_det_note1 = Convert.IsDBNull(dr["wkr_det_note1"]) ? null : dr["wkr_det_note1"].ToString(),
                             
                            
                          }).ToList();

        return WorkRequestsList;
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

    protected void FlatGrid_ServerExcelExporting(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)

    {
        state_load();
        //ExcelExport exp = new ExcelExport();

        //exp.Export(FlatGrid.Model, (IEnumerable)FlatGrid.DataSource, "Export.xlsx", ExcelVersion.Excel2013, true, true, "flat-lime");
        ExportExcel_Click();

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
        var data1 = ds.Execute(WorkRequestsList, this.FlatGrid.Model); // passed the grid dataSource and grid dataSource in DataOperations execute method
        //var data1 = ds.Execute(GridAssetList, this.FlatGrid.Model); // passed the grid dataSource and grid dataSource in DataOperations execute method
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=Work Request.xls");
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
}