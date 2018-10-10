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

namespace QMSBIL
{
    public partial class WebForm1 : System.Web.UI.Page
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
                    DropDownCliniccat.Items.Insert(0, new ListItem("KESIHATAN", "1"));
                    DropDownCliniccat.Items.Insert(0, new ListItem("PERGIGIAN", "2"));
                    DropDownCliniccat.Items.Insert(0, new ListItem("ALL", "0"));

                    /*For Ownership Dropdown Load*/

                    DropDownown.Items.Insert(0, new ListItem("New Biomedical", "1"));
                    DropDownown.Items.Insert(0, new ListItem("Purchase Biomedical", "2"));
                    DropDownown.Items.Insert(0, new ListItem("--Select--", "0"));
                    
                    /*For BE Category Cate Dropdown Load*/
                   // DropDownClinicname.Items.Insert(0, new ListItem("ALL", "0"));

                    /*For Batch Number Dropdown Load*/
                   /* string com2 = "select distinct ast_det_varchar21 'Batchname' , ast_det_varchar21 'Batchno' from ast_det (nolock) where ast_det_varchar15 in ('New Biomedical' , 'Purchased Biomedical')";

                    SqlDataAdapter adpt3 = new SqlDataAdapter(com2, con);
                    DataTable dt3 = new DataTable();
                    adpt3.Fill(dt3);
                    DropdownBatch.DataSource = dt3;
                    DropdownBatch.DataBind();
                    DropdownBatch.DataTextField = "Batchname";
                    DropdownBatch.DataValueField = "Batchno";
                    DropdownBatch.DataBind();
                    DropdownBatch.Items.Insert(0, new ListItem("ALL", "0"));
                    */
                    /*For Batch Number Dropdown Load*/
                    string com3 = "select distinct ast_det_varchar21 'Batchname' , ast_det_varchar21 'Batchno' from ast_det (nolock) where ast_det_varchar15 in ('New Biomedical' , 'Purchased Biomedical')";

                    SqlDataAdapter adpt4 = new SqlDataAdapter(com3, con);
                    DataTable dt4 = new DataTable();
                    adpt4.Fill(dt4);
                    List1.DataSource = dt4;
                    List1.DataBind();
                    List1.DataTextField = "Batchname";
                    List1.DataValueField = "Batchno";
                    List1.DataBind();
                    List1.Items.Insert(0, new ListItem("ALL", "0"));
                    List1.EnableViewState = true;
                    List1.SelectionMode = ListSelectionMode.Multiple;

                    /*For BE Category Dropdown Load*/
                    string com5 = "select ast_grp_grp_cd, ast_grp_category  from ast_grp (nolock) where audit_user = 'Patch'";

                     SqlDataAdapter adpt5 = new SqlDataAdapter(com5, con);
                     DataTable dt5 = new DataTable();
                     adpt5.Fill(dt5);
                     DropDownCategory.DataSource = dt5;
                     DropDownCategory.DataBind();
                     DropDownCategory.DataTextField = "ast_grp_category";
                     DropDownCategory.DataValueField = "ast_grp_grp_cd";
                     DropDownCategory.DataBind();
                     DropDownCategory.Items.Insert(0, new ListItem("ALL", "0"));
                     
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

