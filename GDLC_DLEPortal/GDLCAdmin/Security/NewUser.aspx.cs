﻿using System;
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

namespace GDLC_DLEPortal.GDLCAdmin.Security
{
    public partial class NewUser : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int dleCompanyId = 0;
            if (!String.IsNullOrEmpty(dlCompany.SelectedValue))
                dleCompanyId = Convert.ToInt32(dlCompany.SelectedValue);

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
                    command.Parameters.Add("@dlecompanyId", SqlDbType.Int).Value = dleCompanyId;
                    command.Parameters.Add("@active", SqlDbType.Bit).Value = chkActive.Checked;
                    command.Parameters.Add("@userkey", SqlDbType.Char).Value = txtUserkey.Text.ToUpper();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('User Saved Successfully', 'Success');", true);
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
        protected void dlCompany_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["DLEcodeCompanyName"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["DLEcodeCompanyID"].ToString();
        }

        protected void dlCompany_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlCompany.Footer.FindControl("companyCount")).Text = Convert.ToString(dlCompany.Items.Count);
        }

        protected void dlCompany_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(30) DLEcodeCompanyID,DLEcodeCompanyName FROM [tblDLECompany] WHERE Active = 1 AND DLEcodeCompanyName LIKE '%" + e.Text.ToUpper() + "%'";
            dleSource.SelectCommand = sql;
            dlCompany.DataBind();
        }
    }
}