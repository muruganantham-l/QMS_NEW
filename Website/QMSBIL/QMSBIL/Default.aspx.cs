using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSBIL
{
    public partial class Default : System.Web.UI.Page
    {

        string cs = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter adapt;
        DataTable dt;
        protected void ShowData()
        {
            dt = new DataTable();
            con = new SqlConnection(cs);
            con.Open();
            adapt = new SqlDataAdapter("SELECT Rowid, Statecode, SatateDesc, Createdby, Createddate FROM stock_location_mst_report_dummy WITH (nolock) ", con);
            adapt.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            con.Close();
        }  

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridView1.Rows[e.RowIndex].ToString();
            String id = GridView1.Rows[e.RowIndex].Cells[1].Text;
            string name = GridView1.Rows[e.RowIndex].Cells[3].Text;
            TextBox city = GridView1.Rows[e.RowIndex].FindControl("Createdby") as TextBox;
            
            con = new SqlConnection(cs);
            con.Open();
            //updating the record  
            SqlCommand cmd = new SqlCommand("UPDATE stock_location_mst_report_dummy SET SatateDesc ='" + name + "',Createdby ='" + city.Text + "' where Rowid =" +id, con);
            cmd.ExecuteNonQuery();
            con.Close();
            //Setting the EditIndex property to -1 to cancel the Edit mode in Gridview  
            GridView1.EditIndex = -1;
            //Call ShowData method for displaying updated data  
            ShowData();
        }

    }
}