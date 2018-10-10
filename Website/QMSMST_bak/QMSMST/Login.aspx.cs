using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Login1 : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void login_btn_Click(object sender, EventArgs e)
    {
        string username = String.Format("{0}", Request.Form["username"]);
        string pass = String.Format("{0}", Request.Form["pass"]);
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("select * from UserInformation where UserName =@username and Password=@password", con);
        cmd.Parameters.AddWithValue("@username", username);
        cmd.Parameters.AddWithValue("@password", pass);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {
            Session["name"] = username;
            Session["id"] = Guid.NewGuid();

            SqlCommand cmd1 = new SqlCommand("insert into report_Login_log (UserName,password,Sessionid,LoginTime) values (@username,@password,@id,@logintime)", con);
            cmd1.Parameters.AddWithValue("@username", username);
            cmd1.Parameters.AddWithValue("@password", pass);
            cmd1.Parameters.AddWithValue("@id", Session.SessionID);
            cmd1.Parameters.AddWithValue("@logintime", DateTime.Now);
            cmd1.ExecuteNonQuery();

            if (Session["prevUrl"] != null)
            {

                //Response.Redirect(Session["prevUrl"].ToString());
                Response.Redirect("IndexPage.aspx");
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
}