using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Security.Principal;
using System.Text;

namespace AgingReport
{
    public partial class UploadDoc : System.Web.UI.Page
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
                        DropDownState.Items.Insert(0, new ListItem("--Select--", "0"));


                        DropDownDistrict.Items.Insert(0, new ListItem("--Select--", "0"));

                        DropDownDocType.Items.Insert(0, new ListItem("PPM B03 & CHECKLIST", "1"));
                      //  DropDownDocType.Items.Insert(0, new ListItem("PPM CHECKLIST", "2"));//commented by muruganantham
                        DropDownDocType.Items.Insert(0, new ListItem("--Select--", "0"));

                         freq_DropDownList1.Items.Insert(0, new ListItem("--Select--", "0"));
                        freq_DropDownList1.Items.Insert(1, new ListItem("1", "1"));
                        freq_DropDownList1.Items.Insert(2, new ListItem("2", "2"));



                        string com1 = "WITH Years(No , Year) AS  ( SELECT 1, 2013 year UNION ALL  SELECT No+1,year+1 FROM  Years AS d  where   Year < Year(getdate())) SELECT No , Year FROM Years order by year desc";

                        SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con);
                        DataTable dt1 = new DataTable();
                        adpt1.Fill(dt1);
                        DropDownYear.DataSource = dt1;
                        DropDownYear.DataBind();
                        DropDownYear.DataTextField = "Year";
                        DropDownYear.DataValueField = "No";
                        DropDownYear.DataBind();
                        DropDownYear.Items.Insert(0, new ListItem("--Select--", "0"));

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
                DropDownDistrict.Items.Insert(0, new ListItem("--Select--", "0"));

            }
            catch (Exception ex)
            {
                //log error 
                //display friendly error to user
                string msg = " Upload Error: ";
                msg += ex.Message;


            }
            finally
            {
                con.Close();
            }
            Label5.Text = "";  
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
        protected void DropDownDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label5.Text = "";          
        }

        protected void Button1_Click(object sender, EventArgs e)
        {


            string test         = Session["name"].ToString() ; // User.Identity.Name.ToString();
            string year         = DropDownYear.SelectedItem.Text;
            string DocumentType = DropDownDocType.SelectedItem.Text;
            string District     = DropDownDistrict.SelectedItem.Text;
            string State        = DropDownState.SelectedItem.Text;
            //added by muruganantham

            string BeNumValid = Isbenumbervalid();

            //Response.Write(BeNumValid);

            //Isbenumbervalid

            string path =  year + "/" + State + "/" + District + "/" + DocumentType;

            if (State != "--Select--")
            {
             if (District != "--Select--")
            {
                 
                 if (DocumentType != "--Select--")
            {

            if (year != "--Select--")
            {

                            if (BeNumValid == "false")
                            {
                                // Response.Write(BeNumValid);


                                Label5.ForeColor = System.Drawing.Color.Red;
                                Label5.Visible = true;
                                Label5.Text = " Please enter valid BE Number";
                                return;
                            }

                            if (freq_DropDownList1.SelectedItem.Text == "--Select--")
                            {
                                Label5.ForeColor = System.Drawing.Color.Red;
                                Label5.Visible = true;
                                Label5.Text = " Please select Frequency";
                                return;
                            }
                          


            if (Files.HasFile)
                {
                    string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                    SqlConnection con = null;
                    con = new SqlConnection(connString);
                    con.Open();
                    try
                    {

                        //String currentDir = @"C:\Users\Administrator\Documents\Visual Studio 2012\Projects\AgingReport\AgingReport\App_Data";

                        String currentDir = "~/App_Data";

                        string[] subDirs = path.Split('/');

                        String physicalpath = "";
                        String virtualpath = "";

                        foreach (string subDir in subDirs)
                        {

                            physicalpath = physicalpath + "\\" + subDir;

                            virtualpath = Server.MapPath(currentDir + physicalpath);

                            bool folderExists = Directory.Exists(virtualpath);

                            if (!folderExists)
                            {
                                Directory.CreateDirectory(virtualpath);
                            }
                        }

                        for (int i = 0; i < Files.PostedFiles.Count(); i++)
                        {

                            string[] validFileTypes = { "png", "jpg", "jpeg", "pdf" };

                            string extension = Files.FileName.Substring(Files.FileName.LastIndexOf(".") + 1);
                            extension = Files.PostedFiles[i].FileName.Substring(Files.PostedFiles[i].FileName.LastIndexOf(".") + 1);

                            string filenames = Files.PostedFiles[i].FileName.ToString();

                            bool isValidFile = false;

                            for (int j = 0; j < validFileTypes.Length; j++)
                            {
                                if (extension == validFileTypes[j])
                                {
                                    isValidFile = true;
                                    break;
                                }
                            }

                            if (isValidFile)
                            {
                                            string csvPath = Server.MapPath("~/App_Data/" + path) + "/" + benumber_txtbox.Text+'_'+freq_DropDownList1.SelectedValue+'.'+ extension;
                                                //Path.GetFileName(Files.PostedFiles[i].FileName);//commented by muruganantham
                                Files.PostedFiles[i].SaveAs(csvPath);

                                            filenames = benumber_txtbox.Text+"_"+ freq_DropDownList1.SelectedValue;//added by muruganantham

                                          //  Response.Write(virtualpath);

                                SqlCommand cmd = new SqlCommand("insert into Doc_upload_detail (Year,DocumentType,State,District,Filename,Folder,Uploadedby,filetype) " +
                                    "Select '" + year + "','" + DocumentType + "','" + State + "','" + District + "','" + filenames+'.'+extension + "','" + path + "/" + filenames + "','" + test + "','" + extension + "'", con);
                                cmd.CommandTimeout = 1000;
                                cmd.ExecuteNonQuery();

                                Label5.ForeColor = System.Drawing.Color.Green;
                                Label5.Visible = true;
                                Label5.Text = "File Uploaded Successfully!!!";

                            }
                            if (!isValidFile)
                            {
                                Label5.ForeColor = System.Drawing.Color.Red;
                                Label5.Visible = true;
                                Label5.Text = " Invalid File. Please upload a File with extension " + string.Join(", ", validFileTypes)+".";
                            }

                        }

                    }

                    catch (Exception ex)
                    {
                        //log error 
                        //display friendly error to user
                        string msg = " Upload Error: ";
                        msg += ex.Message;

                        // ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('" + path + " " + msg + "')</script>"); 

                        Label5.Visible = true;
                        Label5.Text = msg;

                    }
                    finally
                    {
                        con.Close();
                    }
                }
                else
                {
                    Label5.ForeColor = System.Drawing.Color.Red;
                    Label5.Visible = true;
                    Label5.Text = "Please select the File and then Click Upload";
                }
            }
            else
            {
                Label5.ForeColor = System.Drawing.Color.Red;
                Label5.Visible = true;
                Label5.Text = "Please select the Year and then Proceed";
            }
                     }
            else
            {
                Label5.ForeColor = System.Drawing.Color.Red;
                Label5.Visible = true;
                Label5.Text = "Please select the Document Type and then Proceed";
            }
                 }
            else
            {
                Label5.ForeColor = System.Drawing.Color.Red;
                Label5.Visible = true;
                Label5.Text = "Please select the District and then Proceed";
            }
            }
            else
            {
                Label5.ForeColor = System.Drawing.Color.Red;
                Label5.Visible = true;
                Label5.Text = "Please select the State and then Proceed";
            }
        }

        protected void DropDownYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label5.Text = ""; 
        }

        protected void DropDownDocType_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label5.Text = ""; 
        }

        protected string Isbenumbervalid()
        {

            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connString);
            SqlCommand cmd = new SqlCommand();
            object returnValue;

            cmd.CommandText = "select count(1) from ast_mst where ast_mst_asset_no=@ast_no";
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ast_no", benumber_txtbox.Text);
            cmd.Connection = con;

            con.Open();
            returnValue = cmd.ExecuteScalar();
            con.Close();

            if (Convert.ToInt16(returnValue) > 0)
            {

                return "true";
                //Label5.ForeColor = System.Drawing.Color.Red;
                //Label5.Visible = false;
                //    Label5.Text = "Please enter valid BE Number";

            }
            //Response.Write("Correct");
            else
            {
                //Label5.ForeColor = System.Drawing.Color.Red;
                //Label5.Visible = true;
                //Label5.Text = "Please enter valid BE Number";
                return "false";

            }
        }
    }
}