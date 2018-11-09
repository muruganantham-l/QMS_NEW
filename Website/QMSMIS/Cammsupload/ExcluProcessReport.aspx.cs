using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cammsupload
{
    public partial class ExcluProcessReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            string test = "123";//uppassword.Text;
            string type = "";//DropDownupload.SelectedItem.Text;
            string uniid = Guid.NewGuid().ToString();
            UniqID.Text = uniid;

            if (type != "--Select--")
            {
                if (test == "123")
                {
                    if (FileUploadControl.HasFile)
                    {
                        try
                        {

                            string csvPath = Server.MapPath("~/App_Data/") + Path.GetFileName(FileUploadControl.PostedFile.FileName);
                            FileUploadControl.SaveAs(csvPath);
                            string filenames = FileUploadControl.FileName.ToString();

                            DataTable dt = new DataTable();

                            dt.Columns.AddRange(new DataColumn[4] { new DataColumn("BENumber", typeof(string)),
                                                new DataColumn("createdby", typeof(string)),
                                                new DataColumn("Createddate", typeof(string)),
                                                new DataColumn("GUID", typeof(string))});

                            dt.Columns["createdby"].DefaultValue = test;
                            dt.Columns["createddate"].DefaultValue = DateTime.Now;
                            dt.Columns["GUID"].DefaultValue = uniid;

                            string csvData = File.ReadAllText(csvPath);
                            csvData = csvData.Replace("\n", "");

                            //csvData = csvData.Replace(System.Environment.NewLine, "");
                            int D = 0;
                            foreach (string row in csvData.Split('\r'))
                            {
                                if (!string.IsNullOrEmpty(row) && D >= 1)
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
                                    sqlBulkCopy.DestinationTableName = "dbo.BE_Exclu_process_upload";
                                    //conn.Open();
                                    sqlBulkCopy.WriteToServer(dt);
                                    SqlCommand cmd1 = new SqlCommand();
                                    cmd1.Connection = conn;
                                    cmd1.CommandType = CommandType.Text;
                                    cmd1.CommandText = "exec Sp_BE_Exclu_process_upload_proc @var ";
                                    cmd1.Parameters.AddWithValue("@var", uniid);
                                    //cmd1.Parameters.AddWithValue("@var1", DateTime.Now);
                                    //cmd1.Parameters.AddWithValue("@var2", rowcount);
                                    //cmd1.Parameters.AddWithValue("@var3", test);
                                    //cmd1.Parameters.AddWithValue("@var4", filenames);
                                    cmd1.ExecuteNonQuery();
                                    conn.Close();
                                }
                            }
                            Statusmsg.Visible = true;
                            Statusmsg.Text = "File uploaded Successfully!";
                            //Approve.Visible = true;
                        }
                        catch (Exception ex)
                        {
                            Statusmsg.Visible = true;
                            Statusmsg.Text = "The file could not be uploaded. The following error occured: " + ex.Message;
                            // Approve.Visible = false;
                        }
                    }
                    else
                    {
                        Statusmsg.Visible = true;
                        Statusmsg.Text = "Please select the File and then Click Upload";
                        //Approve.Visible = false;
                    }

                }
                else
                {
                    Statusmsg.Visible = true;
                    Statusmsg.Text = "Please enter a valid password !!!";
                    //Approve.Visible = false;

                }
            }
            else
            {
                Statusmsg.Visible = true;
                Statusmsg.Text = "Please choose the Upload Type to Proceed !!!";
                //Approve.Visible = false;

            }

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
             string test = "123";//uppassword.Text;
            string type = "";//DropDownupload.SelectedItem.Text;
            string uniid = UniqID.Text;
             
            GridView GridView1 = new GridView();

            if (type != "--Select--")
            {
                if (test == "123")
                {

                     String strfilename = "Exclusion Process Report ";

            Response.ClearContent();

            Response.AddHeader("content-disposition", string.Format("attachment; filename=" + strfilename + DateTime.Now.ToString("yyyy-MM-dd HH::mm") + ".xls"));

            Response.ContentType = "application/vnd.ms-excel";

           // string space = "";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                hw.WriteLine("<b><font size='5'>" +
                           "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Exclusion Process Report &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  DATE :" + DateTime.Now.ToString("yyyy-MM-dd") +
                           "</font></b>" +
                           "</br>");
                hw.WriteLine("<br>");
                hw.WriteLine("<br>");

                //To Export all pages
                GridView1.AllowPaging = false;

                string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                SqlConnection con = null;
                con = new SqlConnection(connString);
                con.Open();


                SqlCommand cmd1 = new SqlCommand();
                cmd1.Connection = con;
                cmd1.CommandType = CommandType.Text;
                cmd1.CommandText = "exec Sp_BE_Exclu_process_report_proc @var ";
                cmd1.Parameters.AddWithValue("@var", uniid);
                //SqlCommand cmd = new SqlCommand("exec SP_Ageing_Report_out '1','2','3','4','5'", con);
                cmd1.CommandTimeout = 1000;

                SqlDataAdapter Adpt = new SqlDataAdapter(cmd1);
                DataTable dt1 = new DataTable();
                Adpt.Fill(dt1);
                GridView1.DataSource = dt1;
                GridView1.DataBind();

                GridView1.HeaderRow.BackColor = Color.White;
                GridView1.HeaderRow.BackColor = System.Drawing.ColorTranslator.FromHtml("#66B2FF");
                
                
                foreach (TableCell cell in GridView1.HeaderRow.Cells)
                {
                    cell.BackColor = GridView1.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in GridView1.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = GridView1.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                GridView1.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
                }
                else
                {
                    Statusmsg.Visible = true;
                    Statusmsg.Text = "Please enter a valid password !!!";
                    //Approve.Visible = false;

                }
            }
            else
            {
                Statusmsg.Visible = true;
                Statusmsg.Text = "Please choose the Upload Type to Proceed !!!";
                //Approve.Visible = false;

            }
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
    }
}