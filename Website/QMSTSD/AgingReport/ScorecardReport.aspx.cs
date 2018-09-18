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
    public partial class ScorecardReport : System.Web.UI.Page
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
                   // Label8.Text = username;
                    try
                    {
                        MyReportViewer.ProcessingMode = ProcessingMode.Remote;
                        MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
                        MyReportViewer.ServerReport.ReportPath = "/Scorecard-TSD/Scorecard-All";
                        MyReportViewer.ServerReport.Refresh();
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.ToString());
                    }
                }
            }
        }

        protected void btndisplay_Click(object sender, EventArgs e)
        {
            /*
             * string strReportUser = "administrator";
            string strReportUserPW = "ITA2888";
            //string strReportUserDomain = "DomainName";

            string sTargetURL = "http://chs015-2-3/ReportServer/Pages/ReportViewer.aspx?%2fScorecard-TSD%2fScorecard-All&rs:Command=Render";

            HttpWebRequest req =(HttpWebRequest)WebRequest.Create(sTargetURL);
            req.PreAuthenticate = true;
            req.Credentials = new System.Net.NetworkCredential(
                strReportUser,
                strReportUserPW);

            HttpWebResponse HttpWResp = (HttpWebResponse)req.GetResponse();

            Stream fStream = HttpWResp.GetResponseStream();

            



            //Now turn around and send this as the response..
            byte[] fileBytes = ReadFully(fStream);
            // Could save to a database or file here as well.
            HttpWResp.Close();
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader(
                "content-disposition",
                "attachment; filename=\"Report For.pdf");
            Response.BinaryWrite(fileBytes);
            Response.Flush();
            Response.End();
                */
            MyReportViewer.ProcessingMode = ProcessingMode.Remote;
                MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
                MyReportViewer.ServerReport.ReportPath = "/Scorecard-TSD/Scorecard-All";
                MyReportViewer.ServerReport.Refresh();

                
                 /*ReportParameter[] reportParameterCollection = new ReportParameter[1];       //Array size describes the number of paramaters.
                 reportParameterCollection[0] = new ReportParameter();
                 reportParameterCollection[0].Name = "City";                                 //Give Your Parameter Name
                 reportParameterCollection[0].Values.Add("Seattle");                         //Pass Parametrs's value here.
                 MyReportViewer.ServerReport.SetParameters(reportParameterCollection);
                 */
                MyReportViewer.ServerReport.Refresh();
            
           
        }

       /* public static byte[] ReadFully(Stream fStream)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                fStream.CopyTo(ms);
                return ms.ToArray();
            } 
            throw new NotImplementedException();
        }
        */

    }
}

