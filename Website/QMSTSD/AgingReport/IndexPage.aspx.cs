using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AgingReport
{
    public partial class IndexPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["name"] == null)
            {
                Session["prevUrl"] = Request.Url;
                Response.Redirect("~/loginPage.aspx");

            }
            else
            {
                string username = Session["name"].ToString();
                this.lblWelcomeMessage.Text = string.Format("Hi {0}", Session["name"].ToString() + "!");

                if (username == "emzm" || username == "tomms")
                    {
                    TableRow12.Visible = true;


                        }
                else {
                    TableRow12.Visible = false;
                }
                //  lblWelcomeMessage.Visible = false;
                // lblWelcomeMessage.Text = username;
            }
        }
    }
}