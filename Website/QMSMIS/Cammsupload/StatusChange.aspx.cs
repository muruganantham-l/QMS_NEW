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

namespace Cammsupload
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["name"] == null)
                {
                    Session["prevUrl"] = Request.Url;
                    Response.Redirect("~/login.aspx");

                }
                else
                {
                    string username = Session["name"].ToString();
                    this.Label8.Text = string.Format("Hi {0}", Session["name"].ToString() + "!");


                    /*For Clinic Cate Dropdown Load*/
                    DropDownList1.Items.Insert(0, new ListItem("Inclusion", "1"));
                    DropDownList1.Items.Insert(0, new ListItem("Exclusion", "2"));
                    DropDownList1.Items.Insert(0, new ListItem("--Select--", "0"));
                }
            }
        }

        protected void UploadButton_Click(object sender, EventArgs e)
        {
            string username = Session["name"].ToString(); 
            
            string test = username;
            string type = DropDownList1.SelectedItem.Text;
            string uniid = Guid.NewGuid().ToString();
            if (type != "--Select--")
            {
                
                    if (FileUpload1.HasFile)
                    {
                        try
                        {

                            string csvPath = Server.MapPath("~/App_Data/") + Path.GetFileName(FileUpload1.PostedFile.FileName);
                            FileUpload1.SaveAs(csvPath);
                            string filenames = FileUpload1.FileName.ToString();

                            DataTable dt = new DataTable();
                            dt.Columns.AddRange(new DataColumn[12] { new DataColumn("benumber", typeof(string)),
                                            new DataColumn("becategory", typeof(string)),
                                            new DataColumn("cliniccode",typeof(string)),
                                            new DataColumn("clinictype", typeof(string)),
                                            new DataColumn("District", typeof(string)),
                                            new DataColumn("Statecode", typeof(string)),
                                            new DataColumn("currentstatus", typeof(string)),
                                            new DataColumn("Newstatus", typeof(string)),
                                            new DataColumn("Reasonforchange", typeof(string)),
                                            new DataColumn("createdby", typeof(string)),
                                            new DataColumn("createddate", typeof(string)),
                                            new DataColumn("guid", typeof(string))});

                            dt.Columns["createdby"].DefaultValue = test;
                            dt.Columns["createddate"].DefaultValue = DateTime.Now;
                            dt.Columns["guid"].DefaultValue = uniid;

                            string csvData = File.ReadAllText(csvPath);
                            csvData = csvData.Replace("\n", "");
                            int D = 0;
                            foreach (string row in csvData.Split('\r'))
                            {
                                if (!string.IsNullOrEmpty(row) && D != 0)
                                {
                                    dt.Rows.Add();
                                    int i = 0;

                                    foreach (string cell in row.Split(','))
                                    {
                                        dt.Rows[dt.Rows.Count - 1][i] = cell;
                                        i++;
                                    }
                                }
                                D++;
                            }
                            int rowcount = dt.Rows.Count;
                            string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                            SqlConnection conn = null;
                            conn = new SqlConnection(connString);
                            conn.Open();
                            using (SqlCommand cmd = new SqlCommand())
                            {
                                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(conn))
                                {
                                    //Set the database table name
                                    sqlBulkCopy.DestinationTableName = "dbo.bedetail_to_camms_tab_tmp";
                                    //conn.Open();
                                    sqlBulkCopy.WriteToServer(dt);
                                    SqlCommand cmd1 = new SqlCommand();
                                    cmd1.Connection = conn;
                                    cmd1.CommandType = CommandType.Text;
                                    cmd1.CommandText = "exec save_audit_data @var ,@var1 ,@var2 ,@var3,@var4 ";
                                    cmd1.Parameters.AddWithValue("@var", uniid);
                                    cmd1.Parameters.AddWithValue("@var1", DateTime.Now);
                                    cmd1.Parameters.AddWithValue("@var2", rowcount);
                                    cmd1.Parameters.AddWithValue("@var3", test);
                                    cmd1.Parameters.AddWithValue("@var4", filenames);
                                    cmd1.ExecuteNonQuery();
                                    conn.Close();
                                }
                            }
                            Label10.Text = "File uploaded Successfully!";
                            Button2.Visible = true;
                        }
                        catch (Exception ex)
                        {
                            Label10.Text = "The file could not be uploaded. The following error occured: " + ex.Message;
                            Button2.Visible = false;
                        }
                    }
                    else
                    {
                        Label10.Text = "Please select the File and then Click Upload";
                        Button2.Visible = false;
                    }

               }
            else
            {
                Label10.Text = "Please choose the Upload Type to Proceed !!!";
                Button2.Visible = false;

            }
        }

        protected void DropDownupload_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string username = Session["name"].ToString();
            string test = username;
            string uniid = Guid.NewGuid().ToString();

               if (FileUpload1.HasFile)
                {
                    try
                    {

                        string csvPath = Server.MapPath("~/App_Data/") + Path.GetFileName(FileUpload1.PostedFile.FileName);
                        FileUpload1.SaveAs(csvPath);
                        string filenames = FileUpload1.FileName.ToString();

                        DataTable dt = new DataTable();
                        dt.Columns.AddRange(new DataColumn[20] { new DataColumn("BE Number", typeof(string)),
                                            new DataColumn("BE Code", typeof(string)),
                                            new DataColumn("BE General Name",typeof(string)),
                                            new DataColumn("BE Group", typeof(string)),
                                            new DataColumn("BE Conditional Status", typeof(string)),
                                            new DataColumn("BE Critical Factor", typeof(string)),
                                            new DataColumn("Cost Center", typeof(string)),
                                            new DataColumn("State", typeof(string)),
                                            new DataColumn("Circle", typeof(string)),
                                            new DataColumn("District", typeof(string)),
                                            new DataColumn("Clinic Category", typeof(string)),
                                            new DataColumn("Manufacturer", typeof(string)),
                                            new DataColumn("Model", typeof(string)),
                                            new DataColumn("Serial Number", typeof(string)),
                                            new DataColumn("BE Status", typeof(string)),
                                            new DataColumn("Clinic Code", typeof(string)),
                                            new DataColumn("Purchase Cost", typeof(string)),
                                            new DataColumn("createdby", typeof(string)),
                                            new DataColumn("createddate", typeof(string)),
                                            new DataColumn("guid", typeof(string))});

                        dt.Columns["createdby"].DefaultValue = test;
                        dt.Columns["createddate"].DefaultValue = DateTime.Now;
                        dt.Columns["guid"].DefaultValue = uniid ;

                        string csvData = File.ReadAllText(csvPath);
                        csvData = csvData.Replace("\n", "");
                        int D = 0;
                        foreach (string row in csvData.Split('\r'))
                        {
                            if (!string.IsNullOrEmpty(row) && D != 0)
                            {
                                dt.Rows.Add();
                                int i = 0;
                                
                                foreach (string cell in row.Split(','))
                                {
                                    dt.Rows[dt.Rows.Count - 1][i] = cell;
                                    i++;
                                }
                            }
                            D++;
                        }
                        int rowcount = dt.Rows.Count;
                        string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                        SqlConnection conn = null;
                        conn = new SqlConnection(connString);
                        conn.Open();
                        using (SqlCommand cmd = new SqlCommand())
                        {
                            using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(conn))
                            {
                                //Set the database table name
                                sqlBulkCopy.DestinationTableName = "dbo.bedetail_to_camms_add";
                                //conn.Open();
                                sqlBulkCopy.WriteToServer(dt);
                                SqlCommand cmd1 = new SqlCommand();
                                cmd1.Connection = conn;
					            cmd1.CommandType = CommandType.Text;
                                cmd1.CommandText = "exec save_audit_data @var ,@var1 ,@var2 ,@var3 ,@var4 ";
                                cmd1.Parameters.AddWithValue("@var", uniid);
                                cmd1.Parameters.AddWithValue("@var1", DateTime.Now);
                                cmd1.Parameters.AddWithValue("@var2", rowcount);
                                cmd1.Parameters.AddWithValue("@var3", test);
                                cmd1.Parameters.AddWithValue("@var4", filenames);
                                cmd1.ExecuteNonQuery();
                                conn.Close();
                            }
                        }
                        Label10.Text = "File uploaded Successfully!";
                        Button2.Visible = true;
                        Label1.Text = uniid;
                    }
                    catch (Exception ex)
                    {

                        Button2.Visible = false;
                        Label10.Text = "The file could not be uploaded. The following error occured: " + ex.Message;
                        
                    }
                }
                else
                {
                    Button2.Visible = false;
                    Label10.Text = "Please select the File and then Click Upload";
                    
                }

            
        }

        protected void Approve_Click(object sender, EventArgs e)
        {
            string username = Session["name"].ToString();
            string test = username;
            
                string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                SqlConnection conn = null;
                conn = new SqlConnection(connString);
                conn.Open();
                SqlCommand cmd1 = new SqlCommand();
                cmd1.Connection = conn;
                cmd1.CommandType = CommandType.Text;
                cmd1.CommandText = "exec upload_audit_data @var ,@var1 ";
                cmd1.Parameters.AddWithValue("@var", DateTime.Now);
                cmd1.Parameters.AddWithValue("@var1", test);
                cmd1.ExecuteNonQuery();
                conn.Close();
                Label10.Text = "Approved Successfully!!!";
            
        }

        protected void Create_Click(object sender, EventArgs e)
        {
            string username = Session["name"].ToString();

            string test = username;
            string id = Label1.Text;

           
                string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                SqlConnection conn = null;
                conn = new SqlConnection(connString);
                conn.Open();
                SqlCommand cmd1 = new SqlCommand();
                cmd1.Connection = conn;
                cmd1.CommandType = CommandType.Text;
                cmd1.CommandText = "exec SP_bedetail_to_camms_add @var ";
                cmd1.Parameters.AddWithValue("@var", id);
                cmd1.ExecuteNonQuery();
                conn.Close();
                Label10.Text = "Approved Successfully!!!";
            
        }
        
    }
}