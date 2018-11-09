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
    public partial class DMStoCAMMS : System.Web.UI.Page
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
                }
            }
        }

        protected void UploadButton_Click(object sender, EventArgs e)
        {

            if (FileUpload1.HasFile)
            {
                string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                SqlConnection conn = null;
                conn = new SqlConnection(connString);
                conn.Open();

                FileUpload1.PostedFiles.Count();
                for (int i = 0; i < FileUpload1.PostedFiles.Count(); i++)
                {

                    //FileUpload1.PostedFiles[i].FileName.ToString();

                    string extension = FileUpload1.FileName.Substring(FileUpload1.FileName.LastIndexOf(".") + 1);
                    extension = FileUpload1.PostedFiles[i].FileName.Substring(FileUpload1.PostedFiles[i].FileName.LastIndexOf(".") + 1);

                    String test = FileUpload1.FileName.Substring(0, FileUpload1.FileName.LastIndexOf("."));
                    test = FileUpload1.PostedFiles[i].FileName.Substring(0, FileUpload1.PostedFiles[i].FileName.LastIndexOf("."));


                    //set the file type based on File Extension

                    byte[] data = FileUpload1.FileBytes;

                    using (Stream stream = new MemoryStream())
                    {
                        //read the file as stream
                        stream.Read(data, 0, data.Length);

                        BinaryReader br = new BinaryReader(FileUpload1.PostedFiles[i].InputStream);

                        byte[] buffer = br.ReadBytes(FileUpload1.PostedFiles[i].ContentLength);

                        data = buffer;

                        SqlCommand com = new SqlCommand();
                        com.Connection = conn;
                        //set parameters
                        SqlParameter p1 = new SqlParameter("@Name", SqlDbType.VarChar);
                        SqlParameter p2 = new SqlParameter("@FileType", SqlDbType.VarChar);
                        SqlParameter p3 = new SqlParameter("@Data", SqlDbType.VarBinary);
                        p1.Value = test + "-KEWPA." + extension;
                        p2.Value = test;
                        p3.Value = data;
                        com.Parameters.Add(p1);
                        com.Parameters.Add(p2);
                        com.Parameters.Add(p3);
                        //com.CommandText = "Insert into Files (Name,FileType,Data) VALUES (@Name,@FileType,@Data)";
                        com.CommandText = "insert into ast_ref (site_cd,mst_RowID,file_name,type,status,attachment,audit_user,audit_date,column1) select 'QMS',rowid,@Name ,'P','Saved',@Data,'App',getdate(), 'Native' from ast_mst (nolock) where site_cd = 'QMS' and ast_mst_asset_no = @FileType ";
                        //insert the file into database
                        com.ExecuteNonQuery();

                    }

                }

                conn.Close();
            }


        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string test = "123";//uppassword.Text;
            string type = "";//DropDownupload.SelectedItem.Text;
            string uniid = Guid.NewGuid().ToString();

            if (type != "--Select--")
            {
                if (test == "123")
                {
                    if (FileUpload1.HasFile)
                    {
                        try
                        {

                            string csvPath = Server.MapPath("~/App_Data/") + Path.GetFileName(FileUpload1.PostedFile.FileName);
                            FileUpload1.SaveAs(csvPath);
                            string filenames = FileUpload1.FileName.ToString();

                            DataTable dt = new DataTable();
                            dt.Columns.AddRange(new DataColumn[31] { new DataColumn("S/No", typeof(string)),
                                                new DataColumn("Package ID", typeof(string)),
                                                new DataColumn("DRN No.", typeof(string)),
                                                new DataColumn("Supplier ID", typeof(string)),
                                                new DataColumn("Supplier Name", typeof(string)),
                                                new DataColumn("Supplier Email ID", typeof(string)),
                                                new DataColumn("Supplier Address", typeof(string)),
                                                new DataColumn("Supplier Contact Person", typeof(string)),
                                                new DataColumn("Product Name", typeof(string)),
                                                new DataColumn("Product Manufacturer", typeof(string)),
                                                new DataColumn("Product Model", typeof(string)),
                                                new DataColumn("Product Details", typeof(string)),
                                                new DataColumn("Clinic ID", typeof(string)),
                                                new DataColumn("Clinic Name", typeof(string)),
                                                new DataColumn("Clinic Address", typeof(string)),
                                                new DataColumn("Clinic Type", typeof(string)),
                                                new DataColumn("Batch", typeof(string)),
                                                new DataColumn("Supplier Zone", typeof(string)),
                                                new DataColumn("PO No.", typeof(string)),
                                                new DataColumn("PO Date", typeof(string)),
                                                new DataColumn("BE No", typeof(string)),
                                                new DataColumn("BE Type", typeof(string)),
                                                new DataColumn("State", typeof(string)),
                                                new DataColumn("District", typeof(string)),
                                                new DataColumn("Delivery date and time", typeof(string)),
                                                new DataColumn("T&C Date and Time", typeof(string)),
                                                new DataColumn("Serial No.", typeof(string)),
                                                new DataColumn("Delivery Status", typeof(string)),
                                                new DataColumn("createdby", typeof(string)),
                                                new DataColumn("Createddate", typeof(string)),
                                                new DataColumn("GUID", typeof(string))});

                            dt.Columns["createdby"].DefaultValue = test;
                            dt.Columns["createddate"].DefaultValue = DateTime.Now;
                            dt.Columns["GUID"].DefaultValue = uniid;

                            string csvData = File.ReadAllText(csvPath);
                            csvData = csvData.Replace("\r", "");
                            csvData = csvData.Replace("\t", "");
                            csvData = csvData.Replace("\",\"", "|");
                            csvData = csvData.Replace("\n\"", "\r");
                            csvData = csvData.Replace("\n", "");

                            //csvData = csvData.Replace(System.Environment.NewLine, "");
                            int D = 0;
                            foreach (string row in csvData.Split('\r'))
                            {
                                if (!string.IsNullOrEmpty(row) && D >= 1)
                                {
                                    dt.Rows.Add();
                                    int i = 0;

                                    foreach (string cell in row.Split('|'))
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
                                    sqlBulkCopy.DestinationTableName = "dbo.Dms_camms_Asset_inbound_tab";
                                    //conn.Open();
                                    sqlBulkCopy.WriteToServer(dt);
                                    SqlCommand cmd1 = new SqlCommand();
                                    cmd1.Connection = conn;
                                    cmd1.CommandType = CommandType.Text;
                                    cmd1.CommandText = "exec Sp_inupd_Dms_camms_Asset_inbound_tab @var ";
                                    cmd1.Parameters.AddWithValue("@var", uniid);
                                    //cmd1.Parameters.AddWithValue("@var1", DateTime.Now);
                                    //cmd1.Parameters.AddWithValue("@var2", rowcount);
                                    //cmd1.Parameters.AddWithValue("@var3", test);
                                    //cmd1.Parameters.AddWithValue("@var4", filenames);
                                    cmd1.ExecuteNonQuery();
                                    conn.Close();
                                }
                            }
                            Label1.Visible = true;
                              Label1.Text = "File uploaded Successfully!";
                            //Approve.Visible = true;
                        }
                        catch (Exception ex)
                        {
                            Label1.Visible = true; 
                            Label1.Text = "The file could not be uploaded. The following error occured: " + ex.Message;
                           // Approve.Visible = false;
                        }
                    }
                    else
                    {
                        Label1.Visible = true; 
                        Label1.Text = "Please select the File and then Click Upload";
                        //Approve.Visible = false;
                    }

                }
                else
                {
                    Label1.Visible = true; 
                    Label1.Text = "Please enter a valid password !!!";
                    //Approve.Visible = false;

                }
            }
            else
            {
                Label1.Visible = true; 
                Label1.Text = "Please choose the Upload Type to Proceed !!!";
                //Approve.Visible = false;

            }
        }

    }
}