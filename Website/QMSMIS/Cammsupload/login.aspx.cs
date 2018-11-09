using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cammsupload
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("select * from UserInformation where UserName = @username and Password=@password and Department='MIS'", con);
            cmd.Parameters.AddWithValue("@username", txtUserName.Text);
            cmd.Parameters.AddWithValue("@password", txtPWD.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                Session["name"] = txtUserName.Text;
                Session["id"] = Guid.NewGuid();

                SqlCommand cmd1 = new SqlCommand("insert into report_Login_log (UserName,password,Sessionid,LoginTime) values (@username,@password,@id,@logintime)", con);
                cmd1.Parameters.AddWithValue("@username", txtUserName.Text);
                cmd1.Parameters.AddWithValue("@password", txtPWD.Text);
                cmd1.Parameters.AddWithValue("@id", Session.SessionID);
                cmd1.Parameters.AddWithValue("@logintime", DateTime.Now);
                cmd1.ExecuteNonQuery();

                if (Session["prevUrl"] != null)
                {
                    Response.Redirect("IndexPage.aspx");
                   // Response.Redirect(Session["prevUrl"].ToString());
                    //Response.Redirect((string)Session["prevUrl"]); //Will redirect to previous page
                }
                else
                {
                    Response.Redirect("IndexPage.aspx");
                }

                //Response.Redirect("BVUpload.aspx");
            }
            else
            {
                ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('Invalid Username and Password')</script>");
            }
            con.Close();
        }

        protected void btnSubmit0_Click(object sender, EventArgs e)
        {
            txtUserName.Text = null;
            txtPWD.Text = null;
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            // declare array string to generate random string with combination of small,capital letters and numbers
            char[] charArr = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray();
            string strrandom = string.Empty;
            Random objran = new Random();
            int noofcharacters = 6;
            for (int i = 0; i < noofcharacters; i++)
            {
                //It will not allow Repetation of Characters
                int pos = objran.Next(1, charArr.Length);
                if (!strrandom.Contains(charArr.GetValue(pos).ToString()))
                    strrandom += charArr.GetValue(pos);
                else
                    i--;
            }
           Response.Write(strrandom);
        }

    }
}