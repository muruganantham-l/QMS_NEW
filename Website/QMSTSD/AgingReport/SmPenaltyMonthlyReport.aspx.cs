﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
 
using Microsoft.Reporting.WebForms;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;
 
namespace AgingReport
{
    public partial class SmPenaltyMonthlyReport : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
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

                      

                        string com1 = " Select RowID, ast_lvl_ast_lvl  from ast_lvl (nolock)";

                        SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                        DataTable dt1 = new DataTable();
                        adpt1.Fill(dt1);
                        DropDownState.DataSource = dt1;
                        DropDownState.DataBind();
                        DropDownState.DataTextField = "ast_lvl_ast_lvl";
                        DropDownState.DataValueField = "RowID";
                        DropDownState.DataBind();
                        DropDownState.Items.Insert(0, new ListItem("--Select--", "0"));

                      

                        MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");
                        MyReportViewer.ServerReport.ReportPath = "/QMSTSD/sm_penalty_monthly_report";
                        MyReportViewer.ServerReport.Refresh();
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

        protected void DropDownclinicname_SelectedIndexChanged(object sender, EventArgs e)
        {
            clinic_code_txt.Text = null;
            using (SqlConnection con = new SqlConnection(connString))
            {
                if (con.State == System.Data.ConnectionState.Closed)
                    con.Open();

                using (SqlCommand cm = new SqlCommand("clinic_detail_search_sp", con))
                {
                    cm.CommandType = System.Data.CommandType.StoredProcedure;
                    cm.Parameters.AddWithValue("clinic_code", DropDownclinicname.SelectedValue.ToString());

                    using (SqlDataReader Reader = cm.ExecuteReader())
                    {
                        // if your select returns single row result bases on where clause the use below
                        if (Reader.Read())
                        {
                           // ClinicCategory_txt.Text = Reader["clinic_category"].ToString();
                            //District_txt.Text = Reader["District"].ToString();
                            //State_txt.Text = Reader["state"].ToString();
                            clinic_code_txt.Text = Reader["clinic_code"].ToString();
                        }
                        // if you want to fetch multiple rows from you sp then use below
                        //while (Reader.Read())
                        //{

                        //}

                        // and one Reader.Read() can be used at a time
                    }

                }
            }
        }

        protected void print_btn_Click(object sender, EventArgs e)
        {
            try
            {
                MyReportViewer.ProcessingMode = ProcessingMode.Remote;

                //   ServerReport serverReport = MyReportViewer.ServerReport;

                //MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://chs015-2-3/ReportServer");
                MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");

            //http://localhost/reportserver


                MyReportViewer.ServerReport.ReportPath = "/QMSTSD/sm_penalty_monthly_report_l";
                ReportParameter[] reportParameterCollection = new ReportParameter[6];       //Array size describes the number of paramaters.

                reportParameterCollection[0] = new ReportParameter();
                reportParameterCollection[0].Name = "month_year";                                            //Give Your Parameter Name
                reportParameterCollection[0].Values.Add(month_year.Text);               //Pass Parametrs's value here.

                reportParameterCollection[1] = new ReportParameter();
                reportParameterCollection[1].Name = "clinic_name";                                            //Give Your Parameter Name
                reportParameterCollection[1].Values.Add(DropDownclinicname.SelectedItem.Text);               //Pass Parametrs's value here.


                reportParameterCollection[2] = new ReportParameter();
                reportParameterCollection[2].Name = "clinic_category";                                            //Give Your Parameter Name
                reportParameterCollection[2].Values.Add(DropDownCliniccat.SelectedItem.Text);               //Pass Parametrs's value here.

                reportParameterCollection[3] = new ReportParameter();
                reportParameterCollection[3].Name = "district";                                            //Give Your Parameter Name
                reportParameterCollection[3].Values.Add(DropDownDistrict.SelectedItem.Text);                                     //Pass Parametrs's value here.

                reportParameterCollection[4] = new ReportParameter();
                reportParameterCollection[4].Name = "state";                                            //Give Your Parameter Name
                reportParameterCollection[4].Values.Add(DropDownState.SelectedItem.Text);                                     //Pass Parametrs's value here.

                reportParameterCollection[5] = new ReportParameter();
                reportParameterCollection[5].Name = "clinic_code";                                            //Give Your Parameter Name
                reportParameterCollection[5].Values.Add(clinic_code_txt.Text);                                     //Pass Parametrs's value here.

                MyReportViewer.ServerReport.SetParameters(reportParameterCollection);

                MyReportViewer.ServerReport.Refresh();





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
                string com1 = "select 1 RowID,'ALL' ast_loc_ast_loc union select RowID , ast_loc_ast_loc from  ast_loc (nolock) where ast_loc_state = '" + DropDownState.SelectedItem.Text + "'";

                SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                DataTable dt1 = new DataTable();
                adpt1.Fill(dt1);
                DropDownDistrict.DataSource = dt1;
                DropDownDistrict.DataBind();
                DropDownDistrict.DataTextField = "ast_loc_ast_loc";
                DropDownDistrict.DataValueField = "RowID";
                DropDownDistrict.DataBind();
                DropDownDistrict.Items.Insert(0, new ListItem("--Select--", "0"));
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
            DropDownCliniccat.Items.Clear();
            /*For Clinic Cate Dropdown Load*/
            DropDownCliniccat.Items.Insert(0, new ListItem("KESIHATAN", "2"));
            DropDownCliniccat.Items.Insert(0, new ListItem("PERGIGIAN", "3"));
            DropDownCliniccat.Items.Insert(0, new ListItem("ALL", "1"));
            DropDownCliniccat.Items.Insert(0, new ListItem("--Select--", "0"));

            
        }

        protected void DropDownCliniccat_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(connString);
              

                /*For State Dropdown Load*/
               // string com = "SELECT c.cus_mst_customer_cd 'clinic_code',c.cus_mst_desc 'clinic_name' from cus_mst m (NOLOCK) join cus_det d (NOLOCK) on m.RowID = d.mst_RowID   ";
              //  string com = "SELECT m.cus_mst_customer_cd 'clinic_code',m.cus_mst_desc 'clinic_name' from cus_mst m (NOLOCK) join cus_det d (NOLOCK) on m.RowID = d.mst_RowID where cus_det_state = '" + DropDownState.SelectedItem.Text + "' and cus_det_city = '" + DropDownDistrict.SelectedItem.Text + "' and cus_mst_shipvia = '" + DropDownCliniccat.SelectedItem.Text + "'";
                SqlCommand cmd = new SqlCommand("exec search_clinic_name_sp '" + DropDownState.SelectedItem.Text + "','" +
                DropDownDistrict.SelectedItem.Text + "','" + DropDownCliniccat.SelectedItem.Text + "'", con);


                // SqlDataAdapter adpt = new SqlDataAdapter(com, con);
                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adpt.Fill(dt);
                DropDownclinicname.DataSource = dt;
                DropDownclinicname.DataBind();
                DropDownclinicname.DataTextField = "clinic_name";
                DropDownclinicname.DataValueField = "clinic_code";
                DropDownclinicname.DataBind();
                DropDownclinicname.Items.Insert(0, new ListItem("--Select--", "0"));

               
            }
            catch (Exception ex)
            {
                //log error 
                //display friendly error to user
                string msg = "Insert Error:";
                msg += ex.Message;


            }
        }
    }
}
    
