using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
namespace AgingReport
{
    public partial class StatusPengeluarnFin09Entry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["name"] == null)
                {

                    Response.Redirect("~/loginPage.aspx");

                }
                else
                {
                    string username = Session["name"].ToString();
                    this.Label8.Text = string.Format("Hi {0}", Session["name"].ToString() + "!");


                    string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                    SqlConnection con = null;

                    try
                    {
                        con = new SqlConnection(connString);

                        /*For State Dropdown Load*/
                        string com = "Select RowID, ast_lvl_ast_lvl  from ast_lvl (nolock)";

                        SqlDataAdapter adpt = new SqlDataAdapter(com, con);
                        DataTable dt = new DataTable();
                        adpt.Fill(dt);
                        DropDownState.DataSource = dt;
                        DropDownState.DataBind();
                        DropDownState.DataTextField = "ast_lvl_ast_lvl";
                        DropDownState.DataValueField = "RowID";
                        DropDownState.DataBind();
                        // DropDownState.Items.Insert(0, new ListItem("ALL", "0"));
                        DropDownState.Items.Insert(0, new ListItem("--Select--", "0"));

                       

                        string com1 = " ;with yearlist as(   select year(getdate()) as year    union all    select yl.year - 1 as year    from yearlist yl    where yl.year - 1 >= YEAR(GetDate()) - 3) select year from yearlist order by year desc; ";

                        SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                        DataTable dt1 = new DataTable();
                        adpt1.Fill(dt1);
                        DropDownYear.DataSource = dt1;
                        DropDownYear.DataBind();
                        DropDownYear.DataTextField = "year";
                        DropDownYear.DataValueField = "year";
                        DropDownYear.DataBind();
                        // DropDownState.Items.Insert(0, new ListItem("ALL", "0"));
                        DropDownYear.Items.Insert(0, new ListItem("--Select--", "0"));

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
            }
        }

        protected void save_btn_Click(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);

            try
            {

                SqlCommand cmd = new SqlCommand("status_pengeluaran_fin09_sp", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("state", DropDownState.SelectedItem.Text);
                cmd.Parameters.AddWithValue("year", DropDownYear.SelectedItem.Text);
                cmd.Parameters.AddWithValue("response_time", response_time_txt.Text);
                cmd.Parameters.AddWithValue("repair_time", repair_time_txt.Text);
                cmd.Parameters.AddWithValue("schedule_maintenance", schedule_maintenance_txt.Text);
                cmd.Parameters.AddWithValue("uptime_guarantees", uptime_guarantees_txt.Text);
                cmd.Parameters.AddWithValue("ctxt_user", Session["name"]);
             


                conn.Open();
                int k = cmd.ExecuteNonQuery();
                if (k != 0)
                {
                    Label29.Text = "Record Inserted Succesfully into the Database";
                    Label29.ForeColor = System.Drawing.Color.CornflowerBlue;
                }
                conn.Close();
            }
            catch (Exception ex)
            {

                //log error 
                //display friendly error to user
                //string msg = "Insert Error:";
                //msg += ex.Message;
                //throw new Exception(msg);
                Label29.ForeColor = System.Drawing.Color.Red;
                Label29.Visible = true;
                Label29.Text = ex.Message.ToString();// "Records updated successfully";
            }
           

           
        }

        protected void DropDownYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con1 = null;

            try
            {
                response_time_txt.Text = null;
                repair_time_txt.Text = null;
                schedule_maintenance_txt.Text = null;
                uptime_guarantees_txt.Text = null;

                // DropDownBECategory.SelectedItem.Text = null;
                con1 = new SqlConnection(connString);

                DataTable dt = new DataTable();
                con1.Open();
                SqlDataReader myReader = null;
                //  SqlCommand myCommand = new SqlCommand("select top 1 convert(varchar(10),ast_det_datetime1 ,103) ast_det_datetime1,convert(varchar(10),ast_det_warranty_date ,103) ast_det_warranty_date	from ast_det b (nolock)	where ast_det_varchar21 is not null 	and ast_det_varchar21 != 'NA'    and ast_det_varchar21 ='" + DropDownbatch.SelectedItem.Text + "' 	AND ast_det_varchar16 = '" + DropDownSuppliername.SelectedItem.Text + "'and ast_det_modelno = '" + DropDownmodel.SelectedItem.Text + "' and exists (	select '' from ast_mst a (nolock)	where a.RowID = b.mst_RowID and a.ast_mst_asset_longdesc = '" + DropDownBECategory.SelectedItem.Text + "' 	)	", con1);

                SqlCommand myCommand = new SqlCommand(
                      "SELECT         response_time        , repair_time        , schedule_maintenance        , uptime_guarantees       from status_pengeluaran_fin09_tbl (NOLOCK)"
                      +
                      " where state1 = '" + DropDownState.SelectedItem.Text + "'"+ " and year1 = '"+DropDownYear.SelectedItem.Text+"'", con1);




                myReader = myCommand.ExecuteReader();

                while (myReader.Read())
                {

               
                        response_time_txt.Text = myReader["response_time"].ToString();
                        repair_time_txt.Text = myReader["repair_time"].ToString();
                        schedule_maintenance_txt.Text = myReader["schedule_maintenance"].ToString();
                        uptime_guarantees_txt.Text = myReader["uptime_guarantees"].ToString();
                   

                }

            }
            catch (Exception ex)
            {
                //log error 
                //display friendly error to user
                //string msg = "Insert Error:";
                //msg += ex.Message;
                //throw new Exception(msg);
                Label29.ForeColor = System.Drawing.Color.Red;
                Label29.Visible = true;
                Label29.Text = ex.Message.ToString();// "Records updated successfully";

            }
            finally
            {

                con1.Close();
            }

        }
    }
}