using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
namespace QMSMMD
{
    public partial class StockMovementReport : System.Web.UI.Page
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

        protected void print_btn_Click(object sender, EventArgs e)
        {
            try
            {

                MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");
                MyReportViewer.ServerReport.ReportPath = "/Report Project1/EquipMainStatusRpt";

                MyReportViewer.ServerReport.Refresh();
                MyReportViewer.ProcessingMode = ProcessingMode.Remote;

                //   ServerReport serverReport = MyReportViewer.ServerReport;

                //MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://chs015-2-3/ReportServer");
                MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");


                MyReportViewer.ServerReport.ReportPath = "/QMSMMD/inventry_mst_stk_mvmt_rpt";
                ReportParameter[] reportParameterCollection = new ReportParameter[4];       //Array size describes the number of paramaters.

                reportParameterCollection[0] = new ReportParameter();
                reportParameterCollection[0].Name = "stock_no";                                            //Give Your Parameter Name
                reportParameterCollection[0].Values.Add(stock_txt.Text);               //Pass Parametrs's value here.

                reportParameterCollection[1] = new ReportParameter();
                reportParameterCollection[1].Name = "startdate";                                            //Give Your Parameter Name
                reportParameterCollection[1].Values.Add(fromdate.Text);               //Pass Parametrs's value here.


                reportParameterCollection[2] = new ReportParameter();
                reportParameterCollection[2].Name = "enddate";                                            //Give Your Parameter Name
                reportParameterCollection[2].Values.Add(todate.Text);               //Pass Parametrs's value here.

                reportParameterCollection[3] = new ReportParameter();
                reportParameterCollection[3].Name = "state";                                            //Give Your Parameter Name
                reportParameterCollection[3].Values.Add(DropDownState.SelectedItem.Text);

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