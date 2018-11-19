using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSMMD
{
    public partial class PRAgingReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                SqlConnection con = null;

                try
                {
                    con = new SqlConnection(connString);
                    /*For State Dropdown Load*/
                    string com = "select ast_lvl_ast_lvl, ast_lvl_desc from ast_lvl_mst (nolock)";

                    SqlDataAdapter adpt = new SqlDataAdapter(com, con);
                    DataTable dt = new DataTable();
                    adpt.Fill(dt);
                    DropDownState.DataSource = dt;
                    DropDownState.DataBind();
                    DropDownState.DataTextField = "ast_lvl_desc";
                    DropDownState.DataValueField = "ast_lvl_ast_lvl";
                    DropDownState.DataBind();
                    DropDownState.Items.Insert(0, new ListItem("ALL", "0"));

                    /*For PO Status Dropdown Load*/
                    string com1 = "select ast_grp_grp_cd ,ast_grp_general_name from ast_grp (nolock) order by ast_grp_general_name";

                    SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                    DataTable dt1 = new DataTable();
                    adpt1.Fill(dt1);
                    Category.DataSource = dt1;
                    Category.DataBind();
                    Category.DataTextField = "ast_grp_general_name";
                    Category.DataValueField = "ast_grp_grp_cd";
                    Category.DataBind();
                    Category.Items.Insert(0, new ListItem("ALL", "0"));

                    /*For PO Status Dropdown Load*/
                    string com2 = "select mfg_mst_mfg_cd , mfg_mst_mfg_cd as MfgDescription from mfg_mst (nolock) order by mfg_mst_mfg_cd ";

                    SqlDataAdapter adpt2 = new SqlDataAdapter(com2, con);
                    DataTable dt2 = new DataTable();
                    adpt2.Fill(dt2);
                    Manafacturer.DataSource = dt2;
                    Manafacturer.DataBind();
                    Manafacturer.DataTextField = "MfgDescription";
                    Manafacturer.DataValueField = "mfg_mst_mfg_cd";
                    Manafacturer.DataBind();
                    Manafacturer.Items.Insert(0, new ListItem("ALL", "0"));

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

        protected void DropDownState_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Category_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Manafacturer_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Search_Click(object sender, EventArgs e)
        {
            string test = User.Identity.Name.ToString();
            string startdate = TextBox1.Text;
            string enddate = TextBox2.Text;
            string status = Category.SelectedItem.Value;
            string supplier = Manafacturer.SelectedItem.Value;
            string stockno = TextBox3.Text;
            string beno = TextBox4.Text;

            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            Server.ScriptTimeout = 600;
            try
            {
                con = new SqlConnection(connString);
                con.Open();

                SqlCommand cmd = new SqlCommand("exec SP_PRAgeing_Report_out '" + DropDownState.SelectedItem.Text + "' , '" + startdate + "' , '" + enddate + "' , '" + status + "' , '" + supplier + "' , '" + stockno + "' , '" + beno + "'", con);
                cmd.CommandTimeout = 950;
                //SqlCommand cmd = new SqlCommand("exec SP_POAgeing_Report_out '1','2','3','4','5'", con);
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

        protected void Generate_Click(object sender, EventArgs e)
        {
            string status = Category.SelectedItem.Value;
            string supplier = Manafacturer.SelectedItem.Value;
            string stockno = TextBox3.Text;
            string beno = TextBox4.Text;

            String strfilename = "PR Aging Report ";
            string startdate = TextBox1.Text;
            string enddate = TextBox2.Text;

            Server.ScriptTimeout = 600;
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", string.Format("attachment; filename=" + strfilename + DateTime.Now.ToString("yyyy-MM-dd HH::mm") + ".xls"));

            Response.ContentType = "application/vnd.ms-excel";

            // string space = "";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                hw.WriteLine("<b><font size='5'>" +
                            "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PR AGING REPORT (FROM " + startdate + "  TO  " + enddate + ")         &nbsp;&nbsp;&nbsp;&nbsp;  DATE :" + DateTime.Now.ToString("yyyy-MM-dd") +
                            "</font></b>" +
                            "</br>");
                hw.WriteLine("<br>");
                hw.WriteLine("<br>");

                //To Export all pages
                GridView1.AllowPaging = false;

                string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                SqlConnection con = null;
                con = new SqlConnection(connString);
                
                con.Open();


                SqlCommand cmd = new SqlCommand("exec SP_PRAgeing_Report_out '" + DropDownState.SelectedItem.Text + "' , '" + startdate + "' , '" + enddate + "' , '" + status + "' , '" + supplier + "' , '" + stockno + "' , '" + beno + "'", con);
                //SqlCommand cmd = new SqlCommand("exec SP_Ageing_Report_out '1','2','3','4','5'", con);
                cmd.CommandTimeout = 950;
                SqlDataAdapter Adpt = new SqlDataAdapter(cmd);
                DataTable dt1 = new DataTable();
                Adpt.Fill(dt1);
                GridView1.DataSource = dt1;
                GridView1.DataBind();

               /* GridView1.HeaderRow.BackColor = Color.White;
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
                */
                GridView1.RenderControl(hw);
                Response.Buffer = false;
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();

            }
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            string startdate = TextBox1.Text;
            string enddate = TextBox2.Text;
            string status = Category.SelectedItem.Value;
            string supplier = Manafacturer.SelectedItem.Value;
            string stockno = TextBox3.Text;
            string beno = TextBox4.Text;

            Server.ScriptTimeout = 600;

            GridView1.PageIndex = e.NewPageIndex;
            //Bind grid
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            con = new SqlConnection(connString);
            con.Open();


            SqlCommand cmd = new SqlCommand("exec SP_PRAgeing_Report_out '" + DropDownState.SelectedItem.Text + "' , '" + startdate + "' , '" + enddate + "' , '" + status + "' , '" + supplier + "' , '" + stockno + "' , '" + beno + "'", con);
            //SqlCommand cmd = new SqlCommand("exec SP_Ageing_Report_out '1','2','3','4','5'", con);
            cmd.CommandTimeout = 950;
            SqlDataAdapter Adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            Adpt.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

       
    }
}