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
    public partial class UserCreation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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


                    /*For Clinic Cate Dropdown Load*/
                    DropDownList1.Items.Insert(0, new ListItem("MIS", "1"));
                    DropDownList1.Items.Insert(0, new ListItem("TSD", "2"));
                    DropDownList1.Items.Insert(0, new ListItem("MMD", "3"));
                    DropDownList1.Items.Insert(0, new ListItem("FIN", "4"));
                    DropDownList1.Items.Insert(0, new ListItem("--Select--", "0"));

                    /*For Clinic Cate Dropdown Load*/
                    DropDownList2.Items.Insert(0, new ListItem("HQ", "1"));
                    DropDownList2.Items.Insert(0, new ListItem("JOHOR", "2"));
                    DropDownList2.Items.Insert(0, new ListItem("MELAKA", "3"));
                    DropDownList2.Items.Insert(0, new ListItem("SELANGOR", "4"));
                    DropDownList2.Items.Insert(0, new ListItem("WKL", "5"));
                    DropDownList2.Items.Insert(0, new ListItem("NEGERI SEMBILAN", "6"));
                    DropDownList2.Items.Insert(0, new ListItem("PERAK", "7"));
                    DropDownList2.Items.Insert(0, new ListItem("PENANG", "8"));
                    DropDownList2.Items.Insert(0, new ListItem("SABAH", "9"));
                    DropDownList2.Items.Insert(0, new ListItem("SARAWAK", "10"));
                    DropDownList2.Items.Insert(0, new ListItem("LABUAN", "11"));
                    DropDownList2.Items.Insert(0, new ListItem("KOLEJ", "12"));
                    DropDownList2.Items.Insert(0, new ListItem("--Select--", "0"));

                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            
                TextBox1.Text = null;
                TextBox2.Text = null;
                TextBox3.Text = null;
                DropDownList1.SelectedItem.Text = "--Select--";
                DropDownList2.SelectedItem.Text = "--Select--";
                
          }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("select * from UserInformation where UserName = @username", con);
            cmd.Parameters.AddWithValue("@username", TextBox1.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                SqlCommand cmd1 = new SqlCommand("insert into UserInformation (UserName,password,emailcode,Department,State,createdate) values (@username,@password,@emailid,@department,@state,@logintime)", con);
                cmd1.Parameters.AddWithValue("@username", TextBox1.Text);
                cmd1.Parameters.AddWithValue("@password", TextBox2.Text);
                cmd1.Parameters.AddWithValue("@emailid", TextBox3.Text);
                cmd1.Parameters.AddWithValue("@department", DropDownList1.SelectedItem.Text);
                cmd1.Parameters.AddWithValue("@state", DropDownList2.SelectedItem.Text);
                cmd1.Parameters.AddWithValue("@logintime", DateTime.Now);
                cmd1.ExecuteNonQuery();

                ClientScript.RegisterStartupScript(Page.GetType(), "SuccessMessage", "<script language='javascript'>alert('User Created Successfully!!!')</script>");

                TextBox1.Text = null;
                TextBox2.Text = null;
                TextBox3.Text = null;
                DropDownList1.SelectedItem.Text = "--Select--";
                DropDownList2.SelectedItem.Text = "--Select--";

            }
            else
            {
                ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('UserName already Exist in Server')</script>");
            }
            con.Close();

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}