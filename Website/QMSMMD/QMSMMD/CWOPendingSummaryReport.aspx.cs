using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace QMSMMD
{
    public partial class CWOPendingSummaryReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //MyReportViewer.ProcessingMode = ProcessingMode.Remote;
                //MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
                //MyReportViewer.ServerReport.ReportPath = "/QMSMMD/cwo_pend_summary";
                //MyReportViewer.ServerReport.Refresh();

               
                ///*ReportParameter[] reportParameterCollection = new ReportParameter[1];       //Array size describes the number of paramaters.
                //reportParameterCollection[0] = new ReportParameter();
                //reportParameterCollection[0].Name = "City";                                 //Give Your Parameter Name
                //reportParameterCollection[0].Values.Add("Seattle");                         //Pass Parametrs's value here.
                //MyReportViewer.ServerReport.SetParameters(reportParameterCollection);
                //*/
                //MyReportViewer.ServerReport.Refresh();

                try
                {
                    MyReportViewer.ProcessingMode = ProcessingMode.Remote;
                    //MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
                    //MyReportViewer.ServerReport.ReportPath = "/QMSMMD/cwo_pend_summary";
                    //MyReportViewer.ServerReport.Refresh();
                }
                catch (Exception ex)
                {
                    Response.Write(ex.ToString());
                }
            }
        }

        protected void report_btn_Click(object sender, EventArgs e)
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                

                using (SqlConnection con = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand("cwo_pending_summary_rpt_sp", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                MyReportViewer.ProcessingMode = ProcessingMode.Remote;
                MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
                MyReportViewer.ServerReport.ReportPath = "/QMSMMD/cwo_pend_summary";
                MyReportViewer.ServerReport.Refresh();
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }
    }
}