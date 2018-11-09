using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cammsupload
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("select username, emailcode , Password from UserInformation (nolock) where UserName =@username ", con);
            cmd.Parameters.AddWithValue("@username", txtUserName.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
           
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {

                Label19.Visible = true;

                SqlCommand cmd1 = new SqlCommand("exec Forgotpassword_email @username ", con);
                cmd1.Parameters.AddWithValue("@username", txtUserName.Text);
                cmd1.ExecuteNonQuery();


                Label19.Text = "Password Sent to the registered Email. Please check your Email.";

                /*
                 * MailMessage Msg = new MailMessage();
                // Sender e-mail address.
                Msg.From = new MailAddress(ds.Tables[0].Rows[0]["emailcode"].ToString());
                // Recipient e-mail address.
                Msg.To.Add(ds.Tables[0].Rows[0]["emailcode"].ToString());
                Msg.Subject = "Your Password Details";
                Msg.Body = "Hi, <br/><br/>Please check your Login Details<br/><br/>Your Username: " + ds.Tables[0].Rows[0]["userName"] + "<br/><br/>Your Password: " + ds.Tables[0].Rows[0]["Password"] + "<br/><br/>";
                Msg.IsBodyHtml = true;
                // your remote SMTP server IP.
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "mail.qms.com.my";
                smtp.Port = 587;
                smtp.Credentials = new System.Net.NetworkCredential("server@qms.com.my", "");
                smtp.EnableSsl = true;
                smtp.Send(Msg);
                //Msg = null;
                 * */

                // Clear the textbox valuess

                //Response.Redirect("BVUpload.aspx");
            }
            else
            {
                ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('UserName Does not Exist')</script>");
            }
            con.Close();
        }
    }
}