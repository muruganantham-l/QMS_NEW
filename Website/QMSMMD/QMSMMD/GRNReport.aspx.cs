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

namespace QMSMMD
{
    public partial class GRNReport : System.Web.UI.Page
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
                    string com = "select Statecode, SatateDesc from inv_trans_Location_mst (nolock)";

                    SqlDataAdapter adpt = new SqlDataAdapter(com, con);
                    DataTable dt = new DataTable();
                    adpt.Fill(dt);
                    DropDownState.DataSource = dt;
                    DropDownState.DataBind();
                    DropDownState.DataTextField = "SatateDesc";
                    DropDownState.DataValueField = "Statecode";
                    DropDownState.DataBind();
                    DropDownState.Items.Insert(0, new ListItem("ALL", "0"));

                    /*For District Dropdown Load*/
                    DropDownList1.Items.Insert(0, new ListItem("ALL", "0"));


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

        protected void Search_Click(object sender, EventArgs e)
        {
            string test = User.Identity.Name.ToString();
            string startdate = TextBox1.Text;
            string enddate = TextBox2.Text;
           
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            Server.ScriptTimeout = 600;
            try
            {
                con = new SqlConnection(connString);
                con.Open();

                SqlCommand cmd = new SqlCommand("exec Sp_Grn_Report_out '" + DropDownState.SelectedItem.Text + "' , '" + DropDownList1.SelectedItem.Text + "' , '" + startdate + "' , '" + enddate + "'", con);
                cmd.CommandTimeout = 950;
                //SqlCommand cmd = new SqlCommand("exec Sp_Grn_Report_out '1','2','3','4','5'", con);
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
            
            String strfilename = "GRN Report ";
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
                            "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GRN REPORT (FROM " + startdate + "  TO  " + enddate + ")         &nbsp;&nbsp;&nbsp;&nbsp;  DATE :" + DateTime.Now.ToString("yyyy-MM-dd") +
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


                SqlCommand cmd = new SqlCommand("exec Sp_Grn_Report_out '" + DropDownState.SelectedItem.Text + "' , '" + DropDownList1.SelectedItem.Text + "' , '" + startdate + "' , '" + enddate + "'", con);
                //SqlCommand cmd = new SqlCommand("exec Sp_Grn_Report_out '1','2','3','4','5'", con);
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
        protected void DropDownState_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;

            try
            {
                con = new SqlConnection(connString);
                
            /*For District Dropdown Load*/
                string com1 = "select Stocklocation , Stocklocation from inv_trans_Location_det (nolock) where Statecode = '" + DropDownState.SelectedItem.Value + "'";

            SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
            DataTable dt1 = new DataTable();
            adpt1.Fill(dt1);
            DropDownList1.DataSource = dt1;
            DropDownList1.DataBind();
            DropDownList1.DataTextField = "Stocklocation";
            DropDownList1.DataValueField = "Stocklocation";
            DropDownList1.DataBind();
            DropDownList1.Items.Insert(0, new ListItem("ALL", "0"));
            }
            catch (Exception ex)
            {
                //log error 
                //display friendly error to user
                string msg = "Insert Error:";
                msg += ex.Message;


            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            string startdate = TextBox1.Text;
            string enddate = TextBox2.Text;

            Server.ScriptTimeout = 600;

            GridView1.PageIndex = e.NewPageIndex;
            
            //Bind grid

            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            con = new SqlConnection(connString);
            con.Open();


            SqlCommand cmd = new SqlCommand("exec Sp_Grn_Report_out '" + DropDownState.SelectedItem.Text + "' , '" +DropDownList1.SelectedItem.Text+ "' , '" + startdate + "' , '" + enddate + "'", con);
            //SqlCommand cmd = new SqlCommand("exec Sp_Grn_Report_out '1','2','3','4','5'", con);
            cmd.CommandTimeout = 950;
            SqlDataAdapter Adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            Adpt.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}