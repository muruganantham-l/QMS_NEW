using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;

public partial class ValidateVCMvalueForPenalty : System.Web.UI.Page
{
    static string cons = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
    static SqlConnection con = new SqlConnection(cons);
    List<VCM_Values> AssetList = new List<VCM_Values>();
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
                state_load();
                year_load();
                quarter_load();

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
            //  string com = "Select 1,ast_lvl_ast_lvl, ast_lvl_ast_lvl  from ast_lvl (nolock) union select 0,'All' , 'All'";
            string com = "select DISTINCT ast_loc_state ast_lvl_ast_lvl from ast_loc a join UserInformation u on a.ast_loc_zone = u.Zone and u.username ='" + validated_by + "'";
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

    public void district_load()
    {
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(connString);
            /*For District Dropdown Load*/
            string com1 = "select 1 RowID,'ALL' ast_loc_ast_loc union select RowID , ast_loc_ast_loc from  ast_loc (nolock) where ast_loc_state = '" + State_combobox.Value + "'";

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
    public void year_load()
    {
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(connString);
            /*For District Dropdown Load*/
            string com1 = " ;with yearlist as(   select year(getdate()) as year    union all    select yl.year - 1 as year    from yearlist yl    where yl.year - 1 >= YEAR(GetDate()) - 3) select year year_id,year year_txt from yearlist order by year desc; ";

            SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
            DataTable dt1 = new DataTable();
            adpt1.Fill(dt1);
            Year_ComboBox.DataSource = dt1;
            Year_ComboBox.DataBind();
            Year_ComboBox.DataTextField = "year_id";
            Year_ComboBox.DataValueField = "year_txt";
            Year_ComboBox.DataBind();
            // DropDownState.Items.Insert(0, new ListItem("ALL", "0"));
            //DropDownYear.Items.Insert(0, new ListItem("--Select--", "0"));

        }
        catch (Exception ex)
        {
            //log error 
            //display friendly error to user
            string msg = "Insert Error:";
            msg += ex.Message;


        }

    }

