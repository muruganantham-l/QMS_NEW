using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cammsupload
{
    public partial class imageupload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

           // string username = Session["name"].ToString();
           // Label1.Visible = true;
          //  Label1.Text = username;

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

                    DropDownupload.Items.Insert(0, new ListItem("Wrong Category", "6"));
                    DropDownupload.Items.Insert(0, new ListItem("QA Certificate", "5"));
                    DropDownupload.Items.Insert(0, new ListItem("Relocation Document", "4"));
                    DropDownupload.Items.Insert(0, new ListItem("BER Document", "3"));
                    DropDownupload.Items.Insert(0, new ListItem("T&C Certificate", "2"));
                    DropDownupload.Items.Insert(0, new ListItem("KEWPA File", "1"));
                    DropDownupload.Items.Insert(0, new ListItem("--Select--", "0"));
                }
            }
              /*  if (Session["name"].ToString() == null)
                {
                    Response.Redirect("login.aspx");
                }*/

                /*
                 else
                {
                    string username = Session["name"].ToString();
                }
                  */
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            string username = Session["name"].ToString(); 

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
                                p1.Value = test +"-"+ DropDownupload.SelectedItem.Text + "." + extension;
                                p2.Value = test;
                                p3.Value = data;
                                com.Parameters.Add(p1);
                                com.Parameters.Add(p2);
                                com.Parameters.Add(p3);
                                //com.CommandText = "Insert into Files (Name,FileType,Data) VALUES (@Name,@FileType,@Data)";
                                com.CommandText = "insert into ast_ref (site_cd,mst_RowID,file_name,type,status,attachment,audit_user,audit_date,column1) select 'QMS',rowid,@Name ,'A','Saved',@Data,'" + username + "',getdate(), 'Native' from ast_mst (nolock) where site_cd = 'QMS' and ast_mst_asset_no = @FileType ";
                                //insert the file into database
                                com.ExecuteNonQuery();

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
        protected void DropDownupload_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
       
       /* protected void Button1_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                if (FileUpload1.PostedFile.ContentType == "application/vnd.ms-excel" || FileUpload1.PostedFile.ContentType == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
                {
                    string fileName = Path.Combine(Server.MapPath("~/localization"), Guid.NewGuid().ToString() + Path.GetExtension(FileUpload1.PostedFile.FileName));
                    FileUpload1.PostedFile.SaveAs(fileName);

                    string conString = "";
                    string ext = Path.GetExtension(FileUpload1.PostedFile.FileName);
                    if (ext.ToLower() == ".xls")
                    {
                        conString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileName + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                    }
                    else if (ext.ToLower() == ".xlsx")
                    {
                        conString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileName + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                    }
                    string query = "Select * from [Sheet1$]";
                    OleDbConnection con = new OleDbConnection(conString);
                    OleDbDataAdapter data = new OleDbDataAdapter(query, con);
                    data.Fill(dt);
                    int i = 0;
                    FileUpload file = new FileUpload();
                    for (i = 0; i < dt.Rows.Count; i++)
                    {
                        string name = dt.Rows[i]["name"].ToString();
                        string email = dt.Rows[i]["email"].ToString();
                        string pass = dt.Rows[i]["Password"].ToString();
                        string mobile = dt.Rows[i]["mobile"].ToString();
                        string state = dt.Rows[i]["state"].ToString();
                        string city = dt.Rows[i]["city"].ToString();
                        string photo = dt.Rows[i]["Photo"].ToString();

                        string[] pathArr = photo.Split('\\');
                        string[] fileArr = pathArr.Last().Split('.');
                        string fName = fileArr[0].ToString();
                        Random rnd = new Random();
                        string fn = fName + "_" + rnd.Next(111, 999) + "_" + rnd.Next(111, 999) + ".jpg";
                        string path = "~/photo/" + fn;
                        string pat = Server.MapPath(path);
                        System.Drawing.Image image = System.Drawing.Image.FromFile(photo);
                        image.Save(pat);
                        odal.fetch("insert into Registeruser (name,E_id,password,mobile,state,city,photo) values('" + name + "','" + email + "','" + pass + "','" + mobile + "','" + state + "','" + city + "','" + path + "')");
                    }
                }
            }
            else
            {

            }
        } 
        */
    }
}