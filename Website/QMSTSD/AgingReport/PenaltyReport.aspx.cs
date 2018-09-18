﻿using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AgingReport
{
    public partial class PenaltyReport : System.Web.UI.Page
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
                    //Label8.Text = username;

                    string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                    SqlConnection con = null;

                    try
                    {
                        con = new SqlConnection(connString);

                        string com01 = "select distinct  ast_loc_zone , ast_loc_zone from ast_loc (nolock)";

                        SqlDataAdapter adptzo = new SqlDataAdapter(com01, con);
                        DataTable dtzo = new DataTable();
                        adptzo.Fill(dtzo);
                        DropDownZone.DataSource = dtzo;
                        DropDownZone.DataBind();
                        DropDownZone.DataTextField = "ast_loc_zone";
                        DropDownZone.DataValueField = "ast_loc_zone";
                        DropDownZone.DataBind();
                        DropDownZone.Items.Insert(0, new ListItem("ALL", "0"));


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

                        DropDownDistrict.Items.Insert(0, new ListItem("ALL", "0"));

                        DropDownCliniccat.Items.Insert(0, new ListItem("KESIHATAN", "1"));
                        DropDownCliniccat.Items.Insert(0, new ListItem("PERGIGIAN", "2"));
                        DropDownCliniccat.Items.Insert(0, new ListItem("ALL", "0"));

                        /*For State Dropdown Load*/
                        string comown = "select distinct Ownership_desc as 'Ownership' , Ownership_desc from ownership_mst (nolock)";

                        SqlDataAdapter adptown = new SqlDataAdapter(comown, con);
                        DataTable dtown = new DataTable();
                        adptown.Fill(dtown);
                        DropDownownership.DataSource = dtown;
                        DropDownownership.DataBind();
                        DropDownownership.DataTextField = "Ownership_desc";
                        DropDownownership.DataValueField = "Ownership";
                        DropDownownership.DataBind();
                        DropDownownership.Items.Insert(0, new ListItem("ALL", "0"));


                        MyReportViewer.ProcessingMode = ProcessingMode.Remote;
                        MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
                        MyReportViewer.ServerReport.ReportPath = "/TSD-Performance/TSD-USM-KPIPenalty";
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
        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                MyReportViewer.ProcessingMode = ProcessingMode.Remote;

                //   ServerReport serverReport = MyReportViewer.ServerReport;

                MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");

                if (DropDownState.SelectedItem.Text == "ALL" && DropDownZone.SelectedItem.Text == "ALL")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('Please Select atleast State or Zone')</script>");
                }

                if (DropDownState.SelectedItem.Text =="ALL")
                    {
                        MyReportViewer.ServerReport.ReportPath = "/TSD-Performance/TSD-USM-Penalty";
                        ReportParameter[] reportParameterCollection = new ReportParameter[7];       //Array size describes the number of paramaters.

                        reportParameterCollection[0] = new ReportParameter();
                        reportParameterCollection[0].Name = "statename";                                            //Give Your Parameter Name
                        reportParameterCollection[0].Values.Add(DropDownState.SelectedItem.Text);               //Pass Parametrs's value here.

                        reportParameterCollection[1] = new ReportParameter();
                        reportParameterCollection[1].Name = "district";                                            //Give Your Parameter Name
                        reportParameterCollection[1].Values.Add(DropDownDistrict.SelectedItem.Text);               //Pass Parametrs's value here.

                        reportParameterCollection[2] = new ReportParameter();
                        reportParameterCollection[2].Name = "zone";                                            //Give Your Parameter Name
                        reportParameterCollection[2].Values.Add(DropDownZone.SelectedItem.Text);                                           //Pass Parametrs's value here.

                        reportParameterCollection[3] = new ReportParameter();
                        reportParameterCollection[3].Name = "reporttype";                                            //Give Your Parameter Name
                        reportParameterCollection[3].Values.Add(DropDownCliniccat.SelectedItem.Text);               //Pass Parametrs's value here.

                        reportParameterCollection[4] = new ReportParameter();
                        reportParameterCollection[4].Name = "periodfrom";                                            //Give Your Parameter Name
                        reportParameterCollection[4].Values.Add(TextBox1.Text);               //Pass Parametrs's value here.

                        reportParameterCollection[5] = new ReportParameter();
                        reportParameterCollection[5].Name = "periodto";                                            //Give Your Parameter Name
                        reportParameterCollection[5].Values.Add(TextBox2.Text);               //Pass Parametrs's value here.

                        reportParameterCollection[6] = new ReportParameter();
                        reportParameterCollection[6].Name = "ownership";                                            //Give Your Parameter Name
                        reportParameterCollection[6].Values.Add(DropDownownership.SelectedItem.Text);               //Pass Parametrs's value here.

                        MyReportViewer.ServerReport.SetParameters(reportParameterCollection);

                        MyReportViewer.ServerReport.Refresh();
                     }   
                else
                    {
                    MyReportViewer.ServerReport.ReportPath = "/TSD-Performance/TSD-USM-KPIPenalty";
                        ReportParameter[] reportParameterCollection = new ReportParameter[7];       //Array size describes the number of paramaters.

                        reportParameterCollection[0] = new ReportParameter();
                        reportParameterCollection[0].Name = "statename";                                            //Give Your Parameter Name
                        reportParameterCollection[0].Values.Add(DropDownState.SelectedItem.Text);               //Pass Parametrs's value here.

                        reportParameterCollection[1] = new ReportParameter();
                        reportParameterCollection[1].Name = "district";                                            //Give Your Parameter Name
                        reportParameterCollection[1].Values.Add(DropDownDistrict.SelectedItem.Text);               //Pass Parametrs's value here.

                        reportParameterCollection[2] = new ReportParameter();
                        reportParameterCollection[2].Name = "zone";                                            //Give Your Parameter Name
                        reportParameterCollection[2].Values.Add(DropDownZone.SelectedItem.Text);                                           //Pass Parametrs's value here.

                        reportParameterCollection[3] = new ReportParameter();
                        reportParameterCollection[3].Name = "reporttype";                                            //Give Your Parameter Name
                        reportParameterCollection[3].Values.Add(DropDownCliniccat.SelectedItem.Text);               //Pass Parametrs's value here.

                        reportParameterCollection[4] = new ReportParameter();
                        reportParameterCollection[4].Name = "periodfrom";                                            //Give Your Parameter Name
                        reportParameterCollection[4].Values.Add(TextBox1.Text);               //Pass Parametrs's value here.

                        reportParameterCollection[5] = new ReportParameter();
                        reportParameterCollection[5].Name = "periodto";                                            //Give Your Parameter Name
                        reportParameterCollection[5].Values.Add(TextBox2.Text);               //Pass Parametrs's value here.

                        reportParameterCollection[6] = new ReportParameter();
                        reportParameterCollection[6].Name = "ownership";                                            //Give Your Parameter Name
                        reportParameterCollection[6].Values.Add(DropDownownership.SelectedItem.Text);               //Pass Parametrs's value here.

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

                /*For Zone Dropdown Load*/
                if (DropDownState.SelectedItem.Text == "ALL")
                {
                    
                    string com01 = "select distinct  ast_loc_zone , ast_loc_zone from ast_loc (nolock)";

                    SqlDataAdapter adptzo = new SqlDataAdapter(com01, con);
                    DataTable dtzo = new DataTable();
                    adptzo.Fill(dtzo);
                    DropDownZone.DataSource = dtzo;
                    DropDownZone.DataBind();
                    DropDownZone.DataTextField = "ast_loc_zone";
                    DropDownZone.DataValueField = "ast_loc_zone";
                    DropDownZone.DataBind();
                    DropDownZone.Items.Insert(0, new ListItem("ALL", "0"));
                }
                else
                {
                    string com3 = "select distinct  ast_loc_zone , ast_loc_zone from ast_loc (nolock) where ast_loc_state = '" + DropDownState.SelectedItem.Text + "'";

                    SqlDataAdapter adpt3 = new SqlDataAdapter(com3, con);
                    DataTable dt3 = new DataTable();
                    adpt3.Fill(dt3);
                    DropDownZone.DataSource = dt3;
                    DropDownZone.DataBind();
                    DropDownZone.DataTextField = "ast_loc_zone";
                    DropDownZone.DataValueField = "ast_loc_zone";
                    DropDownZone.DataBind();
                   // DropDownZone.Items.Insert(0, new ListItem("ALL", "0"));
                }

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

        protected void DropDownZone_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(connString);
                
                /*For Zone Dropdown Load*/
                if (DropDownZone.SelectedItem.Text == "ALL")
                {
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
                    
                    }
                else
                {
                    /*For State Dropdown Load*/
                    string com = "Select distinct Dense_rank() Over(order by ast_loc_state) as RowID, ast_loc_state as ast_lvl_ast_lvl from ast_loc (Nolock) where ast_loc_zone = '" + DropDownZone.SelectedItem.Text + "'";

                    SqlDataAdapter adpt = new SqlDataAdapter(com, con);
                    DataTable dt = new DataTable();
                    adpt.Fill(dt);
                    DropDownState.DataSource = dt;
                    DropDownState.DataBind();
                    DropDownState.DataTextField = "ast_lvl_ast_lvl";
                    DropDownState.DataValueField = "RowID";
                    DropDownState.DataBind();
                    DropDownState.Items.Insert(0, new ListItem("ALL", "0")); 
                }

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