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

namespace QMSBIL
{
    public partial class BVUpload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                if (Session["name"] == null)
                    {

                        Response.Redirect("~/login.aspx");

                    }
                    else
                    {
                        string username = Session["name"].ToString();
                        Label2.Visible = false;
                        Label2.Text = username;
                   
                        
                    /*For Ownership Dropdown Load*/

                    filetype.Items.Insert(0, new ListItem("Invoice Data", "1"));
                    filetype.Items.Insert(0, new ListItem("Payment Data", "2"));
                    filetype.Items.Insert(0, new ListItem("--Select--", "0"));
                    }
            }  
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string test = Label2.Text;
            string type = filetype.SelectedItem.Text;
            string uniid = Guid.NewGuid().ToString();

            if (type != "--Select--")
            {
                if (test !="")
                {
                    if (FileUpload1.HasFile)
                    {
                        try
                        {

                            string csvPath = Server.MapPath("~/App_Data/") + Path.GetFileName(FileUpload1.PostedFile.FileName);
                            FileUpload1.SaveAs(csvPath);
                            string filenames = FileUpload1.FileName.ToString();
                            string tablename = string.Empty;
                            string procedurename = string.Empty;

                            DataTable dt = new DataTable();

                            if (type == "Invoice Data")
                            {
                                tablename = "dbo.BV_invoice_data_upload_tab";
                                procedurename = "exec Sp_inupd_BV_invoice_data_upload_tab @var ";

                                dt.Columns.AddRange(new DataColumn[15] { new DataColumn("#", typeof(string)),
                                                new DataColumn("Invoice No.", typeof(string)),
                                                new DataColumn("Invoice Date", typeof(string)),
                                                new DataColumn("Currency", typeof(string)),
                                                new DataColumn("Total Invoice Amount", typeof(string)),
                                                new DataColumn("Bill To Customer Code", typeof(string)),
                                                new DataColumn("Bill To Customer Name", typeof(string)),
                                                new DataColumn("Bill To ID.", typeof(string)),
                                                new DataColumn("Finance Book", typeof(string)),
                                                new DataColumn("Status", typeof(string)),
                                                new DataColumn("Shipping Point", typeof(string)),
                                                new DataColumn("createdby", typeof(string)),
                                                new DataColumn("Createddate", typeof(string)),
                                                new DataColumn("GUID", typeof(string)),
                                                new DataColumn("File Name", typeof(string))});
                            }

                            else if (type == "Payment Data")
                            {

                                tablename = "dbo.BV_payment_data_upload_tab";
                                procedurename = "exec Sp_inupd_BV_payment_data_upload_tab @var ";

                                dt.Columns.AddRange(new DataColumn[23] { new DataColumn("#", typeof(string)),
                                                new DataColumn("Receipt No.", typeof(string)),
                                                new DataColumn("Customer Code", typeof(string)),
                                                new DataColumn("Customer Name", typeof(string)),
                                                new DataColumn("Receipt Route", typeof(string)),
                                                new DataColumn("Receipt Date", typeof(string)),
                                                new DataColumn("Currency", typeof(string)),
                                                new DataColumn("Receipt Amount", typeof(string)),
                                                new DataColumn("Receipt Category", typeof(string)),
                                                new DataColumn("Finance Book", typeof(string)),
                                                new DataColumn("Instrument No.", typeof(string)),
                                                new DataColumn("Status", typeof(string)),
                                                new DataColumn("Instrument Date", typeof(string)),
                                                new DataColumn("Receipt Mode", typeof(string)),
                                                new DataColumn("Bank / Cash Code", typeof(string)),
                                                new DataColumn("Description", typeof(string)),
                                                new DataColumn("Booking No", typeof(string)),
                                                new DataColumn("HBL HAWB NO", typeof(string)),
                                                new DataColumn("MBL MAWB NO", typeof(string)),
                                                new DataColumn("createdby", typeof(string)),
                                                new DataColumn("Createddate", typeof(string)),
                                                new DataColumn("GUID", typeof(string)),
                                                new DataColumn("File Name", typeof(string))});
                            }

                            dt.Columns["createdby"].DefaultValue = test;
                            dt.Columns["createddate"].DefaultValue = DateTime.Now;
                            dt.Columns["GUID"].DefaultValue = uniid;
                            dt.Columns["File Name"].DefaultValue = filenames;
                            
                            string csvData = File.ReadAllText(csvPath);

                            //Response.Write(csvData);

                            csvData = csvData.Replace("\r", "");
                            csvData = csvData.Replace("\t", "");
                            csvData = csvData.Replace(",", "|");
                            csvData = csvData.Replace("\n", "\r");
                            csvData = csvData.Replace("\n", "");
                           
                            //Response.Write(csvData);

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

                            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                            SqlConnection conn = null;
                            conn = new SqlConnection(connString);
                            conn.Open();
                            using (SqlCommand cmd = new SqlCommand())
                            {
                                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(conn))
                                {
                                    //Set the database table name
                                    sqlBulkCopy.DestinationTableName = tablename;
                                    //conn.Open();
                                    sqlBulkCopy.WriteToServer(dt);

                                    SqlCommand cmd1 = new SqlCommand();
                                    cmd1.Connection = conn;
                                    cmd1.CommandType = CommandType.Text;
                                    cmd1.CommandText = procedurename;
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
                        ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('Please Choose a File and then Proceed')</script>");
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
                ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('Please Select any Transaction Type')</script>");

            }
        }
    }
}