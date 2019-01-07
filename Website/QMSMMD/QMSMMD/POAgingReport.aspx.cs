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
    public partial class POAgingReport : System.Web.UI.Page
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
                    string com = "select Statecode, SatateDesc from Stock_location_mst (nolock)";

                    SqlDataAdapter adpt = new SqlDataAdapter(com, con);
                    DataTable dt = new DataTable();
                    adpt.Fill(dt);
                    DropDownState.DataSource = dt;
                    DropDownState.DataBind();
                    DropDownState.DataTextField = "SatateDesc";
                    DropDownState.DataValueField = "Statecode";
                    DropDownState.DataBind();
                    DropDownState.Items.Insert(0, new ListItem("ALL", "0"));

                    /*For PO Status Dropdown Load*/
                    string com1 = "select puo_sts_status, puo_sts_description from puo_sts (nolock)";

                    SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                    DataTable dt1 = new DataTable();
                    adpt1.Fill(dt1);
                    DropDownList1.DataSource = dt1;
                    DropDownList1.DataBind();
                    DropDownList1.DataTextField = "puo_sts_description";
                    DropDownList1.DataValueField = "puo_sts_status";
                    DropDownList1.DataBind();
                    DropDownList1.Items.Insert(0, new ListItem("ALL", "0"));

                    /*For PO Status Dropdown Load*/
                    string com2 = "select sup_mst_supplier_cd, sup_mst_desc from sup_mst (nolock) order by sup_mst_desc ";

                    SqlDataAdapter adpt2 = new SqlDataAdapter(com2, con);
                    DataTable dt2 = new DataTable();
                    adpt2.Fill(dt2);
                    DropDownList2.DataSource = dt2;
                    DropDownList2.DataBind();
                    DropDownList2.DataTextField = "sup_mst_desc";
                    DropDownList2.DataValueField = "sup_mst_supplier_cd";
                    DropDownList2.DataBind();
                    DropDownList2.Items.Insert(0, new ListItem("ALL", "0"));

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

        protected void Button2_Click(object sender, EventArgs e)
        {

            string status = DropDownList1.SelectedItem.Value;
            string supplier = DropDownList2.SelectedItem.Value;
            string delivery = TextBox3.Text;
            string deliveryto = TextBox4.Text;

            String strfilename = "PO Aging Report ";
            string startdate = TextBox1.Text;
            string enddate = TextBox2.Text;
            Response.ClearContent();

            Response.AddHeader("content-disposition", string.Format("attachment; filename=" + strfilename + DateTime.Now.ToString("yyyy-MM-dd HH::mm") + ".xls"));

            Response.ContentType = "application/vnd.ms-excel";

            // string space = "";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                hw.WriteLine("<b><font size='5'>" +
                            "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PO AGING REPORT (FROM " + startdate + "  TO  " + enddate + ")         &nbsp;&nbsp;&nbsp;&nbsp;  DATE :" + DateTime.Now.ToString("yyyy-MM-dd") +
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
                //sp name SP_POAgeing_Report_out to SP_POAgeing_Report_out_qms changed by murugan 2018-12-24

                SqlCommand cmd = new SqlCommand("exec SP_POAgeing_Report_out_qms '" + DropDownState.SelectedItem.Text + "' , '" + startdate + "' , '" + enddate + "' , '" + status + "' , '" + supplier + "' , '" + delivery + "' , '" + deliveryto +"'", con);
                //SqlCommand cmd = new SqlCommand("exec SP_Ageing_Report_out '1','2','3','4','5'", con);
                cmd.CommandTimeout = 900;
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            string test = User.Identity.Name.ToString();
            string startdate = TextBox1.Text;
            string enddate = TextBox2.Text;
            string status = DropDownList1.SelectedItem.Value;
            string supplier = DropDownList2.SelectedItem.Value;
            string delivery = TextBox3.Text;
            string deliveryto = TextBox4.Text;

            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;

            try
            {
                con = new SqlConnection(connString);
                con.Open();
                //sp name SP_POAgeing_Report_out to SP_POAgeing_Report_out_qms changed by murugan 2018-12-24
                SqlCommand cmd = new SqlCommand("exec SP_POAgeing_Report_out_qms '" + DropDownState.SelectedItem.Text + "' , '" + startdate + "' , '" + enddate + "' , '" + status + "' , '" + supplier + "' , '" + delivery + "' , '" + deliveryto + "'", con);
                cmd.CommandTimeout = 900;
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

        protected void DropDownState_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            string startdate = TextBox1.Text;
            string enddate = TextBox2.Text;
            string status = DropDownList1.SelectedItem.Value;
            string supplier = DropDownList2.SelectedItem.Value;
            string delivery = TextBox3.Text;
            string deliveryto = TextBox4.Text;

            GridView1.PageIndex = e.NewPageIndex;
            //Bind grid
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            con = new SqlConnection(connString);
            con.Open();


            SqlCommand cmd = new SqlCommand("exec SP_POAgeing_Report_out '" + DropDownState.SelectedItem.Text + "' , '" + startdate + "' , '" + enddate + "' , '" + status + "' , '" + supplier + "' , '" + delivery + "' , '" + deliveryto + "'", con);
            //SqlCommand cmd = new SqlCommand("exec SP_Ageing_Report_out '1','2','3','4','5'", con);
            cmd.CommandTimeout = 900;
            SqlDataAdapter Adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            Adpt.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
}