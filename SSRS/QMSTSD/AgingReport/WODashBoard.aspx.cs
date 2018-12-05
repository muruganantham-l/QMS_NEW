using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;

namespace AgingReport
{
    public partial class WODashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MyReportViewer.ProcessingMode = ProcessingMode.Remote;
            MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
            MyReportViewer.ServerReport.ReportPath = "/ReportSSRS/Dashboard1";
            MyReportViewer.ServerReport.Refresh();
        }
    }
}