using System;
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
    public partial class EquipmentMaintananceStatusReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // warenty_start_txt.Text = "11/11/2018";
            if (!IsPostBack)
            {
                if (Session["name"] == null)
                {

                    Response.Redirect("~/loginPage.aspx");

                }
                else
                {

                    print_btn.Visible = false;
                    generate_btn.Visible = true;

                    string username = Session["name"].ToString();
                    this.Label8.Text = string.Format("Hi {0}", Session["name"].ToString() + "!");

                    string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                    SqlConnection con = null;
                   
                    try
                    {
                        con = new SqlConnection(connString);

                        /*For State Dropdown Load*/
                        string com = "select distinct ast_det_varchar21 ,ast_det_varchar21 'display' from ast_det (nolock)  where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' order by ast_det_varchar21";

                        SqlDataAdapter adpt = new SqlDataAdapter(com, con);
                        DataTable dt = new DataTable();
                        adpt.Fill(dt);
                        DropDownbatch.DataSource = dt;
                        DropDownbatch.DataBind();
                        DropDownbatch.DataTextField = "display";
                        DropDownbatch.DataValueField = "ast_det_varchar21";
                        DropDownbatch.DataBind();
                        DropDownbatch.Items.Insert(0, new ListItem("--Select--", "0"));

                        /*For District Dropdown Load*/

                        //DropDownDistrict.Items.Insert(0, new ListItem("ALL", "0"));

                        ///*For Clinic Cate Dropdown Load*/
                        //DropDownCliniccat.Items.Insert(0, new ListItem("Dental Delivery Units", "1"));
                        //DropDownCliniccat.Items.Insert(0, new ListItem("CHAIRS, EXAMINATION/TREATMENT, DENTISTRY, SPECIALIST", "2"));
                        //DropDownCliniccat.Items.Insert(0, new ListItem("Chairs, Examination/Treatment, Dentistry", "3"));
                        //DropDownCliniccat.Items.Insert(0, new ListItem("ALL", "0"));
                       // MyReportViewer.ProcessingMode = ProcessingMode.Remote;
                       // MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://chs015-2-3/ReportServer");
                        MyReportViewer.ServerReport.ReportServerUrl = new Uri("http://Localhost/ReportServer");
                        MyReportViewer.ServerReport.ReportPath = "/Report Project1/EquipMainStatusRpt";
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
 

        protected void DropDownbatch_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownBECategory.Items.Clear();
            DropDownSuppliername.Items.Clear();
            DropDownmodel.Items.Clear();
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
         //   SqlConnection con1 = null;

            try
            {
               // DropDownBECategory.SelectedItem.Text = null;
                con = new SqlConnection(connString);

                /*For State Dropdown Load*/
                string com = "SELECT distinct ast_mst_asset_longdesc FROM ast_MST a(nolock) where exists (select ast_det_varchar21 from ast_det b (nolock) where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' and a.RowID = b.mst_RowID and ast_det_varchar21 = '" + DropDownbatch.SelectedItem.Text + "')"    ;
                //"select distinct ast_det_varchar21 ,ast_det_varchar21 'display' from ast_det (nolock)  where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' order by ast_det_varchar21";

                SqlDataAdapter adpt = new SqlDataAdapter(com, con);
                DataTable dt = new DataTable();
                adpt.Fill(dt);
                DropDownBECategory.DataSource = dt;
                DropDownBECategory.DataBind();
                DropDownBECategory.DataTextField = "ast_mst_asset_longdesc";
                DropDownBECategory.DataValueField = "ast_mst_asset_longdesc";
                DropDownBECategory.DataBind();
                DropDownBECategory.Items.Insert(0, new ListItem("--Select--", "0"));
                //DropDownbatch.Items.Insert(0, new ListItem("--Select--", "0"));

                /*For District Dropdown Load*/

                //DropDownDistrict.Items.Insert(0, new ListItem("ALL", "0"));

                ///*For Clinic Cate Dropdown Load*/
                //DropDownCliniccat.Items.Insert(0, new ListItem("Dental Delivery Units", "1"));
                //DropDownCliniccat.Items.Insert(0, new ListItem("CHAIRS, EXAMINATION/TREATMENT, DENTISTRY, SPECIALIST", "2"));
                //DropDownCliniccat.Items.Insert(0, new ListItem("Chairs, Examination/Treatment, Dentistry", "3"));
                //DropDownCliniccat.Items.Insert(0, new ListItem("ALL", "0"));
                //con1 = new SqlConnection(connString);

                /*For State Dropdown Load*/
                //string com1 =// "SELECT distinct ast_mst_asset_longdesc ast_det_varchar16 FROM ast_MST a(nolock) where exists (select ast_det_varchar21 from ast_det b (nolock) where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' and a.RowID = b.mst_RowID and ast_det_varchar21 = '" + DropDownbatch.SelectedItem.Text + "')";
                //"select distinct ast_det_varchar16 ast_det_varchar16 from ast_det b (nolock) where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' and ast_det_varchar16 is not null and ast_det_varchar21 = '" + DropDownbatch.SelectedItem.Text + "' and  exists ( select ''   from ast_mst a (nolock)    where a.RowID = b.mst_RowID    and a.ast_mst_asset_longdesc = '" + DropDownBECategory.SelectedItem.Text + "' 	)	";
                // "SELECT distinct ast_mst_asset_longdesc FROM ast_MST a(nolock) where exists (select ast_det_varchar21 from ast_det b (nolock) where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' and a.RowID = b.mst_RowID and ast_det_varchar21 = '" + DropDownbatch.SelectedItem.Text + "')";

                //"select distinct ast_det_varchar21 ,ast_det_varchar21 'display' from ast_det (nolock)  where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' order by ast_det_varchar21";

                //SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                //DataTable dt1 = new DataTable();
                //adpt1.Fill(dt1);
                //DropDownSuppliername.DataSource = dt1;
                //DropDownSuppliername.DataBind();
                //DropDownSuppliername.DataTextField = "ast_det_varchar16";
                //DropDownSuppliername.DataValueField = "ast_det_varchar16";
                //DropDownSuppliername.DataBind();
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
              //  con1.Close();
            }
        }

        protected void DropDownBECategory_SelectedIndexChanged(object sender, EventArgs e)
        {

            DropDownSuppliername.Items.Clear();
            DropDownmodel.Items.Clear();
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            //   SqlConnection con1 = null;

            try
            {
                // DropDownBECategory.SelectedItem.Text = null;
                con = new SqlConnection(connString);

                string com1 =// "SELECT distinct ast_mst_asset_longdesc ast_det_varchar16 FROM ast_MST a(nolock) where exists (select ast_det_varchar21 from ast_det b (nolock) where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' and a.RowID = b.mst_RowID and ast_det_varchar21 = '" + DropDownbatch.SelectedItem.Text + "')";
               "select distinct ast_det_varchar16 ast_det_varchar16 from ast_det b (nolock) where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' and ast_det_varchar16 is not null and ast_det_varchar21 = '" + DropDownbatch.SelectedItem.Text + "' and  exists ( select ''   from ast_mst a (nolock)    where a.RowID = b.mst_RowID    and a.ast_mst_asset_longdesc = '" + DropDownBECategory.SelectedItem.Text + "' 	)	";
            // "SELECT distinct ast_mst_asset_longdesc FROM ast_MST a(nolock) where exists (select ast_det_varchar21 from ast_det b (nolock) where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' and a.RowID = b.mst_RowID and ast_det_varchar21 = '" + DropDownbatch.SelectedItem.Text + "')";

            //"select distinct ast_det_varchar21 ,ast_det_varchar21 'display' from ast_det (nolock)  where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' order by ast_det_varchar21";

            SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
            DataTable dt1 = new DataTable();
            adpt1.Fill(dt1);
                DropDownSuppliername.DataSource = dt1;
                DropDownSuppliername.DataBind();
                DropDownSuppliername.DataTextField = "ast_det_varchar16";
                DropDownSuppliername.DataValueField = "ast_det_varchar16";
                DropDownSuppliername.DataBind();
                DropDownSuppliername.Items.Insert(0, new ListItem("--Select--", "0"));
                //DropDownmodel.DataSource = dt1;
                //DropDownmodel.DataBind();
                //DropDownmodel.DataTextField = "ast_det_modelno";
                //DropDownmodel.DataValueField = "ast_det_modelno";
                //DropDownmodel.DataBind();


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
              //  con1.Close();
            }
        }

        //protected void DropDownSuppliername_SelectedIndexChanged(object sender, EventArgs e)
        //{
            //select ast_det_modelno	from ast_det b (nolock)	where ast_det_varchar21 is not null 	and ast_det_varchar21 != 'NA'    and ast_det_varchar21 '" + DropDownbatch.SelectedItem.Text + "' 	AND ast_det_varchar16 = '" + DropDownbatch.SelectedItem.Text + "' 	and exists (	select '' from ast_mst a (nolock)	where a.RowID = b.mst_RowID and a.ast_mst_asset_longdesc = '" + DropDownbatch.SelectedItem.Text + "' 	)	

       // }

        protected void DropDownSuppliername_SelectedIndexChanged1(object sender, EventArgs e)
        {

           // Response.Write("test");
            DropDownmodel.Items.Clear();
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            //   SqlConnection con1 = null;

            try
            {
                // DropDownBECategory.SelectedItem.Text = null;
                con = new SqlConnection(connString);

                string com1 =// "SELECT distinct ast_mst_asset_longdesc ast_det_varchar16 FROM ast_MST a(nolock) where exists (select ast_det_varchar21 from ast_det b (nolock) where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' and a.RowID = b.mst_RowID and ast_det_varchar21 = '" + DropDownbatch.SelectedItem.Text + "')";
                              "select distinct ast_det_mfg_cd from ast_det b (nolock)	where ast_det_varchar21 is not null 	and ast_det_varchar21 != 'NA'    and ast_det_varchar21 ='" + DropDownbatch.SelectedItem.Text + "' 	AND ast_det_varchar16 = '" + DropDownSuppliername.SelectedItem.Text + "' and exists (	select '' from ast_mst a (nolock)	where a.RowID = b.mst_RowID and a.ast_mst_asset_longdesc = '" + DropDownBECategory.SelectedItem.Text + "' 	)	";
             //"select 'ast_det_modelno' ast_det_modelno";
                // "SELECT distinct ast_mst_asset_longdesc FROM ast_MST a(nolock) where exists (select ast_det_varchar21 from ast_det b (nolock) where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' and a.RowID = b.mst_RowID and ast_det_varchar21 = '" + DropDownbatch.SelectedItem.Text + "')";

                //"select distinct ast_det_varchar21 ,ast_det_varchar21 'display' from ast_det (nolock)  where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' order by ast_det_varchar21";

                SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                DataTable dt1 = new DataTable();
                adpt1.Fill(dt1);
                DropDownManufacture.DataSource = dt1;
                DropDownManufacture.DataBind();
                DropDownManufacture.DataTextField = "ast_det_mfg_cd";
                DropDownManufacture.DataValueField = "ast_det_mfg_cd";
                DropDownManufacture.DataBind();
                DropDownManufacture.Items.Insert(0, new ListItem("--Select--", "0"));

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
                //  con1.Close();
            }   
        }

        protected void DropDownmodel_SelectedIndexChanged(object sender, EventArgs e)
        {

            //  Response.Write("test");
            warenty_start_txt.Text = null;// "2018-01-01";// "01/01/2018";// "2018-01-01";
            warenty_end_txt.Text = null;// "2018-01-01";
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con1 = null;

            try
            {
                // DropDownBECategory.SelectedItem.Text = null;
                con1 = new SqlConnection(connString);

                DataTable dt = new DataTable();
            con1.Open();
            SqlDataReader myReader = null;
            SqlCommand myCommand = new SqlCommand("select top 1 convert(varchar(10),ast_det_datetime1 ,103) ast_det_datetime1,convert(varchar(10),ast_det_warranty_date ,103) ast_det_warranty_date	from ast_det b (nolock)	where ast_det_varchar21 is not null 	and ast_det_varchar21 != 'NA'    and ast_det_varchar21 ='" + DropDownbatch.SelectedItem.Text + "' 	AND ast_det_varchar16 = '" + DropDownSuppliername.SelectedItem.Text + "'and ast_det_modelno = '" + DropDownmodel.SelectedItem.Text + "' and exists (	select '' from ast_mst a (nolock)	where a.RowID = b.mst_RowID and a.ast_mst_asset_longdesc = '" + DropDownBECategory.SelectedItem.Text + "' 	)	", con1);
                
                myReader = myCommand.ExecuteReader();

                while (myReader.Read())
                {
                    //Response.Write((myReader["ast_det_datetime1"].ToString().Substring(0, 10)));
                    //TextBox1.Text = (myReader["ast_det_datetime1"].ToString().Substring(0,10));
                    //warenty_start_txt.Text = DateTime.ParseExact((myReader["ast_det_datetime1"].ToString().Substring(0, 10)), "dd/MM/yyyy",
                    //                               CultureInfo.InvariantCulture).ToString("yyyy-MM-dd"); //;
                    //warenty_end_txt.Text = DateTime.ParseExact((myReader["ast_det_warranty_date"].ToString().Substring(0, 10)), "dd/MM/yyyy",
                    //                               CultureInfo.InvariantCulture).ToString("yyyy-MM-dd");
                    warenty_start_txt.Text = myReader["ast_det_datetime1"].ToString() ;
                    warenty_end_txt.Text = myReader["ast_det_warranty_date"].ToString() ;


                    //(myReader["ast_det_warranty_date"].ToString().Substring(0, 10));

                }
               // string s = dateTime.ToString("dd/mm/yyyy", CultureInfo.InvariantCulture);
                //warenty_start_txt.Text = S;
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
                
             con1.Close();
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


                MyReportViewer.ServerReport.ReportPath = "/Report Project1/EquipMainStatusRpt";
                    ReportParameter[] reportParameterCollection = new ReportParameter[7];       //Array size describes the number of paramaters.

                    reportParameterCollection[0] = new ReportParameter();
                    reportParameterCollection[0].Name = "be_category";                                            //Give Your Parameter Name
                    reportParameterCollection[0].Values.Add(DropDownBECategory.SelectedItem.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[1] = new ReportParameter();
                    reportParameterCollection[1].Name = "war_start_date";                                            //Give Your Parameter Name
                    reportParameterCollection[1].Values.Add(warenty_start_txt.Text);               //Pass Parametrs's value here.


                    reportParameterCollection[2] = new ReportParameter();
                    reportParameterCollection[2].Name = "war_end_date";                                            //Give Your Parameter Name
                    reportParameterCollection[2].Values.Add(warenty_end_txt.Text);               //Pass Parametrs's value here.

                    reportParameterCollection[3] = new ReportParameter();
                    reportParameterCollection[3].Name = "manufacture";                                            //Give Your Parameter Name
                    reportParameterCollection[3].Values.Add(DropDownManufacture.SelectedItem.Text);                                     //Pass Parametrs's value here.

                reportParameterCollection[4] = new ReportParameter();
                reportParameterCollection[4].Name = "model";                                            //Give Your Parameter Name
                reportParameterCollection[4].Values.Add(DropDownmodel.SelectedItem.Text);                                     //Pass Parametrs's value here.

                reportParameterCollection[5] = new ReportParameter();
                reportParameterCollection[5].Name = "batch";                                            //Give Your Parameter Name
                reportParameterCollection[5].Values.Add(DropDownbatch.SelectedItem.Text);                                     //Pass Parametrs's value here.

                reportParameterCollection[6] = new ReportParameter();
                reportParameterCollection[6].Name = "supp_name";                                            //Give Your Parameter Name
                reportParameterCollection[6].Values.Add(DropDownSuppliername.SelectedItem.Text);                                     //Pass Parametrs's value here.

                MyReportViewer.ServerReport.SetParameters(reportParameterCollection);

                    MyReportViewer.ServerReport.Refresh();

               



            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }

        protected void DropDownManufacture_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Response.Write("test");
            DropDownmodel.Items.Clear();
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            //   SqlConnection con1 = null;

            try
            {
                // DropDownBECategory.SelectedItem.Text = null;
                con = new SqlConnection(connString);

                string com1 =// "SELECT distinct ast_mst_asset_longdesc ast_det_varchar16 FROM ast_MST a(nolock) where exists (select ast_det_varchar21 from ast_det b (nolock) where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' and a.RowID = b.mst_RowID and ast_det_varchar21 = '" + DropDownbatch.SelectedItem.Text + "')";
                              "select distinct ast_det_modelno	from ast_det b (nolock)	where ast_det_varchar21 is not null 	and ast_det_varchar21 != 'NA'    and ast_det_varchar21 ='" + DropDownbatch.SelectedItem.Text + "' 	AND ast_det_varchar16 = '" + DropDownSuppliername.SelectedItem.Text + "' and ast_det_mfg_cd = '"+DropDownManufacture.SelectedItem.Text+"' and exists (	select '' from ast_mst a (nolock)	where a.RowID = b.mst_RowID and a.ast_mst_asset_longdesc = '" + DropDownBECategory.SelectedItem.Text + "' 	)	";
                //"select 'ast_det_modelno' ast_det_modelno";
                // "SELECT distinct ast_mst_asset_longdesc FROM ast_MST a(nolock) where exists (select ast_det_varchar21 from ast_det b (nolock) where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' and a.RowID = b.mst_RowID and ast_det_varchar21 = '" + DropDownbatch.SelectedItem.Text + "')";

                //"select distinct ast_det_varchar21 ,ast_det_varchar21 'display' from ast_det (nolock)  where ast_det_varchar21 is not null and ast_det_varchar21 != 'NA' order by ast_det_varchar21";

                SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                DataTable dt1 = new DataTable();
                adpt1.Fill(dt1);
                DropDownmodel.DataSource = dt1;
                DropDownmodel.DataBind();
                DropDownmodel.DataTextField = "ast_det_modelno";
                DropDownmodel.DataValueField = "ast_det_modelno";
                DropDownmodel.DataBind();
                DropDownmodel.Items.Insert(0, new ListItem("--Select--", "0"));

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
                //  con1.Close();
            }

        }

        protected void generate_btn_Click(object sender, EventArgs e)
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connString))
                {
                    //using (SqlCommand cmd = new SqlCommand("sp_kpi_penalty_report_out_qms", con))
                    //{
                        SqlCommand cmd = new SqlCommand("exec sp_kpi_penalty_report_out_qms '" + "all"+ "','" +
                  "all" + "','" + "all" + "','" + "all" + "','" +
                    warenty_start_txt.Text + "','" + warenty_end_txt.Text + "' ,'" + "all" + "' ,'" + "0x0a" + "' ,'" + DropDownBECategory.SelectedItem.Text + "','" + DropDownmodel.SelectedItem.Text + "','" + DropDownbatch.SelectedItem.Text + "','" + DropDownSuppliername.SelectedItem.Text + "','" + DropDownManufacture.SelectedItem.Text + "' ", con);
                        cmd.CommandTimeout = 1000;

                        //cmd.CommandTimeout = 900;
                        //cmd.CommandType = CommandType.StoredProcedure;
                        //cmd.Parameters.AddWithValue("@statename", "all");
                        //cmd.Parameters.AddWithValue("@district", "all");
                        //cmd.Parameters.AddWithValue("@zone", "all");
                        //cmd.Parameters.AddWithValue("@reporttype", "all");

                        //cmd.Parameters.AddWithValue("@periodfrom", SqlDbType.Date).Value = warenty_start_txt.Text;
                        //cmd.Parameters.AddWithValue("@periodto", SqlDbType.Date).Value = warenty_end_txt.Text;
                        ////cmd.Parameters.AddWithValue("@periodfrom", DateTime.Parse(warenty_start_txt.Text));
                        ////cmd.Parameters.AddWithValue("@periodto", DateTime.Parse(warenty_end_txt.Text));
                        //cmd.Parameters.AddWithValue("@ownership", "all");
                        //cmd.Parameters.AddWithValue("@GUID", "0x0a");

                        //cmd.Parameters.AddWithValue("@be_category", DropDownBECategory.SelectedItem.Text);
                        //cmd.Parameters.AddWithValue("@model", DropDownmodel.SelectedItem.Text);
                        //cmd.Parameters.AddWithValue("@batch", DropDownbatch.SelectedItem.Text);
                        //cmd.Parameters.AddWithValue("@supp_name", DropDownSuppliername.SelectedItem.Text);
                        //cmd.Parameters.AddWithValue("@manufacture", DropDownManufacture.SelectedItem.Text);

                        //cmd.Parameters.AddWithValue("@LastName", txtlastname);
                        con.Open();
                        cmd.ExecuteNonQuery();




                    //}
                }
            }
            catch (SqlException ex)
            {
                lblError.Text = ex.Message;

                if (lblError.Text == "Report Generated")
                {
                    print_btn.Visible = true;
                    generate_btn.Visible = false;
                }
            }
        }
    }
}