        protected void Button1_Click(object sender, EventArgs e)
        {
           try
            {
                string BatchNumber = "";
                int i = 0;
                foreach (ListItem item in List1.Items)
                {
                    if (item.Selected)
                    {
                        if (i == 0)
                        {
                            BatchNumber += "'" + item.Text + "'";
                            i = 1;
                        }
                        else
                        {
                            BatchNumber += ",'" + item.Text + "'";
                        }
                    }
                }
              
                MyReportViewer.ProcessingMode = ProcessingMode.Remote;

             //   ServerReport serverReport = MyReportViewer.ServerReport;

                MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");
            
                if (DropDownown.SelectedItem.Text == "Purchase Biomedical")
                {
                    MyReportViewer.ServerReport.ReportPath = "/Report Project1/BillingPBE";
                    ReportParameter[] reportParameterCollection = new ReportParameter[8];       //Array size describes the number of paramaters.

                    reportParameterCollection[0] = new ReportParameter();
                    reportParameterCollection[0].Name = "statename";                                            //Give Your Parameter Name
                    reportParameterCollection[0].Values.Add(DropDownState.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[1] = new ReportParameter();
                    reportParameterCollection[1].Name = "District";                                            //Give Your Parameter Name
                    reportParameterCollection[1].Values.Add(DropDownDistrict.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[2] = new ReportParameter();
                    reportParameterCollection[2].Name = "batchanumber";                                            //Give Your Parameter Name
                    reportParameterCollection[2].Values.Add(BatchNumber);                                           //Pass Parametrs's value here.

                    reportParameterCollection[3] = new ReportParameter();
                    reportParameterCollection[3].Name = "clinicName";                                            //Give Your Parameter Name
                    reportParameterCollection[3].Values.Add(DropDownCategory.SelectedItem.Value);               //Pass Parametrs's value here.

                    reportParameterCollection[4] = new ReportParameter();
                    reportParameterCollection[4].Name = "ownership";                                            //Give Your Parameter Name
                    reportParameterCollection[4].Values.Add(DropDownown.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[5] = new ReportParameter();
                    reportParameterCollection[5].Name = "clinicCateg";                                            //Give Your Parameter Name
                    reportParameterCollection[5].Values.Add(DropDownCliniccat.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[6] = new ReportParameter();
                    reportParameterCollection[6].Name = "invoicedate";                                            //Give Your Parameter Name
                    reportParameterCollection[6].Values.Add(TextBox1.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[7] = new ReportParameter();
                    reportParameterCollection[7].Name = "paymonth";                                            //Give Your Parameter Name
                    reportParameterCollection[7].Values.Add(TextBox2.Text);               //Pass Parametrs's value here.

                    MyReportViewer.ServerReport.SetParameters(reportParameterCollection);

                    MyReportViewer.ServerReport.Refresh();

                }
                else 
                {
                    MyReportViewer.ServerReport.ReportPath = "/Report Project1/BillingNBE";
                    ReportParameter[] reportParameterCollection = new ReportParameter[8];       //Array size describes the number of paramaters.

                    reportParameterCollection[0] = new ReportParameter();
                    reportParameterCollection[0].Name = "statename";                                            //Give Your Parameter Name
                    reportParameterCollection[0].Values.Add(DropDownState.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[1] = new ReportParameter();
                    reportParameterCollection[1].Name = "District";                                            //Give Your Parameter Name
                    reportParameterCollection[1].Values.Add(DropDownDistrict.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[2] = new ReportParameter();
                    reportParameterCollection[2].Name = "batchanumber";                                            //Give Your Parameter Name
                    reportParameterCollection[2].Values.Add(BatchNumber);                                           //Pass Parametrs's value here.

                    reportParameterCollection[3] = new ReportParameter();
                    reportParameterCollection[3].Name = "clinicName";                                            //Give Your Parameter Name
                    reportParameterCollection[3].Values.Add(DropDownCategory.SelectedItem.Value);               //Pass Parametrs's value here.

                    reportParameterCollection[4] = new ReportParameter();
                    reportParameterCollection[4].Name = "ownership";                                            //Give Your Parameter Name
                    reportParameterCollection[4].Values.Add(DropDownown.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[5] = new ReportParameter();
                    reportParameterCollection[5].Name = "clinicCateg";                                            //Give Your Parameter Name
                    reportParameterCollection[5].Values.Add(DropDownCliniccat.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[6] = new ReportParameter();
                    reportParameterCollection[6].Name = "invoicedate";                                            //Give Your Parameter Name
                    reportParameterCollection[6].Values.Add(TextBox1.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[7] = new ReportParameter();
                    reportParameterCollection[7].Name = "paymonth";                                            //Give Your Parameter Name
                    reportParameterCollection[7].Values.Add(TextBox2.Text);               //Pass Parametrs's value here.

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
                    string com1 = "select RowID , ast_loc_ast_loc from  ast_loc (nolock) where ast_loc_disable_flag = '0' and ast_loc_state = '" + DropDownState.SelectedItem.Text + "'";

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
			finally
                {
                    con.Close();
                }
                
        }

        protected void DropDownDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {

                string BatchNumber = "";
                int i = 0;
                foreach (ListItem item in List1.Items)
                {
                    if (item.Selected)
                    {
                        if (i == 0)
                        {
                            BatchNumber += "'" + item.Text + "'";
                            i = 1;
                        }
                        else
                        {
                            BatchNumber += ",'" + item.Text + "'";
                        }
                    }
                }
                

                MyReportViewer.ProcessingMode = ProcessingMode.Remote;

                //   ServerReport serverReport = MyReportViewer.ServerReport;

                MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");

                    MyReportViewer.ServerReport.ReportPath = "/Report Project1/Summary";
                    ReportParameter[] reportParameterCollection = new ReportParameter[8];       //Array size describes the number of paramaters.

                    reportParameterCollection[0] = new ReportParameter();
                    reportParameterCollection[0].Name = "statename";                                            //Give Your Parameter Name
                    reportParameterCollection[0].Values.Add(DropDownState.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[1] = new ReportParameter();
                    reportParameterCollection[1].Name = "District";                                            //Give Your Parameter Name
                    reportParameterCollection[1].Values.Add(DropDownDistrict.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[2] = new ReportParameter();
                    reportParameterCollection[2].Name = "batchanumber";                                            //Give Your Parameter Name
                    reportParameterCollection[2].Values.Add(BatchNumber);                                           //Pass Parametrs's value here.

                    reportParameterCollection[3] = new ReportParameter();
                    reportParameterCollection[3].Name = "clinicName";                                            //Give Your Parameter Name
                    reportParameterCollection[3].Values.Add(DropDownCategory.SelectedItem.Value);               //Pass Parametrs's value here.

                    reportParameterCollection[4] = new ReportParameter();
                    reportParameterCollection[4].Name = "ownership";                                            //Give Your Parameter Name
                    reportParameterCollection[4].Values.Add(DropDownown.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[5] = new ReportParameter();
                    reportParameterCollection[5].Name = "clinicCateg";                                            //Give Your Parameter Name
                    reportParameterCollection[5].Values.Add(DropDownCliniccat.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[6] = new ReportParameter();
                    reportParameterCollection[6].Name = "invoicedate";                                            //Give Your Parameter Name
                    reportParameterCollection[6].Values.Add(TextBox1.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[7] = new ReportParameter();
                    reportParameterCollection[7].Name = "paymonth";                                            //Give Your Parameter Name
                    reportParameterCollection[7].Values.Add(TextBox2.Text);               //Pass Parametrs's value here.

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