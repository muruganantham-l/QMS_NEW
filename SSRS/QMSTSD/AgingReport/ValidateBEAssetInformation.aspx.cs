using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace AgingReport
{
    public partial class ValidateBEAssetInformation : System.Web.UI.Page 
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
                    this.BindGrid();

                    string username = Session["name"].ToString();
                    this.Label8.Text = string.Format("Hi {0}", Session["name"].ToString() + "!");

                    validate_flagDropDownList.Items.Insert(0, new ListItem("--Select--", "0"));
                    validate_flagDropDownList.Items.Insert(1, new ListItem("Yes", "Y"));
                    validate_flagDropDownList.Items.Insert(2, new ListItem("No", "N"));

                    string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                    SqlConnection con = null;

                    try
                    {
                        con = new SqlConnection(connString);
                        /*For District Dropdown Load*/

                        string com1 = "select distinct ast_lvl_ast_lvl ast_loc_state from ast_lvl(nolock) order by ast_lvl_ast_lvl";

                        SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                        DataTable dt1 = new DataTable();
                        adpt1.Fill(dt1);
                        state_dropdownlist.DataSource = dt1;
                        state_dropdownlist.DataBind();
                        state_dropdownlist.DataTextField = "ast_loc_state";
                        state_dropdownlist.DataValueField = "ast_loc_state";
                        state_dropdownlist.DataBind();
                        state_dropdownlist.Items.Insert(0, new ListItem("--Select--", "0"));

                    }
                    catch (Exception ex)
                    {
                        //log error 
                        //display friendly error to user
                        string msg = " Upload Error: ";
                        msg += ex.Message;


                    }
                    finally
                    {
                        con.Close();
                    }


                }
            }
        }
        private void BindGrid()
        {
            string constr = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("curd_be_asset_infrm_validate"))
                {
                    cmd.Parameters.AddWithValue("@Action", "SELECT");
                     
                    cmd.Parameters.Add("@validate_flag", SqlDbType.VarChar).Value = validate_flagDropDownList.SelectedValue.ToString();
                    //cmd.Parameters.Add("@state", SqlDbType.VarChar).Value = state_dropdownlist.SelectedItem.Text;

                    
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            GridView1.DataSource = dt;
                            GridView1.DataBind();
                        }
                    }
                }
            }
        }
        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != GridView1.EditIndex)
            //{
            //    (e.Row.Cells[2].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            //}
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            this.BindGrid();
        
        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try { 
            GridViewRow row = GridView1.Rows[e.RowIndex];
             
            string be_number = (row.FindControl("be_number_txt") as Label).Text;
            string Manufacture = (row.FindControl("Manufacture_txt") as TextBox).Text;

            string Model = (row.FindControl("Model_txt") as TextBox).Text;
            string SerialNumber = (row.FindControl("SerialNumber") as TextBox).Text;

            string BELocation = (row.FindControl("BELocation") as TextBox).Text;
            string KEWPA_Number = (row.FindControl("KEWPA_Number") as TextBox).Text;
            string JKKP_Certificate_Number = (row.FindControl("JKKP_Certificate_Number") as TextBox).Text;
            string validated_by = Session["name"].ToString();



            string constr = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("curd_be_asset_infrm_validate"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "UPDATE");
                    
                    cmd.Parameters.AddWithValue("@be_number", be_number);
                    cmd.Parameters.AddWithValue("@Manufacture", Manufacture);
                    cmd.Parameters.AddWithValue("@Model", Model);
                    cmd.Parameters.AddWithValue("@SerialNumber", SerialNumber);
                    cmd.Parameters.AddWithValue("@BELocation", BELocation);
                    cmd.Parameters.AddWithValue("@KEWPA_Number", KEWPA_Number);
                    cmd.Parameters.AddWithValue("@JKKP_Certificate_Number", JKKP_Certificate_Number);
                    cmd.Parameters.AddWithValue("@validated_by", validated_by);

                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            GridView1.EditIndex = -1;
            this.BindGrid();
        }
            catch (Exception ex)

            {
                //string msg = " Upload Error: ";
                //msg += ex.Message;
                throw ex;

            }
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            GridView1.EditIndex = -1;
            this.BindGrid();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try { 
            int customerId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string constr = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("curd_be_asset_infrm_validate"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "DELETE");
                    cmd.Parameters.AddWithValue("@CustomerId", customerId);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            this.BindGrid();
        }
             catch (Exception ex)

            {

                throw ex;

            }
        }

        protected void search_btn_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            String strConnString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand();

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = "curd_be_asset_infrm_validate";

            cmd.Parameters.Add("@validate_flag", SqlDbType.VarChar).Value = validate_flagDropDownList.SelectedValue.ToString();
            
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.Parameters.Add("@state", SqlDbType.VarChar).Value = state_dropdownlist.SelectedItem.Text;
            cmd.Connection = con;

            try

            {

                con.Open();
                
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();

            }

            catch (Exception ex)

            {

                throw ex;

            }

            finally

            {

                con.Close();

                con.Dispose();

            }
        }
    }
}