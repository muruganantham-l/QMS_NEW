using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSMMD
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
      

        }

        public int SplitAndSave(string inputPath, string outputPath)
        {
            FileInfo file = new FileInfo(inputPath);
            string name = file.Name.Substring(0, file.Name.LastIndexOf("."));

            PdfReader reader = new PdfReader(inputPath);
           
            for (int pagenumber = 1; pagenumber <= reader.NumberOfPages; pagenumber++)
                {
                    string filename = pagenumber.ToString() + ".pdf";

                    Document document = new Document();
                    PdfCopy copy = new PdfCopy(document, new FileStream(outputPath + "\\" + filename, FileMode.Create));

                    document.Open();

                    copy.AddPage(copy.GetImportedPage(reader, pagenumber));

                    document.Close();
                }
                return reader.NumberOfPages;
            

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            string Test = FileUpload1.FileName;
            SplitAndSave("D:\\Work\\Aravinth\\MIS\\Test\\BERCert6Assest.pdf", Environment.GetFolderPath(Environment.SpecialFolder.CommonDesktopDirectory));
        }

        protected void imagebutton_Click(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["tomms_prodConnectionString"].ConnectionString;
            SqlConnection con = null;
            con = new SqlConnection(connString);
            


            SqlCommand cmd = new SqlCommand();
            
            cmd.Connection = con;
            cmd.CommandText = "select attachment from ast_ref (nolock) where mst_rowid = 121032";
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            
            
              while (rdr.Read())
            {
                Context.Response.ContentType = "Image/jpg";
               Context.Response.BinaryWrite((byte[])rdr["attachment"]);
               
            }
            if (rdr != null)
                rdr.Close();
            
        }

               
    }

   
}
