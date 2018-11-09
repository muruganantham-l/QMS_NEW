using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cammsupload
{
    public partial class IndexPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["name"] == null)
            {
                Session["prevUrl"] = Request.Url;
                Response.Redirect("~/login.aspx");

            }
            else
            {
                string username = Session["name"].ToString();
                this.lblWelcomeMessage.Text = string.Format("Hi {0}", Session["name"].ToString() + "!");
                //  lblWelcomeMessage.Visible = false;
                // lblWelcomeMessage.Text = username;
            }
        }
    }
}