using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Web.Services;
using System.Web.Script.Services;
using Syncfusion.JavaScript;
using Syncfusion.JavaScript.DataSources;
 

public partial class BILLEntry : System.Web.UI.Page
{
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static void BatchUpdate(List<Asset> changed, List<Asset> added, List<Asset> deleted)
    {
        //if (deleted != null)
        //    for (int i = 0; i <= deleted.Count() - 1; i++)
        //    {
        //        var record = order.Where(o => o.OrderID == deleted.ElementAt(i).OrderID).FirstOrDefault();
        //        order.Remove(record);
        //    }

        //if (changed != null)
        //{

        //}
        //for (int i = 0; i <= changed.Count() ; i++)
        //{
        //    var record = order.Where(o => o.OrderID == deleted.ElementAt(i).OrderID).FirstOrDefault();
        //    order.Remove(record);
        //}
    }
    static string cons = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
    static SqlConnection con = new SqlConnection(cons);
    List<Asset> AssetList = new List<Asset>();
    static List<State> StateList = new List<State>();
    string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
    public static string validated_by;// = Session["name"].ToString();
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
                validated_by = Session["name"].ToString();
                //state_load();
                this.State_combobox.DataSource = state_load();
                this.DropDownclinicname.MultiColumnSettings.SearchColumnIndices = new List<int> { 0, 1 };
                this.BENumberAutocomplete.MultiColumnSettings.SearchColumnIndices = new List<int> { 0 };
               
            }

        }
    }
    [Serializable]

    public class State
    {
        public State()

        {



        }

        public State(
 
 string ast_lvl_ast_lvl
 
)

        {

            this.ast_lvl_ast_lvl = ast_lvl_ast_lvl;
           
        }


      
        public string ast_lvl_ast_lvl { get; set; }
       


    }
    [Serializable]

    public class Asset
    {
        public Asset()

        {



        }

        public Asset(
  int rowid
, string s_no
, string be_number
, string batch
, string install_start_date
, string install_end_date
, string curr_install_no
  , string prev_install_status
            ,string curr_install_status
, string created_by
, DateTime? created_date
, string modified_by
, DateTime? modified_date
            ,bool curr_install_status1
)

        {

            this.rowid = rowid;
            this.s_no = s_no;
            this.be_number = be_number;
            this.batch = batch;
            this.install_start_date = install_start_date;
            this.install_end_date = install_end_date;
            this.curr_install_no = curr_install_no;
            this.prev_install_status = prev_install_status;
            this.curr_install_status = curr_install_status;
            this.created_by = created_by;
            this.created_date = created_date;
            this.modified_by = modified_by;
            this.modified_date = modified_date;
            this.curr_install_status1 = curr_install_status1;

        }


        public int          rowid                { get; set; }
        public string       s_no                   { get; set; }
        public string       be_number             { get; set; }
        public string       batch                   { get; set; }
        public string       install_start_date      { get; set; }
        public string       install_end_date         { get; set; }
        public string       curr_install_no         { get; set; }
        public string       prev_install_status     { get; set; }
        public string       curr_install_status { get; set; }
        public string       created_by              { get; set; }
        public string       modified_by             { get; set; } 
        public DateTime?    created_date            { get; set; }
        public DateTime?    modified_date               { get; set; }
        public Boolean      curr_install_status1 { get; set; }

    }
    public List<Asset> BindDataSource1()
    {

        DataTable dt = null;
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("curd_NBE_bill_sp", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@state", State_combobox.Text);
                cmd.Parameters.AddWithValue("@Action", "SELECT");

                cmd.Parameters.AddWithValue("@district"         ,  District_combobox.Text);
                cmd.Parameters.AddWithValue("@clinic_category"  , DropDownCliniccat.Text);
                cmd.Parameters.AddWithValue("@clinic_code"      , DropDownclinicname.Value);
                cmd.Parameters.AddWithValue("@installment_year" , DropDownListInstallmentYear.Value);
                cmd.Parameters.AddWithValue("@installment_month", DropDownListInstallmentMonth.Value  );
                cmd.Parameters.AddWithValue("@be_number", BENumberAutocomplete.Value  );
                cmd.Parameters.AddWithValue("@batch", DropDownListBatch.Value);



                //cmd.Parameters.Add("@validate_flag", SqlDbType.VarChar).Value = validate_flagDropDownList.Value.ToString();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    dt = new DataTable();

                    da.Fill(dt);
                }
            }
        }
        //List<Assets> AssetList = new List<Assets>();
        AssetList = (from DataRow dr in dt.Rows
                     select new Asset()
                     {
                         rowid = dr["rowid"] is DBNull ? 0 : int.Parse(Convert.ToString(dr["rowid"])),
                         s_no = Convert.IsDBNull(dr["s_no"]) ? null : dr["s_no"].ToString(),

                         be_number = Convert.IsDBNull(dr["be_number"]) ? null : dr["be_number"].ToString(),
                         batch = Convert.IsDBNull(dr["batch"]) ? null : dr["batch"].ToString(),
                         install_start_date = Convert.IsDBNull(dr["install_start_date"]) ? null : dr["install_start_date"].ToString(),
                         install_end_date = Convert.IsDBNull(dr["install_end_date"]) ? null : dr["install_end_date"].ToString(),
                         curr_install_no = Convert.IsDBNull(dr["curr_install_no"]) ? null : dr["curr_install_no"].ToString(),


                         //curr_install_status = Convert.IsDBNull(dr["curr_install_status"]) ? null : dr["curr_install_status"].ToString(),
                         //created_by = Convert.IsDBNull(dr["created_by"]) ? null : dr["created_by"].ToString(),
                         modified_by = Convert.IsDBNull(dr["modified_by"]) ? null : dr["modified_by"].ToString(),

                         //created_date = Convert.IsDBNull(dr["created_date"]) ? null : dr["created_date"] as DateTime?,
                         modified_date = Convert.IsDBNull(dr["modified_date"]) ? null : dr["modified_date"] as DateTime?,
                         curr_install_status1 =   Convert.ToBoolean( Convert.IsDBNull(dr["curr_install_status1"]) ? null : dr["curr_install_status1"].ToString())



                     }).ToList();
        return AssetList;
        //this.FlatGrid.DataSource = AssetList;

        //this.FlatGrid.DataBind();

    }

    private static List<State> state_load()
    {
         
        DataTable dt = null;
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select DISTINCT ast_loc_state ast_lvl_ast_lvl from ast_loc a join UserInformation u on a.ast_loc_state = IIF(u.State = 'HQ',a.ast_loc_state,u.state) and u.username ='" + validated_by + "'", sqlcon))
            {
                cmd.CommandType = CommandType.Text;
                
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    dt = new DataTable();

                    da.Fill(dt);
                }
                
            }
        }
        //List<Assets> AssetList = new List<Assets>();
        StateList = (from DataRow dr in dt.Rows
                     select new State()
                     { 
                         ast_lvl_ast_lvl = Convert.IsDBNull(dr["ast_lvl_ast_lvl"]) ? null : dr["ast_lvl_ast_lvl"].ToString()

                   


                     }).ToList();
        return StateList;
        //this.FlatGrid.DataSource = AssetList;

        //this.FlatGrid.DataBind();

    }

    
    public void district_load()
    {
        
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(connString);
            /*For District Dropdown Load*/
            string com1 = "select 'ALL' RowID,'ALL' ast_loc_ast_loc union select 'ALL' , ast_loc_ast_loc from  ast_loc (nolock) where ast_loc_state = '" + State_combobox.Value + "'";

            SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
            DataTable dt1 = new DataTable();
            adpt1.Fill(dt1);
            District_combobox.DataSource = dt1;
            District_combobox.DataBind();
            District_combobox.DataTextField = "ast_loc_ast_loc";
            District_combobox.DataValueField = "RowID";
            District_combobox.DataBind();
            //District_combobox.Value.Insert(0, new ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            //log error 
            //display friendly error to user
            string msg = "Insert Error:";
            msg += ex.Message;


        }

    }

    public void clinic_category_load()
    {
        DropDownCliniccat.DataSource = null;
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(connString);
            /*For District Dropdown Load*/
            string com1 = "select 'ALL' RowID,'ALL' Cliniccat union select 'KESIHATAN' , 'KESIHATAN' union select   'PERGIGIAN','PERGIGIAN'  ";

            SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
            DataTable dt1 = new DataTable();
            adpt1.Fill(dt1);
            DropDownCliniccat.DataSource = dt1;
            DropDownCliniccat.DataBind();
            DropDownCliniccat.DataTextField = "Cliniccat";
            DropDownCliniccat.DataValueField = "RowID";
            DropDownCliniccat.DataBind();
            //District_combobox.Value.Insert(0, new ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            //log error 
            //display friendly error to user
            string msg = "Insert Error:";
            msg += ex.Message;


        }

    }

    public void installment_year_load()
    { 
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(connString);
            /*For District Dropdown Load*/
            string com1 = ";with cte as (SELECT year(min(ast_det_datetime3)) 'start_year',year(max(ast_det_datetime4)) 'end_year' from ast_det (NOLOCK) UNION ALL SELECT start_year + 1 as start_year,end_year from   cte c WHERE  c.start_year < c.end_year) SELECT start_year from cte  ";

            SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
            DataTable dt1 = new DataTable();
            adpt1.Fill(dt1);
            DropDownListInstallmentYear.DataSource = dt1;
            DropDownListInstallmentYear.DataBind();
            DropDownListInstallmentYear.DataTextField = "start_year";
            DropDownListInstallmentYear.DataValueField = "start_year";
            DropDownListInstallmentYear.DataBind();
            //District_combobox.Value.Insert(0, new ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            //log error 
            //display friendly error to user
            string msg = "Insert Error:";
            msg += ex.Message;


        }

    }
    public void installment_month_load()
    {
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(connString);
            /*For District Dropdown Load*/
            string com1 = "SELECT DATENAME(MONTH, DATEADD(MM, s.number, CONVERT(DATETIME, 0))) AS [MonthName], MONTH(DATEADD(MM, s.number, CONVERT(DATETIME, 0))) AS[MonthNumber] FROM master.dbo.spt_values (nolock) s WHERE [type] = 'P' AND s.number BETWEEN 0 AND 11 ORDER BY 2 ";

            SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
            DataTable dt1 = new DataTable();
            adpt1.Fill(dt1);
            DropDownListInstallmentMonth.DataSource = dt1;
            DropDownListInstallmentMonth.DataBind();
            DropDownListInstallmentMonth.DataTextField = "MonthName";
            DropDownListInstallmentMonth.DataValueField = "MonthNumber";
            DropDownListInstallmentMonth.DataBind();
            //District_combobox.Value.Insert(0, new ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            //log error 
            //display friendly error to user
            string msg = "Insert Error:";
            msg += ex.Message;


        }

    }

    public void batch_load()
    {
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(connString);
            /*For District Dropdown Load*/
            string com1 = "select distinct ast_det_varchar21 'Batchname' , ast_det_varchar21 'Batchno' from ast_det (nolock) where ast_det_varchar15 in ('New Biomedical' , 'Purchased Biomedical')";

            SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
            DataTable dt1 = new DataTable();
            adpt1.Fill(dt1);
            DropDownListBatch.DataSource = dt1;
            DropDownListBatch.DataBind();
            DropDownListBatch.DataTextField = "Batchname";
            DropDownListBatch.DataValueField = "Batchno";
            DropDownListBatch.DataBind();
            //District_combobox.Value.Insert(0, new ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            //log error 
            //display friendly error to user
            string msg = "Insert Error:";
            msg += ex.Message;


        }

    }

    protected void State_combobox_ValueSelect(object sender, Syncfusion.JavaScript.Web.ComboBoxEventArgs e)
    {
        district_load(); state_load(); clinic_category_load(); GridView1.DataSource = null;
        //rebind to gridview
        GridView1.DataBind();
    }

    protected void Button1_Click(object Sender, Syncfusion.JavaScript.Web.ButtonEventArgs e)
    {
        be_number_load();
        //district_load();
        ////state_load()            ;
        //clinic_category_load();
        //this.SQLDataGrid.DataSource = null;
        //this.Grid.DataSource = BindDataSource1();
        //this.Grid.DataBind();

        GridView1.DataSource = BindDataSource1();
        GridView1.DataBind();

    }

    protected void SQLDataGrid_ServerCommandButtonClick(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {

    }

    protected void SQLDataGrid_ServerEditRow(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {

    }

     

    public void clinic_name_load()
    {
        DropDownclinicname.Value = null;
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(connString);
            /*For District Dropdown Load*/
            SqlCommand cmd = new SqlCommand("exec search_clinic_name_sp '" + State_combobox.Text + "','" +
               District_combobox.Text + "','" + DropDownCliniccat.Text + "'", con);
             
            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);
            DropDownclinicname.DataSource = dt;
            DropDownclinicname.DataBind();
           

        }
        catch (Exception ex)
        {
            //log error 
            //display friendly error to user
            string msg = "Insert Error:";
            msg += ex.Message;


        }

    }

    public void be_number_load()
    {
        
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(connString);
            /*For District Dropdown Load*/
            SqlCommand cmd = new SqlCommand("exec search_be_number_sp '" + State_combobox.Text + "','" +
               District_combobox.Text + "','" + DropDownCliniccat.Text + "' ,'" + DropDownclinicname.Value + "' ,'" + DropDownListInstallmentYear.Text + "' ,'" + DropDownListInstallmentMonth.Value + "','" + DropDownListBatch.Value + "' ", con);

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);
            BENumberAutocomplete.DataSource = dt;
            BENumberAutocomplete.DataBind();


        }
        catch (Exception ex)
        {
            //log error 
            //display friendly error to user
            string msg = "Insert Error:";
            msg += ex.Message;


        }

    }
    protected void State_combobox_ValueSelect1(object sender, Syncfusion.JavaScript.Web.DropdownListEventArgs e)
    {
     district_load(); clinic_name_load();
        BENumberAutocomplete.Value = null; be_number_load();
        GridView1.DataSource = null;
        //rebind to gridview
        GridView1.DataBind();
    }

    protected void District_combobox_ValueSelect(object sender, Syncfusion.JavaScript.Web.DropdownListEventArgs e)
    {
        clinic_category_load(); clinic_name_load(); BENumberAutocomplete.Value = null; be_number_load();
        GridView1.DataSource = null;
        //rebind to gridview
        GridView1.DataBind();
    }

    protected void DropDownCliniccat_ValueSelect(object sender, Syncfusion.JavaScript.Web.DropdownListEventArgs e)
    {
        clinic_name_load(); installment_year_load(); BENumberAutocomplete.Value = null; be_number_load();
        GridView1.DataSource = null;
        //rebind to gridview
        GridView1.DataBind();
    }

    protected void DropDownclinicname_ValueSelect(object sender, Syncfusion.JavaScript.Web.AutocompleteSelectEventArgs e)
    {
        BENumberAutocomplete.Value = null; be_number_load();
        GridView1.DataSource = null;
        //rebind to gridview
        GridView1.DataBind();
    }

    protected void DropDownListInstallmentYear_ValueSelect(object sender, Syncfusion.JavaScript.Web.DropdownListEventArgs e)
    {
        installment_month_load(); BENumberAutocomplete.Value = null; be_number_load();
        GridView1.DataSource = null;
        //rebind to gridview
        GridView1.DataBind();
    }

    protected void DropDownListInstallmentMonth_ValueSelect(object sender, Syncfusion.JavaScript.Web.DropdownListEventArgs e)
    {

        batch_load();
        GridView1.DataSource = null;
        //rebind to gridview
        GridView1.DataBind();

    }

    protected void Save_Btn_Click(object Sender, Syncfusion.JavaScript.Web.ButtonEventArgs e)
    {
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        //var i=  Grid..SelectedRowIndices.ToList();
        
       string rowid                 ;
       string installment_year = DropDownListInstallmentYear.Value; ;
       string installment_month = DropDownListInstallmentMonth.Value;
       string be_number             ;
       string paid_flag             ;
       string audit_user     = validated_by;
        try
        {
            using (var con = new SqlConnection(connString))
            {
                using (var cmd = new SqlCommand())
                {
                    cmd.Connection = con;
                    cmd.CommandText = "update_NBE_bill_sp";
                    cmd.CommandType = CommandType.StoredProcedure;

                    // create all parameters outside the loop
                    // no need to use `cmd.Parameters.Clear()` here

                    cmd.Parameters.Add("@rowid", SqlDbType.VarChar);
                    cmd.Parameters.Add("@installment_year", SqlDbType.VarChar);
                    cmd.Parameters.Add("@installment_month", SqlDbType.VarChar);
                    cmd.Parameters.Add("@be_number", SqlDbType.VarChar);
                    cmd.Parameters.Add("@paid_flag", SqlDbType.VarChar);
                    cmd.Parameters.Add("@audit_user", SqlDbType.VarChar);

                    con.Open();

                    for (int i = 0; i < GridView1.Rows.Count; i++)
                    {
                        System.Web.UI.WebControls.CheckBox chkRow = (GridView1.Rows[i].Cells[0].FindControl("CheckBox1") as System.Web.UI.WebControls.CheckBox);
                        //(row.Cells[0].FindControl("CheckBox1") as System.Web.UI.WebControls.CheckBox);
                        if (chkRow.Checked)
                        {
                            paid_flag = "true";
                            //param6.Value = paid_flag;
                            //param7.Value = audit_user;



                        }
                        else
                        {
                            paid_flag = "false";
                            //param6.Value = paid_flag;
                            //param7.Value = audit_user;

                        }


                        cmd.Parameters["@rowid"].Value = ((Label)GridView1.Rows[i].Cells[1].FindControl("rowid_label")).Text;
                        //GridView1.Rows[i].Cells[1].Text;
                        cmd.Parameters["@installment_year"].Value = installment_year;
                        cmd.Parameters["@installment_month"].Value = installment_month;
                        cmd.Parameters["@be_number"].Value = GridView1.Rows[i].Cells[3].Text;
                        cmd.Parameters["@paid_flag"].Value = paid_flag;
                        cmd.Parameters["@audit_user"].Value = audit_user;

                        cmd.ExecuteNonQuery();
                    }
                }
            }



            GridView1.DataSource = BindDataSource1();
            //rebind to gridview
            GridView1.DataBind();


        }



        catch (Exception ex)
        {
            //log error 
            //display friendly error to user
            string msg = "Insert Error:";
            msg += ex.Message;
        }


    }
    public IEnumerable<Asset> GetAssets()
    {
        Grid.SelectedRowIndices.ToList();
        BILLEntry e = new BILLEntry();
        List<Asset> Assets = e.BindDataSource1();
        return Assets;
    }
    
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static object UrlDataSource(DataManager value)
    {
        BILLEntry b = new BILLEntry();
        IEnumerable<Asset> data = b.GetAssets();
        //DataOperations ds = new DataOperations();

        var count = data.AsQueryable().Count();

        //data = ds.PerformSkip(data, value.Skip);    //Paging
        //data = ds.PerformTake(data, value.Take);

        return new { result = data, count = count };
    }

    protected void Grid_ServerBatchEditRow(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        //Grid.SelectedRowIndices.ToList();
        
    }

    protected void Grid_ServerRowSelected(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        Response.Write("selectd");
    }

    protected void Grid_ServerRowDeselected(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        Response.Write("de selectd");
    }

    protected void Grid_ServerEditRow(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        Response.Write("edited");
    }

    protected void btnSaveSelected_Click(object sender, EventArgs e)
    {

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridView1.DataSource = BindDataSource1();
        GridView1.DataBind();

        //this.GridView1.BindGrid();
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)

        {

            e.Row.Attributes.Add("onmouseover", "MouseEvents(this, event)");

            e.Row.Attributes.Add("onmouseout", "MouseEvents(this, event)");

        }
    }

    protected void DropDownListBatch_ValueSelect(object sender, Syncfusion.JavaScript.Web.DropdownListEventArgs e)
    {
        BENumberAutocomplete.Value = null; be_number_load();
        GridView1.DataSource = null;
        //rebind to gridview
        GridView1.DataBind();
    }
}