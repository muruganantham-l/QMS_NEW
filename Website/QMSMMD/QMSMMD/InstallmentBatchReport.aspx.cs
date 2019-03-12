using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
namespace QMSMMD
{
    public partial class InstallmentBatchReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string startdate = TextBox1.Text;
           

            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;

            try
            {
                con = new SqlConnection(connString);
                con.Open();

                SqlCommand cmd = new SqlCommand("exec installment_batch_tbl_sp '" + startdate + "'" , con);

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

        protected void Button2_Click(object sender, EventArgs e)
        {
            String strfilename = "Installment Batch Report ";
            string startdate = TextBox1.Text;
            
            Response.ClearContent();

            Response.AddHeader("content-disposition", string.Format("attachment; filename=" + strfilename + DateTime.Now.ToString("yyyy-MM-dd HH::mm") + ".xls"));

            Response.ContentType = "application/vnd.ms-excel";

            // string space = "";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                hw.WriteLine("<b><font size='5'>" +
                            "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Installment Batch Report           &nbsp;&nbsp;&nbsp;&nbsp;  DATE :" + DateTime.Now.ToString("yyyy-MM-dd") +
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


                SqlCommand cmd = new SqlCommand("exec installment_batch_tbl_sp '" + startdate + "'", con);
                //SqlCommand cmd = new SqlCommand("exec SP_Ageing_Report_out '1','2','3','4','5'", con);
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
    }
}