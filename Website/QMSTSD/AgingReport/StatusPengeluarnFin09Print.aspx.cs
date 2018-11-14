using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
 
using Microsoft.Reporting.WebForms;
namespace AgingReport
{
    public partial class StatusPengeluarnFin09Print : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["name"] == null)
                {

                    Response.Redirect("~/loginPage.aspx");

                }
                else
                {
                    string username = Session["name"].ToString();
                    this.Label8.Text = string.Format("Hi {0}", Session["name"].ToString() + "!");
                    string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                    SqlConnection con = null;

                    try
                    {
                        con = new SqlConnection(connString);





                        string com1 = " ;with yearlist as(   select year(getdate()) as year    union all    select yl.year - 1 as year    from yearlist yl    where yl.year - 1 >= YEAR(GetDate()) - 3) select year from yearlist order by year desc; ";

                        SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                        DataTable dt1 = new DataTable();
                        adpt1.Fill(dt1);
                        dropdownyearfrom.DataSource = dt1;
                        dropdownyearfrom.DataBind();
                        dropdownyearfrom.DataTextField = "year";
                        dropdownyearfrom.DataValueField = "year";
                        dropdownyearfrom.DataBind();
                        // DropDownState.Items.Insert(0, new ListItem("ALL", "0"));
                        dropdownyearfrom.Items.Insert(0, new ListItem("--Select--", "0"));


                        dropdownyearto.DataSource = dt1;
                        dropdownyearto.DataBind();
                        dropdownyearto.DataTextField = "year";
                        dropdownyearto.DataValueField = "year";
                        dropdownyearto.DataBind();
                        // DropDownState.Items.Insert(0, new ListItem("ALL", "0"));
                        dropdownyearto.Items.Insert(0, new ListItem("--Select--", "0"));

                        MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");
                        MyReportViewer.ServerReport.ReportPath = "/QMSTSD/data_penalti_berdasarkan_fin09_rpt";// "/Report Project1/EquipMainStatusRpt";

                        MyReportViewer.ServerReport.Refresh();

                        DropDownReportname.Items.Insert(0, new ListItem("Data Penalti Berdasarkan Fin09", "1"));
                        DropDownReportname.Items.Insert(0, new ListItem("Status Pengeluaran Fin09", "2"));
                        DropDownReportname.Items.Insert(0, new ListItem("--Select--", "0"));

                        string com2 = " select 'Quarter 1' 'quarter_txt','Q1' 'quarter_id' union select 'Quarter 2','Q2' union select 'Quarter 3','Q3' union select 'Quarter 4','Q4' ";

                        SqlDataAdapter adpt2 = new SqlDataAdapter(com2, con);
                        DataTable dt2 = new DataTable();
                        adpt2.Fill(dt2);
                        DropDownquarter.DataSource = dt2;
                        DropDownquarter.DataBind();
                        DropDownquarter.DataTextField = "quarter_txt";
                        DropDownquarter.DataValueField = "quarter_id";
                        DropDownquarter.DataBind();
                        // DropDownState.Items.Insert(0, new ListItem("ALL", "0"));
                        DropDownquarter.Items.Insert(0, new ListItem("--Select--", "0"));


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

        protected void print_Click(object sender, EventArgs e)
        {
            try
            {

                lblError.Text = null;
                MyReportViewer.ProcessingMode = ProcessingMode.Remote;

                //   ServerReport serverReport = MyReportViewer.ServerReport;

                //MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://chs015-2-3/ReportServer");
                MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");

                if (DropDownReportname.SelectedItem.Text == "Data Penalti Berdasarkan Fin09")
                {
                    MyReportViewer.ServerReport.ReportPath = "/QMSTSD/data_penalti_berdasarkan_fin09_rpt";
                }
                else
                {
                    MyReportViewer.ServerReport.ReportPath = "/QMSTSD/status_pengeluaran_fin09_rpt";
                }

                ReportParameter[] reportParameterCollection = new ReportParameter[3];       //Array size describes the number of paramaters.

                reportParameterCollection[0] = new ReportParameter();
                reportParameterCollection[0].Name = "year_from";                                            //Give Your Parameter Name
                reportParameterCollection[0].Values.Add(dropdownyearfrom.SelectedItem.Text);               //Pass Parametrs's value here.

                reportParameterCollection[1] = new ReportParameter();
                reportParameterCollection[1].Name = "year_to";                                            //Give Your Parameter Name
                reportParameterCollection[1].Values.Add(dropdownyearto.SelectedItem.Text);               //Pass Parametrs's value here.

                reportParameterCollection[2] = new ReportParameter();
                reportParameterCollection[2].Name = "quarter";                                            //Give Your Parameter Name
                reportParameterCollection[2].Values.Add(DropDownquarter.SelectedItem.Value);               //Pass Parametrs's value here.


                MyReportViewer.ServerReport.SetParameters(reportParameterCollection);

                MyReportViewer.ServerReport.Refresh();





            }
            catch (Exception ex)
            {
                lblError.Text = ex.ToString();
                Response.Write(ex.ToString());
            }
        }

        protected void DropDownyearfrom_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}