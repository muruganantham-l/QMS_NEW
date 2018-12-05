using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AgingReport
{
    public partial class SearchDoc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["name"] == null)
                {

                    Session["prevUrl"] = Request.Url;
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
                        DropDownState.Items.Insert(0, new ListItem("--Select--", "0"));


                        DropDownDistrict.Items.Insert(0, new ListItem("--Select--", "0"));

                        DropDownDocType.Items.Insert(0, new ListItem("PPM B03 & CHECKLIST", "1"));
                       
                        //DropDownDocType.Items.Insert(0, new ListItem("PPM B03", "1"));
                        //DropDownDocType.Items.Insert(0, new ListItem("PPM CHECKLIST", "2"));
                        DropDownDocType.Items.Insert(0, new ListItem("--Select--", "0"));


                        string com1 = "WITH Years(No , Year) AS  ( SELECT 1, 2017 year UNION ALL  SELECT No+1,year+1 FROM  Years AS d  where   Year < Year(getdate())) SELECT No , Year FROM Years order by year desc";

                        SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                        DataTable dt1 = new DataTable();
                        adpt1.Fill(dt1);
                        DropDownYear.DataSource = dt1;
                        DropDownYear.DataBind();
                        DropDownYear.DataTextField = "Year";
                        DropDownYear.DataValueField = "No";
                        DropDownYear.DataBind();
                        DropDownYear.Items.Insert(0, new ListItem("--Select--", "0"));

                        //added by muruganantham

                        freq_DropDownList1.Items.Insert(0, new ListItem("--Select--", "0"));
                        freq_DropDownList1.Items.Insert(1, new ListItem("1", "1"));
                        freq_DropDownList1.Items.Insert(2, new ListItem("2", "2"));


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
        protected string Isbenumbervalid()
        {

            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connString);
            SqlCommand cmd = new SqlCommand();
            object returnValue;

            cmd.CommandText = "select count(1) from ast_mst where ast_mst_asset_no=@ast_no";
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ast_no", Textbox1.Text);
            cmd.Connection = con;

            con.Open();
            returnValue = cmd.ExecuteScalar();
            con.Close();

            if (Convert.ToInt16(returnValue) > 0)
            {

                return "true";
                //Label5.ForeColor = System.Drawing.Color.Red;
                //Label5.Visible = false;
                //    Label5.Text = "Please enter valid BE Number";

            }
            //Response.Write("Correct");
            else
            {
                //Label5.ForeColor = System.Drawing.Color.Red;
                //Label5.Visible = true;
                //Label5.Text = "Please enter valid BE Number";
                return "false";

            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            //string BeNumValid = Isbenumbervalid();
            //if (BeNumValid == "false")
            //{
            //    // Response.Write(BeNumValid);


            //    Label5.ForeColor = System.Drawing.Color.Red;
            //    Label5.Visible = true;
            //    Label5.Text = " Please enter valid BE Number";
            //    return;
            //}
            //else {
            //    Label5.Visible = false;
            //}
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;

                    try
                    {
                        con = new SqlConnection(connString);

                        SqlDataAdapter adp = new SqlDataAdapter("Exec Sp_Search_Document_proc '"+DropDownState.SelectedItem.Text+"','"+
                            DropDownDistrict.SelectedItem.Text+"','"+DropDownDocType.SelectedItem.Text+"','"+DropDownYear.SelectedItem.Text
                            +"','"+Textbox1.Text + "','"+freq_DropDownList1.SelectedItem.Text+"'", con);
                        
                        con.Open();

                        DataTable ds = new DataTable();
                        adp.Fill(ds);
                        GridView1.DataSource = ds;
                        GridView1.DataBind();

                    }
                    catch (Exception ex)
                    {
                        string msg = "Insert Error:";
                        msg += ex.Message;
                        throw new Exception(msg);
                    }
                    finally
                    {
                        con.Close();
                    }

        }

        protected void DropDownState_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;

            try
            {
                con = new SqlConnection(connString);
                /*For District Dropdown Load*/

                string com1 = "select RowID , ast_loc_ast_loc from  ast_loc (nolock) where ast_loc_state = '" + DropDownState.SelectedItem.Text + "'";

                SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                DataTable dt1 = new DataTable();
                adpt1.Fill(dt1);
                DropDownDistrict.DataSource = dt1;
                DropDownDistrict.DataBind();
                DropDownDistrict.DataTextField = "ast_loc_ast_loc";
                DropDownDistrict.DataValueField = "RowID";
                DropDownDistrict.DataBind();
                DropDownDistrict.Items.Insert(0, new ListItem("--Select--", "0"));

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

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        protected void DropDownDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void DropDownDocType_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void DropDownYear_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void lnkDownload_Click(object sender, EventArgs e)
        {

            string filePath = "~\\App_Data\\"+(sender as LinkButton).CommandArgument;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
            Response.WriteFile(filePath);
            Response.End();
        }
    }
}