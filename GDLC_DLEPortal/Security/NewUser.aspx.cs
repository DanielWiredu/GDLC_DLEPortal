using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using Telerik.Web.UI;

namespace GDLC_DLEPortal.Security
{
    public partial class NewUser : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string dleCompanyId = Request.Cookies.Get("dlecompanyId").Value;
                dleSource.SelectCommand = "SELECT DLEcodeCompanyID, DLEcodeCompanyName FROM tblDLECompany WHERE DLEcodeCompanyID IN (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) ORDER BY DLEcodeCompanyName";
                dleSource.SelectParameters.Add("DLEcodeCompanyID", DbType.String, dleCompanyId);
                dlCompany.DataBind();
                if (!dleCompanyId.Contains(","))
                {
                    dlCompany.Items.FindItemByValue(dleCompanyId).Checked = true;
                    dlCompany.CheckedItemsTexts = RadComboBoxCheckedItemsTexts.DisplayAllInInput;
                    dlCompany.Enabled = false;
                }           
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string dleCompanyIds = "";
            foreach (RadComboBoxItem item in dlCompany.CheckedItems)
            {
                dleCompanyIds += item.Value + ",";
            }
            dleCompanyIds = dleCompanyIds.TrimEnd(',');

            //int dleCompanyId = Convert.ToInt32(dlCompany.SelectedValue);

            byte[] hashedPassword = GetSHA1(txtPassword.Text.Trim());
            string roles = "";
            foreach (RadComboBoxItem item in dlRoles.CheckedItems)
            {
                roles += item.Value + ",";
            }
            roles = roles.TrimEnd(',');

            string query = "insert into tblUsers(username,userpassword,userroles,fullname,gender,contactno,email,accounttype,dlecompanyId,active,userkey) values(@uname,@upass,@uroles,@fname,@gender,@contactno,@email,@accounttype,@dlecompanyId,@active,@userkey)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@uname", SqlDbType.VarChar).Value = txtUsername.Text;
                    command.Parameters.Add("@upass", SqlDbType.VarBinary).Value = hashedPassword;
                    command.Parameters.Add("@uroles", SqlDbType.VarChar).Value = roles;
                    command.Parameters.Add("@fname", SqlDbType.VarChar).Value = txtFullname.Text;
                    command.Parameters.Add("@gender", SqlDbType.VarChar).Value = dlGender.SelectedText;
                    command.Parameters.Add("@contactno", SqlDbType.VarChar).Value = txtMobile.Text;
                    command.Parameters.Add("@email", SqlDbType.VarChar).Value = txtEmail.Text;
                    command.Parameters.Add("@accounttype", SqlDbType.VarChar).Value = dlAccoutType.SelectedText;
                    command.Parameters.Add("@dlecompanyId", SqlDbType.VarChar).Value = dleCompanyIds;
                    command.Parameters.Add("@active", SqlDbType.Bit).Value = chkActive.Checked;
                    command.Parameters.Add("@userkey", SqlDbType.Char).Value = txtUserkey.Text.ToUpper();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('User Saved Successfully', 'Success');", true);
                            btnSave.Enabled = false;
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        /// <summary>
        /// Returns the SHA1 hash of the combined userID and password.
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        private static byte[] GetSHA1(string password)
        {
            SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();
            return sha.ComputeHash(System.Text.Encoding.ASCII.GetBytes(password));
        }
        protected void dlCompany_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlCompany.Footer.FindControl("companyCount")).Text = Convert.ToString(dlCompany.Items.Count);
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }
    }
}