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


public partial class ValidateBEAssetInformation : System.Web.UI.Page
{
    static string cons = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
    static SqlConnection con = new SqlConnection(cons);
    List<Assets> AssetList = new List<Assets>();
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
            string com = "select DISTINCT ast_loc_state ast_lvl_ast_lvl from ast_loc a join UserInformation u on a.ast_loc_zone = u.Zone and u.username ='" + validated_by +"'";
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
    protected void Button1_Click(object Sender, Syncfusion.JavaScript.Web.ButtonEventArgs e)
    {
        this.SQLDataGrid.DataSource = null;
        state_load();
        //BindDataSource1();
        this.SQLDataGrid.DataSource = BindDataSource1(); ;// AssetList;


        this.SQLDataGrid.DataBind();
    }

    protected void SQLDataGrid_ServerAddRow(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        ExecuteToSQL("SQLInsert", e.EventType, e.Arguments["data"]); // SQLInsert stored procedure
    }
    protected void SQLDataGrid_ServerEditRow(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        ExecuteToSQL("curd_be_asset_infrm_validate", e.EventType, e.Arguments["data"]);  // SQLUpdate stored procedure
        this.SQLDataGrid.DataSource = null;
       this.SQLDataGrid.DataSource = BindDataSource1(); ;// AssetList;

        this.SQLDataGrid.DataBind();
        state_load();
    }
    protected void SQLDataGrid_ServerDeleteRow(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        ExecuteToSQL("SQLDelete", e.EventType, e.Arguments["data"]); // SQLDelete stored procedure
    }
    // public static void ExecuteToSQL(string commandText, string eventType, object record)
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
          //  sqlCommand.Parameters.Add(new SqlParameter("@row_id", Order[0]));
            sqlCommand.Parameters.Add(new SqlParameter("@be_number", Order[1]));
            sqlCommand.Parameters.Add(new SqlParameter("@Manufacture", Order[3]));
            sqlCommand.Parameters.Add(new SqlParameter("@Model", Order[4]));
            sqlCommand.Parameters.Add(new SqlParameter("@SerialNumber", Order[5]));
            sqlCommand.Parameters.Add(new SqlParameter("@BELocation", Order[6]));
            sqlCommand.Parameters.Add(new SqlParameter("@KEWPA_Number", Order[7]));
            sqlCommand.Parameters.Add(new SqlParameter("@JKKP_Certificate_Number", Order[8]));
            sqlCommand.Parameters.Add(new SqlParameter("@validated_by", validated_by));

             
        }
        sqlCommand.Connection = con;
        if (con.State != ConnectionState.Open)
            con.Open();
        sqlCommand.ExecuteNonQuery();
        con.Close();
    }


    [Serializable]

    public class Assets
    {
        public Assets()

        {



        }

        public Assets(
  int    row_no
, string be_number
,string be_category
, string Manufacture
, string Model
, string SerialNumber
, string BELocation
, string KEWPA_Number
, string JKKP_Certificate_Number
, string validated_by
, DateTime? validated_date
, string created_by
, DateTime? created_date
, string modified_by
, DateTime? modified_date
)

        {

            this.row_no = row_no;
            this.be_number = be_number;
            this.be_category = be_category;
            this.Manufacture = Manufacture;
            this.Model = Model;
            this.SerialNumber = SerialNumber;
            this.BELocation = BELocation;
            this.KEWPA_Number = KEWPA_Number;
            this.JKKP_Certificate_Number = JKKP_Certificate_Number;
            this.validated_by = validated_by;
            this.validated_date = validated_date;
            this.created_by = created_by;
            this.created_date = created_date;
            this.modified_by = modified_by;
            this.modified_date = modified_date;
             
        }


        public int    row_no                            { get; set; }
        public string be_number                          { get; set; }
        public string be_category { get; set; }
        public string Manufacture                            { get; set; }
        public string Model                                 { get; set; }
        public string SerialNumber                              { get; set; }
        public string BELocation                                     { get; set; }
        public string KEWPA_Number                               { get; set; }
        public string JKKP_Certificate_Number        { get; set; }
        public string validated_by                      { get; set; }
        public string created_by                        { get; set; }
        public string modified_by                           { get; set; }
         
        public DateTime? validated_date { get; set; }
        public DateTime? created_date { get; set; }
        public DateTime? modified_date { get; set; }
         

    }

    private List<Assets> BindDataSource1()
    {

        DataTable dt = null;
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("curd_be_asset_infrm_validate", sqlcon))
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
                     select new Assets()
                     {
                         row_no = dr["s_no"] is DBNull ? 0 : int.Parse(Convert.ToString(dr["s_no"])),
                     
                         be_number = Convert.IsDBNull(dr["be_number"]) ? null : dr["be_number"].ToString(),
                         be_category = Convert.IsDBNull(dr["be_category"]) ? null : dr["be_category"].ToString(),
                         Manufacture = Convert.IsDBNull(dr["Manufacture"]) ? null : dr["Manufacture"].ToString(),
                         Model = Convert.IsDBNull(dr["Model"]) ? null : dr["Model"].ToString(),
                         SerialNumber = Convert.IsDBNull(dr["SerialNumber"]) ? null : dr["SerialNumber"].ToString(),
                         BELocation = Convert.IsDBNull(dr["BELocation"]) ? null : dr["BELocation"].ToString(),
                         KEWPA_Number = Convert.IsDBNull(dr["KEWPA_Number"]) ? null : dr["KEWPA_Number"].ToString(),
                         JKKP_Certificate_Number = Convert.IsDBNull(dr["JKKP_Certificate_Number"]) ? null : dr["JKKP_Certificate_Number"].ToString(),
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


    protected void SQLDataGrid_ServerRecordClick(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        //ExecuteToSQL("curd_be_asset_infrm_validate", "endEdit", e.Arguments["data"]);  // SQLUpdate stored procedure
        //this.SQLDataGrid.DataSource = null;
        //this.SQLDataGrid.DataSource = BindDataSource1(); ;// AssetList;

        //this.SQLDataGrid.DataBind();
    }

    protected void SQLDataGrid_ServerCommandButtonClick(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        ExecuteToSQL("curd_be_asset_infrm_validate", "endEdit", e.Arguments["data"]);  // SQLUpdate stored procedure
        this.SQLDataGrid.DataSource = null;
        this.SQLDataGrid.DataSource = BindDataSource1(); ;// AssetList;

        this.SQLDataGrid.DataBind();
        state_load();
    }
}