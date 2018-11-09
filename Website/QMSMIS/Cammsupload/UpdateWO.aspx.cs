using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cammsupload
{
    public partial class UpdateWO : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["name"] == null)
                {
                    Session["prevUrl"] = Request.Url;
                    Response.Redirect("~/login.aspx");

                }
                else
                {
                    string username = Session["name"].ToString();
                    this.Label8.Text = string.Format("Hi {0}", Session["name"].ToString() + "!");

                    string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
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
                        DropDownState.Items.Insert(0, new ListItem("--Select--", "0"));

                        DropDownWoType.Items.Insert(0, new ListItem("PWO - Work Order", "1"));
                        DropDownWoType.Items.Insert(0, new ListItem("CWO - Work Order", "2"));
                        DropDownWoType.Items.Insert(0, new ListItem("--Select--", "0"));


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

        protected void DropDownState_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label10.Visible = false;
        }

        protected void DropDownWoType_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (DropDownWoType.SelectedItem.Text == "PWO - Work Order")
            {

                Label5.Visible = true;
                TextBox1.Visible = true;
                Label6.Visible = false;
                TextBox2.Visible = false;
            }
            if (DropDownWoType.SelectedItem.Text == "CWO - Work Order")
            {
                Label5.Visible = true;
                TextBox1.Visible = true;
                Label6.Visible = true;
                TextBox2.Visible = true;
            }

            Label10.Visible = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                string username1 = Session["name"].ToString();
            }
            catch
            {
                Response.Redirect("~/login.aspx");
            }

            string username = Session["name"].ToString();
            string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                    SqlConnection con = null;
                    con = new SqlConnection(connString);
                    con.Open();
                    try
                    {

                        SqlCommand cmd1 = new SqlCommand("WO_Detail_update_proc",con);
                        cmd1.CommandType = CommandType.StoredProcedure;
                        cmd1.Parameters.AddWithValue("@State", DropDownState.SelectedItem.Text);
                        cmd1.Parameters.AddWithValue("@WOType", DropDownWoType.SelectedItem.Text);
                        cmd1.Parameters.AddWithValue("@WONumber", WONO.Text);
                        cmd1.Parameters.AddWithValue("@BENumber", BENO.Text);
                        cmd1.Parameters.AddWithValue("@userlogin", username);
                        cmd1.Parameters.AddWithValue("@CompDateDate", TextBox1.Text);
                        cmd1.Parameters.AddWithValue("@ResponseDate", TextBox2.Text);
                        cmd1.Parameters.Add("@errormsg", SqlDbType.VarChar, 500);
                        cmd1.Parameters["@errormsg"].Value = 0;
                        cmd1.Parameters["@errormsg"].Direction = ParameterDirection.Output;

                        cmd1.ExecuteNonQuery();

                        int error = 0;

                        error = Convert.ToInt32(cmd1.Parameters[7].Value); 

                        if (error == 5)
                        {

                            Label10.Visible = true;
                            Label10.ForeColor = System.Drawing.Color.DarkGreen; 
                            Label10.Text = "WO Details has been Updated Successfully!!!";
                        }
                        if (error == 1)
                        {
                            Label10.Visible = true;
                            Label10.ForeColor = System.Drawing.Color.Red; 
                            Label10.Text = "WO Order Still Open. We cannot proceed for Update.";
                        }
                        if (error == 2)
                        {
                            Label10.Visible = true;
                            Label10.ForeColor = System.Drawing.Color.Red; 
                            Label10.Text = "WO Order Does not Exist in Server. Please provide a valid information.";
                        }

                    }
                    catch (Exception ex)
                    {
                        //log error 
                        //display friendly error to user
                        string msg = " Upload Error: ";
                        msg += ex.Message;

                        Label10.Visible = true;
                        Label10.Text = msg;
                        Label10.ForeColor = System.Drawing.Color.Red;
                     }
                    finally
                    {
                        con.Close();
                    }
        }
    }
}