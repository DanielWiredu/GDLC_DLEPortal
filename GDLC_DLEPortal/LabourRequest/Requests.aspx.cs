using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;

namespace GDLC_DLEPortal.LabourRequest
{
    public partial class Requests : MasterPageChange
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
                dlCompany1.DataBind();
                if (!dleCompanyId.Contains(","))
                {
                    dlCompany.SelectedValue = dleCompanyId;
                    dlCompany.Enabled = false;    
                }
            }
        }

        protected void txtSearchReq_TextChanged(object sender, EventArgs e)
        {
            RequestGrid.Rebind();
        }

        protected void RequestGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                txtRequestNo1.Text = item["RequestNo"].Text;
                txtRequest1.Text = item["Request"].Text;
                dlCompany1.SelectedValue = item["DLECompanyId"].Text;
                dlCompany1.Enabled = false;
                btnSubmit1.Enabled = false;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void RequestGrid_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            GridDataItem item = e.Item as GridDataItem;
            string requestno = item["RequestNo"].Text;
            CheckBox chk = item["Submitted"].Controls[0] as CheckBox;
            bool submitted = chk.Checked;
            if (submitted)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Request Submitted...Cannot Delete', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("Delete from tblLabourRequest where RequestNo = @RequestNo", connection))
                {
                    command.Parameters.Add("@RequestNo", SqlDbType.Int).Value = requestno;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
                            RequestGrid.Rebind();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "spAddLabourRequest";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@DLECompanyId", SqlDbType.Int).Value = dlCompany.SelectedValue;
                    command.Parameters.Add("@Request", SqlDbType.VarChar).Value = txtRequest.Text;
                    command.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = User.Identity.Name;
                    command.Parameters.Add("@RequestNo", SqlDbType.VarChar, 20).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            txtRequestNo.Text = command.Parameters["@RequestNo"].Value.ToString();
                           
                            btnSubmit.Enabled = true;
                            RequestGrid.Rebind();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spSubmitLabourRequest", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@dleCompanyId", SqlDbType.Int).Value = dlCompany.SelectedValue;
                    command.Parameters.Add("@dleCompanyName", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@requestEmail", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@RequestNo", SqlDbType.VarChar).Value = txtRequestNo.Text;
                    command.Parameters.Add("@submittedBy", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Submitted Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            RequestGrid.Rebind();

                            sendEmail(command.Parameters["@dleCompanyName"].Value.ToString(), command.Parameters["@requestEmail"].Value.ToString(), txtRequestNo.Text, txtRequest.Text);

                            txtRequestNo.Text = "";
                            txtRequest.Text = "";
                            btnSubmit.Enabled = false;
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ex", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            txtRequestNo.Text = "";
            txtRequest.Text = "";
            btnSubmit.Enabled = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "newModal();", true);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string query = "update tblLabourRequest set Request = @Request, DLECompanyId = @DLECompanyId where RequestNo = @RequestNo";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Request", SqlDbType.VarChar).Value = txtRequest1.Text;
                    command.Parameters.Add("@DLECompanyId", SqlDbType.Int).Value = dlCompany1.SelectedValue;
                    command.Parameters.Add("@RequestNo", SqlDbType.VarChar).Value = txtRequestNo1.Text;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);

                            btnSubmit1.Enabled = true;
                            RequestGrid.Rebind();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ex", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnSubmit1_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spSubmitLabourRequest", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@dleCompanyId", SqlDbType.Int).Value = dlCompany1.SelectedValue;
                    command.Parameters.Add("@dleCompanyName", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@requestEmail", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@RequestNo", SqlDbType.VarChar).Value = txtRequestNo1.Text;
                    command.Parameters.Add("@submittedBy", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Submitted Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);

                            btnSubmit1.Enabled = false;
                            RequestGrid.Rebind();

                            sendEmail(command.Parameters["@dleCompanyName"].Value.ToString(), command.Parameters["@requestEmail"].Value.ToString(), txtRequestNo1.Text, txtRequest1.Text);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ex", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
        protected void sendEmail(string companyName, string emailAddress, string requestno, string request)
        {
            try
            {
                string mailSubject = "LABOUR REQUEST-" + companyName;
                string message = "Dear GDLC, <br><br>";
                message += "Please find below labour request submitted by <strong>" + companyName + "</strong> from the Client Portal. <br><br> ";
                message += "Request No: " + requestno + "<br>";
                //message += "Request   : " + request.Replace(Environment.NewLine, "<br>") + "<br><br>";
                message += "Request   : " + HttpUtility.HtmlEncode(request).Replace("\r\n", "\r").Replace("\n", "\r").Replace("\r", "<br>\r\n").Replace("  ", " &nbsp;") + "<br><br>";
                message += "<strong><a href='https://gdlcwave.com/' target='_blank'>Click here</a></strong> to log on to the portal for more details. <br /><br />";
                message += "<strong>This is an auto generated email. Please do not reply.</strong>";
                MailMessage myMessage = new MailMessage();
                myMessage.From = (new MailAddress("admin@gdlcwave.com", "GDLC Client Portal"));
                myMessage.To.Add(new MailAddress(emailAddress));
                myMessage.Bcc.Add(new MailAddress("daniel.wiredu@eupacwebs.com"));
                myMessage.Subject = mailSubject;
                myMessage.Body = message;
                myMessage.IsBodyHtml = true;
                SmtpClient mySmtpClient = new SmtpClient();
                mySmtpClient.Send(myMessage);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mailsuccess", "toastr.success('Email Sent Successfully', 'Success');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mailerror", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
        }
    }
}