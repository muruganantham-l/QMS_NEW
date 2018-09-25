using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

using System.Web.Services;
public partial class loginPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object Sender, Syncfusion.JavaScript.Web.ButtonEventArgs e)
    {

    }

    protected void btnSubmit_Click1(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("select * from UserInformation where UserName =@username and Password=@password", con);
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
    [WebMethod]
    public void login(string username  , string password)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("select * from UserInformation where UserName =@username and Password=@password", con);
        cmd.Parameters.AddWithValue("@username", username);
        cmd.Parameters.AddWithValue("@password", password);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {
            Session["name"] = txtUserName.Text;
            Session["id"] = Guid.NewGuid();

            SqlCommand cmd1 = new SqlCommand("insert into report_Login_log (UserName,password,Sessionid,LoginTime) values (@username,@password,@id,@logintime)", con);
            cmd1.Parameters.AddWithValue("@username", username);
            cmd1.Parameters.AddWithValue("@password", txtPWD.Text);
            cmd1.Parameters.AddWithValue("@id", password);
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