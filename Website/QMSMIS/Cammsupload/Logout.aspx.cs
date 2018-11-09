﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cammsupload
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String ID = Session.SessionID;
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            con.Open();
            SqlCommand cmd1 = new SqlCommand("update report_Login_log set LogoutTime = @logintime  where Sessionid = @id", con);
            cmd1.Parameters.AddWithValue("@logintime", DateTime.Now);
            cmd1.Parameters.AddWithValue("@id", ID);
            cmd1.ExecuteNonQuery();
            con.Close();

        }
        protected void Timer1_Tick(object sender, EventArgs e)
        {
            String ID = Session.SessionID;
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            con.Open();
            SqlCommand cmd1 = new SqlCommand("update report_Login_log set LogoutTime = @logintime  where Sessionid = @id", con);
            cmd1.Parameters.AddWithValue("@logintime", DateTime.Now);
            cmd1.Parameters.AddWithValue("@id", ID);
            cmd1.ExecuteNonQuery();
            con.Close();

            Session.Clear();
            Session.Abandon();
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddYears(-30);
            Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
            try
            {
                Session.Abandon();
                FormsAuthentication.SignOut();
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Buffer = true;
                Response.ExpiresAbsolute = DateTime.Now.AddDays(-1d);
                Response.Expires = -1000;
                Response.CacheControl = "no-cache";
                Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddYears(-30);
                Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
                //Response.Redirect("login.aspx", true);
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            Response.Redirect("~/Login.aspx");
        }
    }
}