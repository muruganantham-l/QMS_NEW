using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

using Microsoft.Reporting.WebForms;
namespace QMSBIL
{
    public partial class NBEInstallmentReport : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        string be_number;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                 
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

                        string com2 = " ;with yearlist as(   select year(getdate()) as year    union all    select yl.year - 1 as year    from yearlist yl    where yl.year - 1 >= YEAR(GetDate()) - 3) select year from yearlist order by year desc; ";

                        SqlDataAdapter adpt2 = new SqlDataAdapter(com2, con);
                        DataTable dt2 = new DataTable();
                        adpt2.Fill(dt2);
                        DropDownListReportYear.DataSource = dt2;
                        DropDownListReportYear.DataBind();
                        DropDownListReportYear.DataTextField = "year";
                        DropDownListReportYear.DataValueField = "year";
                        DropDownListReportYear.DataBind();
                        // DropDownState.Items.Insert(0, new ListItem("ALL", "0"));
                        DropDownListReportYear.Items.Insert(0, new ListItem("--Select--", "0"));

                        string com3 = " SELECT DATENAME(MONTH, DATEADD(MM, s.number, CONVERT(DATETIME, 0))) AS [MonthName], MONTH(DATEADD(MM, s.number, CONVERT(DATETIME, 0))) AS[MonthNumber] FROM master.dbo.spt_values (nolock) s WHERE [type] = 'P' AND s.number BETWEEN 0 AND 11 ORDER BY 2";

                        SqlDataAdapter adpt3 = new SqlDataAdapter(com3, con);
                        DataTable dt3 = new DataTable();
                        adpt3.Fill(dt3);
                        DropDownListReportMonth.DataSource = dt3;
                        DropDownListReportMonth.DataBind();
                        DropDownListReportMonth.DataTextField = "MonthName";
                        DropDownListReportMonth.DataValueField = "MonthNumber";
                        DropDownListReportMonth.DataBind();
                        // DropDownState.Items.Insert(0, new ListItem("ALL", "0"));
                        DropDownListReportMonth.Items.Insert(0, new ListItem("--Select--", "0"));

                        //MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");
                        //MyReportViewer.ServerReport.ReportPath = "/QMSTSD/sm_penalty_monthly_report";
                        //MyReportViewer.ServerReport.Refresh();
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
                if (string.IsNullOrWhiteSpace(be_number_txt.Text))
                {
                    //code here
                    be_number = "all";
                }
                else
                {
                    be_number = be_number_txt.Text;

                }

                MyReportViewer.ProcessingMode = ProcessingMode.Remote;

                //   ServerReport serverReport = MyReportViewer.ServerReport;

                //MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://chs015-2-3/ReportServer");
                MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");

                //http://localhost/reportserver


                MyReportViewer.ServerReport.ReportPath = "/QMS_BILL/NBE_Installment_Report";
                ReportParameter[] reportParameterCollection = new ReportParameter[8];       //Array size describes the number of paramaters.

                reportParameterCollection[0] = new ReportParameter();
                reportParameterCollection[0].Name = "month";                                            //Give Your Parameter Name
                reportParameterCollection[0].Values.Add(DropDownListReportMonth.SelectedValue.ToString());               //Pass Parametrs's value here.

                reportParameterCollection[1] = new ReportParameter();
                reportParameterCollection[1].Name = "year";                                            //Give Your Parameter Name
                reportParameterCollection[1].Values.Add(DropDownListReportYear.SelectedValue.ToString());               //Pass Parametrs's value here.

                reportParameterCollection[2] = new ReportParameter();
                reportParameterCollection[2].Name = "clinic_name";                                            //Give Your Parameter Name
                reportParameterCollection[2].Values.Add(DropDownclinicname.SelectedItem.Text);               //Pass Parametrs's value here.


                reportParameterCollection[3] = new ReportParameter();
                reportParameterCollection[3].Name = "clinic_category";                                            //Give Your Parameter Name
                reportParameterCollection[3].Values.Add(DropDownCliniccat.SelectedItem.Text);               //Pass Parametrs's value here.

                reportParameterCollection[4] = new ReportParameter();
                reportParameterCollection[4].Name = "district";                                            //Give Your Parameter Name
                reportParameterCollection[4].Values.Add(DropDownDistrict.SelectedItem.Text);                                     //Pass Parametrs's value here.

                reportParameterCollection[5] = new ReportParameter();
                reportParameterCollection[5].Name = "state";                                            //Give Your Parameter Name
                reportParameterCollection[5].Values.Add(DropDownState.SelectedItem.Text);                                     //Pass Parametrs's value here.

                reportParameterCollection[6] = new ReportParameter();
                reportParameterCollection[6].Name = "clinic_code";                                            //Give Your Parameter Name
                reportParameterCollection[6].Values.Add(clinic_code_txt.Text);                                     //Pass Parametrs's value here.

                reportParameterCollection[7] = new ReportParameter();
                reportParameterCollection[7].Name = "be_number";                                            //Give Your Parameter Name
                reportParameterCollection[7].Values.Add(be_number);                                     //Pass Parametrs's value here.


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