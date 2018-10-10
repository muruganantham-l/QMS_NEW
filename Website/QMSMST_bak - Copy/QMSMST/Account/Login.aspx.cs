#region Copyright Syncfusion Inc. 2001-2018.
// Copyright Syncfusion Inc. 2001-2018. All rights reserved.
// Use of this code is subject to the terms of our license.
// A copy of the current license can be obtained at any time by e-mailing
// licensing@syncfusion.com. Any infringement will be prosecuted under
// applicable laws. 
#endregion
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using Syncfusion_ASP.NET_Web_Site;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Account_Login : Page
{
        protected void Page_Load(object sender, EventArgs e)
        {
            //RegisterHyperLink.NavigateUrl = "Register";
            //OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];
            //var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            //if (!String.IsNullOrEmpty(returnUrl))
            //{
            //    RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            //}
        }

        protected void LogIn(object sender, EventArgs e)
        {
        login();
            //if (IsValid)
            //{
            //    // Validate the user password
            //    var manager = new UserManager();
            //    ApplicationUser user = manager.Find(UserName.Text, Password.Text);
            //    if (user != null)
            //    {
            //        IdentityHelper.SignIn(manager, user, RememberMe.Checked);
            //        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            //    }
            //    else
            //    {
            //        FailureText.Text = "Invalid username or password.";
            //        ErrorMessage.Visible = true;
            //    }
            //}
    }

    public void login()
    { 
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString);
    con.Open();
            SqlCommand cmd = new SqlCommand("select * from UserInformation where UserName =@username and Password=@password", con);
    cmd.Parameters.AddWithValue("@username", UserName.Text);
            cmd.Parameters.AddWithValue("@password", Password.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
    DataTable dt = new DataTable();
    da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                Session["name"] = UserName.Text;
                Session["id"] = Guid.NewGuid();

                SqlCommand cmd1 = new SqlCommand("insert into report_Login_log (UserName,password,Sessionid,LoginTime) values (@username,@password,@id,@logintime)", con);
    cmd1.Parameters.AddWithValue("@username", UserName.Text);
                cmd1.Parameters.AddWithValue("@password", Password.Text);
                cmd1.Parameters.AddWithValue("@id", Session.SessionID);
                cmd1.Parameters.AddWithValue("@logintime", DateTime.Now);
                cmd1.ExecuteNonQuery();

                if (Session["prevUrl"] != null)
                {

                    //Response.Redirect(Session["prevUrl"].ToString());
                    Response.Redirect("~/IndexPage.aspx");
                    //Response.Redirect((string)Session["prevUrl"]); //Will redirect to previous page
                }
                else
                {
                    Response.Redirect("~/IndexPage.aspx");
                }
               
                //Response.Redirect("BVUpload.aspx");
            }
            else
            {
                ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('Invalid Username and Password')</script>");
            }
            con.Close();
    }
}