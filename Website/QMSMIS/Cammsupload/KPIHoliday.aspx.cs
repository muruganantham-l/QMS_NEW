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
    public partial class KPIHoliday : System.Web.UI.Page
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
                        DropDownList2.DataSource = dt;
                        DropDownList2.DataBind();
                        DropDownList2.DataTextField = "ast_lvl_ast_lvl";
                        DropDownList2.DataValueField = "RowID";
                        DropDownList2.DataBind();
                        DropDownList2.Items.Insert(0, new ListItem("--Select--", "0"));
                    }
                     
                    catch (Exception ex)
                    {
                        //log error 
                        //display friendly error to user
                        string msg = "Insert Error:";
                        msg += ex.Message;


                    }
                    finally
                    {
                        con.Close();
                    }
                }
            }
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            TextBox1.Text = "";
            TextBox2.Text = "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            string username = null;

            if (Session["name"] == null)
            {
                Session["prevUrl"] = Request.Url;
                Response.Redirect("~/login.aspx");

            }
            else
            {
                username = Session["name"].ToString();
            }
            
           if (DropDownList2.SelectedItem.Text != "--Select--")
            {

                string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                SqlConnection conn = null;

                try
                    {
                        
                        conn = new SqlConnection(connString);
                        conn.Open();

                        SqlCommand com = new SqlCommand();
                        com.Connection = conn;
                        //set parameters
                        SqlParameter p1 = new SqlParameter("@State", SqlDbType.VarChar);
                        SqlParameter p2 = new SqlParameter("@Holiday", SqlDbType.VarChar);
                        SqlParameter p3 = new SqlParameter("@Reason", SqlDbType.VarChar);
                        SqlParameter p4 = new SqlParameter("@User", SqlDbType.VarChar);
                        p1.Value = DropDownList2.SelectedItem.Text;
                        p2.Value = TextBox2.Text;
                        p3.Value = TextBox1.Text;
                        p4.Value = username;
                        com.Parameters.Add(p1);
                        com.Parameters.Add(p2);
                        com.Parameters.Add(p3);
                        com.Parameters.Add(p4);
                        //com.CommandText = "Insert into Files (Name,FileType,Data) VALUES (@Name,@FileType,@Data)";
                        com.CommandText = "Exec Holiday_update_proc @State , @Holiday , @Reason , @User ";
                        //insert the file into database
                        com.ExecuteNonQuery();

                        Label1.Visible = true;
                        Label1.ForeColor = System.Drawing.ColorTranslator.FromHtml("#008000");
                        Label1.Text = "Date Updated Successfully!!!";

                    }

                catch (Exception ex)
                {
                    //log error 
                    //display friendly error to user
                    string msg = "Insert Error:";
                    msg += ex.Message;


                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }
}