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
    public partial class MultipleDocUpload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["name"] == null)
            {

                Response.Redirect("~/login.aspx");

            }
            else
            {
                string username = Session["name"].ToString();
                Label1.Visible = false;
                Label1.Text = username;
            }
            if (!IsPostBack)
            {
                DropDownupload.Items.Insert(0, new ListItem("Wrong Category", "5"));
                DropDownupload.Items.Insert(0, new ListItem("Relocation Document", "4"));
                DropDownupload.Items.Insert(0, new ListItem("BER Document", "3"));
                DropDownupload.Items.Insert(0, new ListItem("KEWPA File", "1"));
                DropDownupload.Items.Insert(0, new ListItem("T&C Certificate", "2"));
                DropDownupload.Items.Insert(0, new ListItem("--Select--", "0"));
            }

        }

        protected void DropDownupload_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (DropDownupload.SelectedItem.Text != "--Select--")
            {

                if (FileUpload1.HasFile)
                {

                    try
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
                                p1.Value = DropDownupload.SelectedItem.Text + "." + extension;
                                p2.Value = test;
                                p3.Value = data;
                                com.Parameters.Add(p1);
                                com.Parameters.Add(p2);
                                com.Parameters.Add(p3);


                                string csvPath = Server.MapPath("~/App_Data/") + Path.GetFileName(FileUpload2.PostedFile.FileName);
                                FileUpload2.SaveAs(csvPath);
                                string filenames = FileUpload2.FileName.ToString();

                                DataTable dt = new DataTable();

                                dt.Columns.AddRange(new DataColumn[1] { new DataColumn("BEnumber", typeof(string)) });
                                
                                string csvData = File.ReadAllText(csvPath);
                                csvData = csvData.Replace("\n", "");

                                //csvData = csvData.Replace(System.Environment.NewLine, "");
                                int D = 0;
                                foreach (string row in csvData.Split('\r'))
                                {
                                    if (!string.IsNullOrEmpty(row) && D >= 1)
                                    {
                                        dt.Rows.Add();
                                        int j = 0;

                                        foreach (string cell in row.Split(','))
                                        {
                                            dt.Rows[dt.Rows.Count - 1][j] = cell;
                                            j++;
                                        }
                                     }
                                    D++;
                                }
                                int rowcount = dt.Rows.Count;

                                //conn.Open();
                                using (SqlCommand cmd = new SqlCommand())
                                {
                                    using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(conn))
                                    {
                                        //Set the database table name
                                        sqlBulkCopy.DestinationTableName = "dbo.file_data";
                                        //conn.Open();
                                        sqlBulkCopy.WriteToServer(dt);
                                    
                                //com.CommandText = "Insert into Files (Name,FileType,Data) VALUES (@Name,@FileType,@Data)";
                                com.CommandText = "insert into ast_ref (site_cd,mst_RowID,file_name,type,status,attachment,audit_user,audit_date,column1) select 'QMS',rowid,ast_mst_asset_no+' - '+@Name ,'A','Saved',@Data,'App',getdate(), 'Native' from ast_mst (nolock) where site_cd = 'QMS' and ast_mst_asset_no in (Select BEnumber from file_data (nolock)) ";
                                //insert the file into database
                                com.ExecuteNonQuery();

                                 SqlCommand cmd1 = new SqlCommand();
                                cmd1.Connection = conn;
                                cmd1.CommandType = CommandType.Text;
                                cmd1.CommandText = "Delete from file_data";
                                cmd1.ExecuteNonQuery();
                                conn.Close();
                                    }
                                }
                            }

                            Label1.Visible = true;
                            Label1.ForeColor = System.Drawing.ColorTranslator.FromHtml("#008000");
                            Label1.Text = "File uploaded Successfully!!!";

                        }

                        conn.Close();

                    }
                    catch (Exception ex)
                    {
                        Label1.Visible = true;
                        Label1.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FF0000");
                        Label1.Text = "The file could not be uploaded. The following error occured: " + ex.Message;
                        // Approve.Visible = false;
                    }
                }

                else
                {
                    Label1.Visible = true;
                    Label1.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FF0000");
                    Label1.Text = "Please select the File and then Click Upload!!!";

                }
            }
            else
            {
                Label1.Visible = true;
                Label1.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FF0000");
                Label1.Text = "Please select the File Type!!!";
            }

        }
    }
}