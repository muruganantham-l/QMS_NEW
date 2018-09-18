using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
 
using System.IO;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace AgingReport
{
    
    public partial class DownloadMasters : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                state_load();


            }
        }
        public void state_load()
        {

            SqlConnection con = null;

            try
            {
                string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
                con = new SqlConnection(connString);
                /*For State Dropdown Load*/
                string com = "Select ast_lvl_ast_lvl, ast_lvl_ast_lvl  from ast_lvl (nolock)";

                SqlDataAdapter adpt = new SqlDataAdapter(com, con);
                DataTable dt = new DataTable();
                adpt.Fill(dt);
                State_combobox.DataSource = dt;
                State_combobox.DataBind();
                State_combobox.DataTextField = "ast_lvl_ast_lvl";
                State_combobox.DataValueField = "ast_lvl_ast_lvl";
                State_combobox.DataBind();
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
        public override void VerifyRenderingInServerForm(Control control)
        {
            //base.VerifyRenderingInServerForm(control);
        }
        protected void ExportExcel_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition","attachment;filename=AssetRegister.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {

                HtmlTextWriter hw = new HtmlTextWriter(sw);
                GridView1.AllowPaging = false;
                //loaddata();
                GridView1.RenderControl(hw);

                string style = @"<style>.textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();

            }
        }

        protected void search_btn_Click(object sender, EventArgs e)
        {

            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;

            try
            {
                con = new SqlConnection(connString);

                SqlDataAdapter adp = new SqlDataAdapter("Exec select_ast_master '" + State_combobox.SelectedItem.Text  
                     + "'", con);

                con.Open();

                DataTable ds = new DataTable();
                adp.Fill(ds);
                GridView1.DataSource = ds;
                GridView1.DataBind();

            }
            catch (Exception ex)
            {
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