    public void quarter_load()
    {
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(connString);
            string com2 = " select 'Quarter 1' 'quarter_txt','Q1' 'quarter_id' union select 'Quarter 2','Q2' union select 'Quarter 3','Q3' union select 'Quarter 4','Q4' UNION select 'ALL','ALL' ";

            SqlDataAdapter adpt2 = new SqlDataAdapter(com2, con);
            DataTable dt2 = new DataTable();
            adpt2.Fill(dt2);
            Quarter_ComboBox.DataSource = dt2;
            Quarter_ComboBox.DataBind();
            Quarter_ComboBox.DataTextField = "quarter_txt";
            Quarter_ComboBox.DataValueField = "quarter_id";
            Quarter_ComboBox.DataBind();
            // DropDownState.Items.Insert(0, new ListItem("ALL", "0"));
            //DropDownquarter.Items.Insert(0, new ListItem("--Select--", "0"));

        }
        catch (Exception ex)
        {
            //log error 
            //display friendly error to user
            string msg = "Insert Error:";
            msg += ex.Message;


        }

    }
    protected void Button1_Click(object Sender, Syncfusion.JavaScript.Web.ButtonEventArgs e)
    {
        state_load(); year_load();
        quarter_load();
        this.SQLDataGrid.DataSource = null;
        this.SQLDataGrid.DataSource = BindDataSource1(); ;// AssetList;
    }

    protected void SQLDataGrid_ServerEditRow(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        ExecuteToSQL("curd_vcm_value_for_penalty_sp", e.EventType, e.Arguments["data"]);  // SQLUpdate stored procedure
        this.SQLDataGrid.DataSource = null;
        this.SQLDataGrid.DataSource = BindDataSource1(); ;// AssetList;

        this.SQLDataGrid.DataBind();
        state_load();
        year_load();
        quarter_load();
    }

    protected void SQLDataGrid_ServerCommandButtonClick(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        ExecuteToSQL("curd_vcm_value_for_penalty_sp", "endEdit", e.Arguments["data"]);  // SQLUpdate stored procedure
        this.SQLDataGrid.DataSource = null;
        this.SQLDataGrid.DataSource = BindDataSource1(); ;// AssetList;

        this.SQLDataGrid.DataBind();
        state_load();
        year_load();
        quarter_load();
    }

    protected void State_combobox_ValueSelect(object sender, Syncfusion.JavaScript.Web.ComboBoxEventArgs e)
    {
    district_load(); state_load(); year_load();
        quarter_load();
    }
    public static void ExecuteToSQL(string commandText, string eventType, object record)
    {
        Dictionary<string, object> KeyVal = record as Dictionary<string, object>;
        var Order = KeyVal.Values.ToArray();
        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.CommandText = commandText; // Stored procedure for editing actions
        sqlCommand.CommandType = CommandType.StoredProcedure;
        if (eventType == "endDelete")
        {
            // Pass parameter to SQLRemove stored procedure
            sqlCommand.Parameters.Add(new SqlParameter("@SupplierID", Order[0]));
        }
        else if (eventType == "endAdd" || eventType == "endEdit")
        {
            //ValidateBEAssetInformation b = new ValidateBEAssetInformation();

            sqlCommand.Parameters.Add(new SqlParameter("@Action", "update"));
            // Pass parameter to SQLInsert and SQLUpdate stored procedures
             sqlCommand.Parameters.Add(new SqlParameter("@s_no", Order[0]));
            sqlCommand.Parameters.Add(new SqlParameter("@clinic_category", Order[2]));
            sqlCommand.Parameters.Add(new SqlParameter("@response_time_penalty", Order[3]));
            sqlCommand.Parameters.Add(new SqlParameter("@repair_time_penalty", Order[4]));
            sqlCommand.Parameters.Add(new SqlParameter("@Preventive_Maintenance_Penalty", Order[5]));
            //sqlCommand.Parameters.Add(new SqlParameter("@Total_Penalty", Order[6]));
            sqlCommand.Parameters.Add(new SqlParameter("@validated_by", validated_by));


        }
        sqlCommand.Connection = con;
        if (con.State != ConnectionState.Open)
            con.Open();
        sqlCommand.ExecuteNonQuery();
        con.Close();
    }


    [Serializable]

    public class VCM_Values
    {
        public VCM_Values()

        {



        }

        public VCM_Values(
  int row_no
, string s_no
, string clinic_category
, string response_time_penalty
, string repair_time_penalty
, string Preventive_Maintenance_Penalty
, string Total_Penalty
 
, string validated_by
, DateTime? validated_date
, string created_by
, DateTime? created_date
, string modified_by
, DateTime? modified_date
)

        {

            this.row_no = row_no;
            this.s_no = s_no;
            this.clinic_category = clinic_category;
            this.response_time_penalty = response_time_penalty;
            this.repair_time_penalty = repair_time_penalty;
            this.Preventive_Maintenance_Penalty = Preventive_Maintenance_Penalty;
            this.Total_Penalty = Total_Penalty; 
            this.validated_by = validated_by;
            this.validated_date = validated_date;
            this.created_by = created_by;
            this.created_date = created_date;
            this.modified_by = modified_by;
            this.modified_date = modified_date;

        }


        public int row_no { get; set; }
        public string s_no { get; set; }
        public string clinic_category { get; set; }
        public string response_time_penalty { get; set; }
        public string repair_time_penalty { get; set; }
        public string Preventive_Maintenance_Penalty { get; set; }
        public string Total_Penalty { get; set; } 
        public string validated_by { get; set; }
        public string created_by { get; set; }
        public string modified_by { get; set; }

        public DateTime? validated_date { get; set; }
        public DateTime? created_date { get; set; }
        public DateTime? modified_date { get; set; }


    }
    private List<VCM_Values> BindDataSource1()
    {

        DataTable dt = null;
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("curd_vcm_value_for_penalty_sp", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@state", State_combobox.Value);
                cmd.Parameters.AddWithValue("@Action", "SELECT");
                cmd.Parameters.Add("@validate_flag", SqlDbType.VarChar).Value = validate_flagDropDownList.Value.ToString();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    dt = new DataTable();

                    da.Fill(dt);
                }
            }
        }
        //List<Assets> AssetList = new List<Assets>();
        AssetList = (from DataRow dr in dt.Rows
                     select new VCM_Values()
                     {
                         row_no = dr["s_no"] is DBNull ? 0 : int.Parse(Convert.ToString(dr["s_no"])),

                         s_no = Convert.IsDBNull(dr["row_no"]) ? null : dr["row_no"].ToString(),
                         clinic_category = Convert.IsDBNull(dr["clinic_category"]) ? null : dr["clinic_category"].ToString(),
                         response_time_penalty = Convert.IsDBNull(dr["response_time"]) ? null : dr["response_time"].ToString(),
                         repair_time_penalty = Convert.IsDBNull(dr["repair_time"]) ? null : dr["repair_time"].ToString(),
                         Preventive_Maintenance_Penalty = Convert.IsDBNull(dr["schedule_maintenance"]) ? null : dr["schedule_maintenance"].ToString(),
                         Total_Penalty = Convert.IsDBNull(dr["Total_Penalty"]) ? null : dr["Total_Penalty"].ToString(), 
                         validated_by = Convert.IsDBNull(dr["validated_by"]) ? null : dr["validated_by"].ToString(),
                         created_by = Convert.IsDBNull(dr["created_by"]) ? null : dr["created_by"].ToString(),
                         modified_by = Convert.IsDBNull(dr["modified_by"]) ? null : dr["modified_by"].ToString(),

                         validated_date = Convert.IsDBNull(dr["validated_date"]) ? null : dr["validated_date"] as DateTime?,
                         created_date = Convert.IsDBNull(dr["created_date"]) ? null : dr["created_date"] as DateTime?,
                         modified_date = Convert.IsDBNull(dr["modified_date"]) ? null : dr["modified_date"] as DateTime?




                     }).ToList();
        return AssetList;
        //this.FlatGrid.DataSource = AssetList;

        //this.FlatGrid.DataBind();

    }


}