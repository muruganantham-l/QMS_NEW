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
using System.Web.UI.WebControls;


namespace AgingReport
{
    public partial class AccessoryReport : System.Web.UI.Page
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
                    //Label8.Visible = false;
                    //Label8.Text = username;

                    string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                    SqlConnection con = null;

                    try
                    {
                        con = new SqlConnection(connString);

                        /*For State Dropdown Load*/
                        string com = "Select RowID, ast_lvl_ast_lvl  from ast_lvl (nolock)";

                        SqlDataAdapter adpt = new SqlDataAdapter(com, con);
                        DataTable dt = new DataTable();
                        adpt.Fill(dt);
                        DropDownState.DataSource = dt;
                        DropDownState.DataBind();
                        DropDownState.DataTextField = "ast_lvl_ast_lvl";
                        DropDownState.DataValueField = "RowID";
                        DropDownState.DataBind();
                        DropDownState.Items.Insert(0, new ListItem("ALL", "0"));

                        /*For District Dropdown Load*/

                        DropDownDistrict.Items.Insert(0, new ListItem("ALL", "0"));

                        /*For Clinic Cate Dropdown Load*/
                        DropDownCliniccat.Items.Insert(0, new ListItem("Dental Delivery Units", "1"));
                        DropDownCliniccat.Items.Insert(0, new ListItem("CHAIRS, EXAMINATION/TREATMENT, DENTISTRY, SPECIALIST", "2"));
                        DropDownCliniccat.Items.Insert(0, new ListItem("Chairs, Examination/Treatment, Dentistry", "3"));
                        DropDownCliniccat.Items.Insert(0, new ListItem("ALL", "0"));
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {


                MyReportViewer.ProcessingMode = ProcessingMode.Remote;

                //   ServerReport serverReport = MyReportViewer.ServerReport;

                MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");

                if (DropDownCliniccat.SelectedItem.Text == "Chairs, Examination/Treatment, Dentistry")
                {
                    MyReportViewer.ServerReport.ReportPath = "/DentalChairAccessory/Dentalchair";
                    ReportParameter[] reportParameterCollection = new ReportParameter[4];       //Array size describes the number of paramaters.

                    reportParameterCollection[0] = new ReportParameter();
                    reportParameterCollection[0].Name = "state";                                            //Give Your Parameter Name
                    reportParameterCollection[0].Values.Add(DropDownState.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[1] = new ReportParameter();
                    reportParameterCollection[1].Name = "District";                                            //Give Your Parameter Name
                    reportParameterCollection[1].Values.Add(DropDownDistrict.SelectedItem.Text);               //Pass Parametrs's value here.

                    
                    reportParameterCollection[2] = new ReportParameter();
                    reportParameterCollection[2].Name = "category";                                            //Give Your Parameter Name
                    reportParameterCollection[2].Values.Add(DropDownCliniccat.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[3] = new ReportParameter();
                    reportParameterCollection[3].Name = "Benumber";                                            //Give Your Parameter Name
                    reportParameterCollection[3].Values.Add(TextBox4.Text);                                     //Pass Parametrs's value here.


                    MyReportViewer.ServerReport.SetParameters(reportParameterCollection);

                    MyReportViewer.ServerReport.Refresh();

                }
                if (DropDownCliniccat.SelectedItem.Text == "CHAIRS, EXAMINATION/TREATMENT, DENTISTRY, SPECIALIST")
                {
                    MyReportViewer.ServerReport.ReportPath = "/DentalChairAccessory/DentalSpecialist";
                    ReportParameter[] reportParameterCollection = new ReportParameter[4];       //Array size describes the number of paramaters.

                    reportParameterCollection[0] = new ReportParameter();
                    reportParameterCollection[0].Name = "state";                                            //Give Your Parameter Name
                    reportParameterCollection[0].Values.Add(DropDownState.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[1] = new ReportParameter();
                    reportParameterCollection[1].Name = "District";                                            //Give Your Parameter Name
                    reportParameterCollection[1].Values.Add(DropDownDistrict.SelectedItem.Text);               //Pass Parametrs's value here.


                    reportParameterCollection[2] = new ReportParameter();
                    reportParameterCollection[2].Name = "category";                                            //Give Your Parameter Name
                    reportParameterCollection[2].Values.Add(DropDownCliniccat.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[3] = new ReportParameter();
                    reportParameterCollection[3].Name = "Benumber";                                            //Give Your Parameter Name
                    reportParameterCollection[3].Values.Add(TextBox4.Text);                                     //Pass Parametrs's value here.

                    MyReportViewer.ServerReport.SetParameters(reportParameterCollection);

                    MyReportViewer.ServerReport.Refresh();

                }
                if (DropDownCliniccat.SelectedItem.Text == "Dental Delivery Units")
                {
                    MyReportViewer.ServerReport.ReportPath = "/DentalChairAccessory/DeliveryUnits";
                    ReportParameter[] reportParameterCollection = new ReportParameter[4];       //Array size describes the number of paramaters.

                    reportParameterCollection[0] = new ReportParameter();
                    reportParameterCollection[0].Name = "state";                                            //Give Your Parameter Name
                    reportParameterCollection[0].Values.Add(DropDownState.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[1] = new ReportParameter();
                    reportParameterCollection[1].Name = "District";                                            //Give Your Parameter Name
                    reportParameterCollection[1].Values.Add(DropDownDistrict.SelectedItem.Text);               //Pass Parametrs's value here.


                    reportParameterCollection[2] = new ReportParameter();
                    reportParameterCollection[2].Name = "category";                                            //Give Your Parameter Name
                    reportParameterCollection[2].Values.Add(DropDownCliniccat.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[3] = new ReportParameter();
                    reportParameterCollection[3].Name = "Benumber";                                            //Give Your Parameter Name
                    reportParameterCollection[3].Values.Add(TextBox4.Text);                                     //Pass Parametrs's value here.

                    MyReportViewer.ServerReport.SetParameters(reportParameterCollection);

                    MyReportViewer.ServerReport.Refresh();

                }

            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }

        protected void DropDownState_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(connString);
                /*For District Dropdown Load*/
                string com1 = "select RowID , ast_loc_ast_loc from  ast_loc (nolock) where ast_loc_state = '" + DropDownState.SelectedItem.Text + "'";

                SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                DataTable dt1 = new DataTable();
                adpt1.Fill(dt1);
                DropDownDistrict.DataSource = dt1;
                DropDownDistrict.DataBind();
                DropDownDistrict.DataTextField = "ast_loc_ast_loc";
                DropDownDistrict.DataValueField = "RowID";
                DropDownDistrict.DataBind();
                DropDownDistrict.Items.Insert(0, new ListItem("ALL", "0"));
            }
            catch (Exception ex)
            {
                //log error 
                //display friendly error to user
                string msg = "Insert Error:";
                msg += ex.Message;


            }

        }

        protected void DropDownDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}