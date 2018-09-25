using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
 
using System.IO;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;
 
using Microsoft.Reporting.WebForms;
 
using System.Globalization;

namespace AgingReport
{
    
    public partial class DownloadMasters : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                state_load();
                if (Session["name"] == null)
                {

                    Response.Redirect("~/loginPage.aspx");

                }
                else
                {
                    string username = Session["name"].ToString();
                    this.Label8.Text = string.Format("Hi {0}", Session["name"].ToString() + "!");

                    MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");
                    MyReportViewer.ServerReport.ReportPath = "/QMSMST_DOWNLOAD/Asset Register";
                    MyReportViewer.ServerReport.Refresh();
                }

                }
        }
        public void state_load()
        {

            SqlConnection con = null;

            try
            {
                string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                con = new SqlConnection(connString);
                /*For State Dropdown Load*/
                string com = "Select ast_lvl_ast_lvl, ast_lvl_ast_lvl  from ast_lvl (nolock)";

                SqlDataAdapter adpt = new SqlDataAdapter(com, con);
                DataTable dt = new DataTable();
                adpt.Fill(dt);
                State_combobox.DataSource = dt;
                State_combobox.DataBind();
                State_combobox.DataTextField = "ast_lvl_ast_lvl";
                State_combobox.DataValueField = "ast_lvl_ast_lvl";
                State_combobox.DataBind();
                State_combobox.Items.Insert(0, new ListItem("All", "0"));
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
        public override void VerifyRenderingInServerForm(Control control)
        {
            //base.VerifyRenderingInServerForm(control);
        }
      

        protected void search_btn_Click(object sender, EventArgs e)
        {

            try
            {


                MyReportViewer.ProcessingMode = ProcessingMode.Remote;

                //   ServerReport serverReport = MyReportViewer.ServerReport;

                //MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://chs015-2-3/ReportServer");
                MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");


                MyReportViewer.ServerReport.ReportPath = "/QMSMST_DOWNLOAD/Asset Register";
                ReportParameter[] reportParameterCollection = new ReportParameter[1];       //Array size describes the number of paramaters.

                reportParameterCollection[0] = new ReportParameter();
                reportParameterCollection[0].Name = "state_name";                                            //Give Your Parameter Name
                reportParameterCollection[0].Values.Add(State_combobox.SelectedItem.Text);               //Pass Parametrs's value here.

                
                MyReportViewer.ServerReport.SetParameters(reportParameterCollection);

                MyReportViewer.ServerReport.Refresh();





            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }

        }
    }
}