using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;

namespace GDLC_DLEPortal
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        int rows = 0;
        //protected void Page_Init(object sender, EventArgs e)
        //{

        //}
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Configuration config = WebConfigurationManager.OpenWebConfiguration("~/Web.Config");
            SessionStateSection section = (SessionStateSection)config.GetSection("system.web/sessionState");
            int timeout = (int)section.Timeout.TotalMinutes * 1000 * 60;
            ScriptManager.RegisterStartupScript(this.upSessionExpire, this.upSessionExpire.GetType(), "key", "SessionExpireAlert(" + timeout + ");", true);
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "key", "SessionExpireAlert(" + 60000 + ");", true);

            if (!IsPostBack)
            {
                //session timeout modal popup
                //Configuration config = WebConfigurationManager.OpenWebConfiguration("~/Web.Config");
                //SessionStateSection section = (SessionStateSection)config.GetSection("system.web/sessionState");
                //int timeout = (int)section.Timeout.TotalMinutes * 1000 * 60;
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "SessionAlert", "SessionExpireAlert(" + timeout + ");", true);

                lblUser.Text = Context.User.Identity.Name;
                //lblUser.Text = "Daniel Barimah Wiredu";

                //getNotifications();
                if (agedWorkers != 0)
                {
                    //bgAgedWorkers.InnerText = agedWorkers.ToString();
                    //bgAgedWorkers.Visible = true;

                    //spPDTLow.InnerText = lowProducts;
                    //spPDTLow.Visible = true;
                    //lblPDT.InnerText = lowProducts + " Product(s) low in stock";
                }
                else
                {
                    //bgAgedWorkers.Visible = false;

                    //spPDTLow.Visible = false;
                    //lblPDT.InnerText = "0 Product(s) low in stock";
                }
            }
        }

        int agedWorkers;
        protected void getNotifications()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetNotifications", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@agedWorkers", SqlDbType.Int).Direction = ParameterDirection.Output;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        agedWorkers = Convert.ToInt32(command.Parameters["@agedWorkers"].Value);
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        agedWorkers = 0;
                    }
                }
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Context.User.Identity.Name != lblUser.Text)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "", "toastr.error('Error occured while changing password. Please login again and retry', 'Error');", true);
                return;
            }
            byte[] hashedPassword = GetSHA1(txtPassword.Text.Trim());

            string query = "update tblUsers set UserPassword=@upass where UserName=@uname";
            command = new SqlCommand(query, connection);
            command.Parameters.Add("@upass", SqlDbType.VarBinary).Value = hashedPassword;
            command.Parameters.Add("@uname", SqlDbType.VarChar).Value = lblUser.Text;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                rows = command.ExecuteNonQuery();
                if (rows == 1)
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "", "toastr.success('Password Changed Successfully', 'Success');", true);
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "pop", "closepassmodal();", true);
                }
                command.Dispose();
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            finally
            {
                connection.Dispose();
            }
        }

        private static byte[] GetSHA1(string password)
        {
            SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();
            return sha.ComputeHash(System.Text.Encoding.ASCII.GetBytes(password));
        }
    }
}