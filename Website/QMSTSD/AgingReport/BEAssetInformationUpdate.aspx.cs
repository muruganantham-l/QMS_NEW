using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace AgingReport
{
    public partial class BEAssetInformationUpdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label29.Visible = true;

            if (!IsPostBack)
            {
                if (Session["name"] == null)
                {

                    Response.Redirect("~/loginPage.aspx");

                }
                else
                {
                    string username = Session["name"].ToString();
                    this.Label8.Text = string.Format("Hi {0}", Session["name"].ToString() + "!");
                }
            }
        }

            protected void be_num_enter_key_Click(object sender, EventArgs e)
        {
            string BeNumValid = Isbenumbervalid();

            if (BeNumValid == "false")
            {
               
                Label29.ForeColor = System.Drawing.Color.Red;
                Label29.Visible = true;
                Label29.Text = " Please enter valid BE Number";

                be_number_txt.Text = null;
                state.Text = null;
                clinicname.Text = null;
                district.Text = null;
                cliniccode.Text = null;
                circle.Text = null;
                clinic_category.Text = null;
                be_category.Text = null;
                be_condi_status.Text = null;
                be_status.Text = null;
                ownership.Text = null;

                Manufacture.Text = null;
                Model.Text = null;
                SerialNumber.Text = null;
                BELocation.Text = null;
                KEWPA_Number.Text = null;
                JKKP_Certificate_Number.Text = null;
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con1 = null;

            try
            {
                // DropDownBECategory.SelectedItem.Text = null;
                con1 = new SqlConnection(connString);

                DataTable dt = new DataTable();
                con1.Open();
                SqlDataReader myReader = null;
                //  SqlCommand myCommand = new SqlCommand("select top 1 convert(varchar(10),ast_det_datetime1 ,103) ast_det_datetime1,convert(varchar(10),ast_det_warranty_date ,103) ast_det_warranty_date	from ast_det b (nolock)	where ast_det_varchar21 is not null 	and ast_det_varchar21 != 'NA'    and ast_det_varchar21 ='" + DropDownbatch.SelectedItem.Text + "' 	AND ast_det_varchar16 = '" + DropDownSuppliername.SelectedItem.Text + "'and ast_det_modelno = '" + DropDownmodel.SelectedItem.Text + "' and exists (	select '' from ast_mst a (nolock)	where a.RowID = b.mst_RowID and a.ast_mst_asset_longdesc = '" + DropDownBECategory.SelectedItem.Text + "' 	)	", con1);

                SqlCommand myCommand = new SqlCommand(
                      "select ast_mst_ast_lvl    'State', replace(replace(replace(ast_det_note1, char(10), ''), char(13), ''), char(9), '')       'ClinicName', ast_mst_asset_locn 'District', ast_det_cus_code       'ClinicCode', ast_mst_work_area  'Circle', ast_mst_asset_code 'ClinicCategory', ast_mst_asset_longdesc    'BECategory', ast_mst_asset_status      'BEConditionalStatus', ast_det_varchar5 'bestatus', ast_det_varchar15  'Ownership', ast_det_mfg_cd 'Manufacturer', ast_det_modelno 'ModelNumber', ast_det_varchar2 'SerialNumber', ast_det_varchar19 'be_location', ast_det_varchar13 'kewpa_number', ast_det_varchar14 'jkkp_certificate_number' from ast_mst (nolock),ast_det(Nolock) where ast_mst.rowid = mst_rowid and ast_mst_asset_no = '"+be_number_txt.Text+"'"              , con1);


             

                myReader = myCommand.ExecuteReader();

                while (myReader.Read())
                {
                      
                    state.Text = myReader["State"].ToString();
                    clinicname.Text = myReader["ClinicName"].ToString();
                    district.Text = myReader["District"].ToString();
                    cliniccode.Text = myReader["ClinicCode"].ToString();
                    circle.Text = myReader["Circle"].ToString();
                    clinic_category.Text = myReader["ClinicCategory"].ToString();
                    be_category.Text = myReader["BECategory"].ToString();
                    be_condi_status.Text = myReader["BEConditionalStatus"].ToString();
                    be_status.Text = myReader["bestatus"].ToString();
                    ownership.Text = myReader["Ownership"].ToString();

                    Manufacture.Text = myReader["Manufacturer"].ToString();
                    Model.Text = myReader["ModelNumber"].ToString();
                    SerialNumber.Text = myReader["SerialNumber"].ToString();
                    BELocation.Text = myReader["be_location"].ToString();
                    KEWPA_Number.Text = myReader["kewpa_number"].ToString();
                    JKKP_Certificate_Number.Text = myReader["jkkp_certificate_number"].ToString();

                    //(myReader["ast_det_warranty_date"].ToString().Substring(0, 10));

                }
                
            }
            catch (Exception ex)
            {
                //log error 
                //display friendly error to user
                string msg = "Insert Error:";
                msg += ex.Message;
                throw new Exception(msg);

            }
            finally
            {

                con1.Close();
            }



        }

        protected string Isbenumbervalid()
        {

            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connString);
            SqlCommand cmd = new SqlCommand();
            object returnValue;

            cmd.CommandText = "select count(1) from ast_mst where ast_mst_asset_no=@ast_no";
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ast_no", be_number_txt.Text);
            cmd.Connection = con;

            con.Open();
            returnValue = cmd.ExecuteScalar();
            con.Close();

            if (Convert.ToInt16(returnValue) > 0)
            {

                return "true";
                
            }
         
            else
            {
                
                return "false";

            }
        }

        protected void reset_btn_Click(object sender, EventArgs e)
        {
            be_number_txt.Text = null;
            state.Text = null;
            clinicname.Text = null;
            district.Text = null;
            cliniccode.Text = null;
            circle.Text = null;
            clinic_category.Text = null;
            be_category.Text = null;
            be_condi_status.Text = null;
            be_status.Text = null;
            ownership.Text = null;

            Manufacture.Text = null;
            Model.Text = null;
            SerialNumber.Text = null;
            BELocation.Text = null;
            KEWPA_Number.Text = null;
            JKKP_Certificate_Number.Text = null;

        }

        protected void save_btn_Click(object sender, EventArgs e)
        {
            string BeNumValid = Isbenumbervalid();

            if (BeNumValid == "false")
            {

                Label29.ForeColor = System.Drawing.Color.Red;
                Label29.Visible = true;
                Label29.Text = " Please enter valid BE Number";

                be_number_txt.Text = null;
                state.Text = null;
                clinicname.Text = null;
                district.Text = null;
                cliniccode.Text = null;
                circle.Text = null;
                clinic_category.Text = null;
                be_category.Text = null;
                be_condi_status.Text = null;
                be_status.Text = null;
                ownership.Text = null;

                Manufacture.Text = null;
                Model.Text = null;
                SerialNumber.Text = null;
                BELocation.Text = null;
                KEWPA_Number.Text = null;
                JKKP_Certificate_Number.Text = null;
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);

            //string sql2 = "update b    set ast_det_mfg_cd = @ast_det_mfg_cd   , ast_det_modelno = @ast_det_modelno  , ast_det_varchar2 = @ast_det_varchar2 , ast_det_varchar19 = @ast_det_varchar19 , ast_det_varchar13 = @ast_det_varchar13   , ast_det_varchar14 = @ast_det_varchar14           from ast_mst (nolock)a,ast_det(Nolock) b where a.rowid = mst_rowid and ast_mst_asset_no = @ast_no ";

            //SqlCommand myCommand2 = new SqlCommand(sql2, conn);
            //myCommand2.Parameters.AddWithValue("@ast_det_mfg_cd", Manufacture.Text);
            //myCommand2.Parameters.AddWithValue("@ast_det_modelno", Model.Text);
            //myCommand2.Parameters.AddWithValue("@ast_det_varchar2", SerialNumber.Text);
            //myCommand2.Parameters.AddWithValue("@ast_det_varchar19", BELocation.Text);
            //myCommand2.Parameters.AddWithValue("@ast_det_varchar13", KEWPA_Number.Text);
            //myCommand2.Parameters.AddWithValue("@ast_det_varchar14", JKKP_Certificate_Number.Text);
            //myCommand2.Parameters.AddWithValue("@ast_no", be_number_txt.Text);
            //try
            //{
            //    conn.Open();
            //    myCommand2.ExecuteNonQuery();
            //}
            try
            {
                 
                SqlCommand cmd = new SqlCommand("edit_be_asset_information_validate", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("be_number", be_number_txt.Text);
                cmd.Parameters.AddWithValue("Manufacture", Manufacture.Text);
                cmd.Parameters.AddWithValue("Model", Model.Text);
                cmd.Parameters.AddWithValue("SerialNumber", SerialNumber.Text);
                cmd.Parameters.AddWithValue("BELocation", BELocation.Text);
                cmd.Parameters.AddWithValue("KEWPA_Number", KEWPA_Number.Text);
                cmd.Parameters.AddWithValue("JKKP_Certificate_Number", JKKP_Certificate_Number.Text);
                cmd.Parameters.AddWithValue("ctxt_user", Session["name"]);
                

                conn.Open();
                int k = cmd.ExecuteNonQuery();
                if (k != 0)
                {
                    Label29.Text = "Record Inserted Succesfully into the Database";
                    Label29.ForeColor = System.Drawing.Color.CornflowerBlue;
                }
                conn.Close();
            }
        catch (Exception ex)
            {
                
                //log error 
                //display friendly error to user
                string msg = "Insert Error:";
                msg += ex.Message;
                throw new Exception(msg);
            }
            finally
            {
                conn.Close();
            }

            Label29.ForeColor = System.Drawing.Color.Green;
            Label29.Visible = true;
            Label29.Text = "Records updated successfully";
        }
    }
}