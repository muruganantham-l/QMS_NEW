using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cammsupload
{
    public partial class DecryptPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public string Decrypt(string Encrypt)
        {
            ASCIIEncoding asciiEncoding = new ASCIIEncoding();
            byte[] bytes1 = asciiEncoding.GetBytes("23949842");
            byte[] bytes2 = asciiEncoding.GetBytes("3352657361476854");
            DES des = (DES)new DESCryptoServiceProvider();
            MemoryStream memoryStream = new MemoryStream();
            byte[] buffer = Convert.FromBase64String(Encrypt);
            memoryStream.Write(buffer, 0, buffer.Length);
            CryptoStream cryptoStream = new CryptoStream((Stream)new MemoryStream(memoryStream.ToArray()), des.CreateDecryptor(bytes1, bytes2), CryptoStreamMode.Read);
            byte[] numArray = new byte[memoryStream.Length];
            cryptoStream.Read(numArray, 0, numArray.Length);

            return asciiEncoding.GetString(numArray).Replace("\0", "");

        }

        private string EncryptData(string szPlainText)
        {
            CryptoStream cryptoStream = (CryptoStream)null;
            MemoryStream memoryStream = (MemoryStream)null;
            try
            {
                string empty = string.Empty;
                ASCIIEncoding asciiEncoding = new ASCIIEncoding();
                memoryStream = new MemoryStream();
                DES des = (DES)new DESCryptoServiceProvider();
                byte[] bytes1 = asciiEncoding.GetBytes("23949842");
                byte[] bytes2 = asciiEncoding.GetBytes("3352657361476854");
                cryptoStream = new CryptoStream((Stream)memoryStream, des.CreateEncryptor(bytes1, bytes2), CryptoStreamMode.Write);
                byte[] bytes3 = asciiEncoding.GetBytes(szPlainText);
                cryptoStream.Write(bytes3, 0, bytes3.Length);
                cryptoStream.FlushFinalBlock();
                string base64String = Convert.ToBase64String(memoryStream.ToArray());
                cryptoStream.Flush();
                memoryStream.Flush();
                Label1.Visible = true;
                Label1.Text = des.Key.ToString();
                return base64String;
                //Label1.Text = (des.CreateEncryptor(bytes1, bytes2).ToString()).ToString();
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message.ToString();
                return "";
            }
            finally
            {
                if (cryptoStream != null)
                    cryptoStream.Close();
                if (memoryStream != null)
                    memoryStream.Close();
            }
        }

        protected void btnExecute_Click(object sender, EventArgs e)
        {
            try
            {
                if (optEncrypt.SelectedItem.Value =="Encrypt")
                    this.txtOutput.Text = this.EncryptData(this.txtInput.Text);
                else
                    this.txtOutput.Text = this.Decrypt(this.txtInput.Text);
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message.ToString();
            }
        }
    }
}