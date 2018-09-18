using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace AgingReport
{
    public partial class AgingReport : System.Web.UI.Page
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
                    //Label8.Visible = false;
                    //Label8.Text = username;
                    

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
                        DropDownState.Items.Insert(0, new ListItem("ALL", "0"));

                        /*For District Dropdown Load*/

                        //string com1 = "select RowID , ast_loc_ast_loc from  ast_loc (nolock) where ast_loc_state = '" + DropDownState.SelectedItem.Text + "'";
                        //
                        //SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                        //DataTable dt1 = new DataTable();
                        //adpt1.Fill(dt1);
                        //DropDownDistrict.DataSource = dt1;
                        //DropDownDistrict.DataBind();
                        //DropDownDistrict.DataTextField = "ast_loc_ast_loc";
                        //DropDownDistrict.DataValueField = "RowID";
                        //DropDownDistrict.DataBind();
                        DropDownDistrict.Items.Insert(0, new ListItem("ALL", "0"));

                        /*For Circle Dropdown Load*/

                        //string Com2 = "select RowID , ast_loc_circle from  ast_loc (nolock) where ast_loc_state = '" + DropDownState.SelectedItem.Text + "' and ast_loc_ast_loc = '" + DropDownDistrict.SelectedItem.Text + "'";
                        //
                        //SqlDataAdapter adpt2 = new SqlDataAdapter(Com2, con);
                        //DataTable dt2 = new DataTable();
                        //adpt2.Fill(dt2);
                        //DropDowncircle.DataSource = dt2;
                        //DropDowncircle.DataBind();
                        //DropDowncircle.DataTextField = "ast_loc_circle";
                        //DropDowncircle.DataValueField = "RowID";
                        //DropDowncircle.DataBind();
                        DropDowncircle.Items.Insert(0, new ListItem("ALL", "0"));

                        /*For Clinic Cate Dropdown Load*/
                        DropDownCliniccat.Items.Insert(0, new ListItem("KESIHATAN", "1"));
                        DropDownCliniccat.Items.Insert(0, new ListItem("PERGIGIAN", "2"));
                        DropDownCliniccat.Items.Insert(0, new ListItem("ALL", "0"));

                        /*For Ownership Dropdown Load*/
                        DropDownOwner.Items.Insert(0, new ListItem("Existing", "1"));
                        DropDownOwner.Items.Insert(0, new ListItem("New Biomedical", "2"));
                        DropDownOwner.Items.Insert(0, new ListItem("Purchase Biomedical", "3"));
                        DropDownOwner.Items.Insert(0, new ListItem("ALL", "0"));

                        /*For BE Category Cate Dropdown Load*/
                        string com4 = "select ast_grp_grp_cd , ast_grp_category  from ast_grp (nolock) order by ast_grp_category ";

                        SqlDataAdapter adpt4 = new SqlDataAdapter(com4, con);
                        DataTable dt4 = new DataTable();
                        adpt4.Fill(dt4);
                        DropDownBECate.DataSource = dt4;
                        DropDownBECate.DataBind();
                        DropDownBECate.DataTextField = "ast_grp_category";
                        DropDownBECate.DataValueField = "ast_grp_grp_cd";
                        DropDownBECate.DataBind();
                        DropDownBECate.Items.Insert(0, new ListItem("ALL", "0"));
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            string test = User.Identity.Name.ToString();

                string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                SqlConnection con = null;

                try
                {
                    con = new SqlConnection(connString);
                    con.Open();
                    
                    SqlCommand cmd = new SqlCommand("exec SP_Ageing_Report_out '" + DropDownState.SelectedItem.Text + "','" +
                    DropDownDistrict.SelectedItem.Text + "','" + DropDowncircle.SelectedItem.Text + "','" + DropDownCliniccat.SelectedItem.Text + "','" +
                    DropDownBECate.SelectedItem.Value + "','"+DropDownOwner.SelectedItem.Text+"'", con);
                    cmd.CommandTimeout = 1000;

                    //SqlCommand cmd = new SqlCommand("exec SP_Ageing_Report_out '1','2','3','4','5'", con);
                    SqlDataAdapter Adpt = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    Adpt.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind(); 

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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            //Bind grid
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            con = new SqlConnection(connString);
            con.Open();
            

             SqlCommand cmd = new SqlCommand("exec SP_Ageing_Report_out '" + DropDownState.SelectedItem.Text + "','"+
                 DropDownDistrict.SelectedItem.Text + "','"+ DropDowncircle.SelectedItem.Text + "','"+ DropDownCliniccat.SelectedItem.Text + "','"+
                 DropDownBECate.SelectedItem.Value +"','"+DropDownOwner.SelectedItem.Text+ "'", con);
             cmd.CommandTimeout = 1000;
            //SqlCommand cmd = new SqlCommand("exec SP_Ageing_Report_out '1','2','3','4','5'", con);
            SqlDataAdapter Adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            Adpt.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind(); 
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            
            String strfilename = "Breakdown Aging Report ";

            Response.ClearContent();

            Response.AddHeader("content-disposition", string.Format("attachment; filename=" + strfilename + DateTime.Now.ToString("yyyy-MM-dd HH::mm") + ".xls"));

            Response.ContentType = "application/vnd.ms-excel";

           // string space = "";
  
           using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;

                string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                SqlConnection con = null;
                con = new SqlConnection(connString);
                con.Open();


                SqlCommand cmd = new SqlCommand("exec SP_Ageing_Report_out '" + DropDownState.SelectedItem.Text + "','" +
                    DropDownDistrict.SelectedItem.Text + "','" + DropDowncircle.SelectedItem.Text + "','" + DropDownCliniccat.SelectedItem.Text + "','" +
                    DropDownBECate.SelectedItem.Value +"','"+DropDownOwner.SelectedItem.Text+ "'", con);
                //SqlCommand cmd = new SqlCommand("exec SP_Ageing_Report_out '1','2','3','4','5'", con);
                cmd.CommandTimeout = 1000;

                SqlDataAdapter Adpt = new SqlDataAdapter(cmd);
                DataTable dt1 = new DataTable();
                Adpt.Fill(dt1);
                GridView1.DataSource = dt1;
                GridView1.DataBind();

                GridView1.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in GridView1.HeaderRow.Cells)
                {
                    cell.BackColor = GridView1.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in GridView1.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = GridView1.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                GridView1.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();

            }

        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
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
                    DropDownDistrict.Items.Insert(0, new ListItem("ALL", "0"));

                    string Com2 = "select RowID , ast_loc_circle from  ast_loc (nolock) where ast_loc_state = '" + DropDownState.SelectedItem.Text+ "'";
                    
                    SqlDataAdapter adpt2 = new SqlDataAdapter(Com2, con);
                    DataTable dt2 = new DataTable();
                    adpt2.Fill(dt2);
                    DropDowncircle.DataSource = dt2;
                    DropDowncircle.DataBind();
                    DropDowncircle.DataTextField = "ast_loc_circle";
                    DropDowncircle.DataValueField = "RowID";
                    DropDowncircle.DataBind();

                    DropDowncircle.Items.Insert(0, new ListItem("ALL", "0"));
                }
                catch (Exception ex)
                {
                    //log error 
                    //display friendly error to user
                    string msg = "Insert Error:";
                    msg += ex.Message;


                }
                
        }

        protected void DropDownDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;

                try
                {

                    string testing = DropDownDistrict.SelectedItem.Text;

                    if (testing != "ALL")
                    {

                        con = new SqlConnection(connString);
                        /*For Circle Dropdown Load*/
                        string Com2 = "select RowID , ast_loc_circle from  ast_loc (nolock) where ast_loc_state = '" + DropDownState.SelectedItem.Text + "' and ast_loc_ast_loc = '" + DropDownDistrict.SelectedItem.Text + "'";

                        SqlDataAdapter adpt2 = new SqlDataAdapter(Com2, con);
                        DataTable dt2 = new DataTable();
                        adpt2.Fill(dt2);
                        DropDowncircle.DataSource = dt2;
                        DropDowncircle.DataBind();
                        DropDowncircle.DataTextField = "ast_loc_circle";
                        DropDowncircle.DataValueField = "RowID";
                        DropDowncircle.DataBind();
                    }
                    else
                    {
                        con = new SqlConnection(connString);
                        /*For Circle Dropdown Load*/
                        string Com2 = "select RowID , ast_loc_circle from  ast_loc (nolock) where ast_loc_state = '" + DropDownState.SelectedItem.Text + "' and ast_loc_ast_loc = '" + DropDownDistrict.SelectedItem.Text + "'";

                        SqlDataAdapter adpt2 = new SqlDataAdapter(Com2, con);
                        DataTable dt2 = new DataTable();
                        adpt2.Fill(dt2);
                        DropDowncircle.DataSource = dt2;
                        DropDowncircle.DataBind();
                        DropDowncircle.DataTextField = "ast_loc_circle";
                        DropDowncircle.DataValueField = "RowID";
                        DropDowncircle.DataBind(); 
                        DropDowncircle.Items.Insert(0, new ListItem("ALL", "0"));
                    }
               
               }
                catch (Exception ex)
                {
                    //log error 
                    //display friendly error to user
                    string msg = "Insert Error:";
                    msg += ex.Message;


                }
                
        } 
     }
}
 
       
        