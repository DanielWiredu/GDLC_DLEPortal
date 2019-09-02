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
using System.IO;

namespace GDLC_DLEPortal.LabourRequest
{
    public partial class EditRequestForm : MasterPageChange
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

                string RequestNo = Request.QueryString["requestNo"].ToString();
                string query = "select * from tblLabourRequestForm where RequestNo = @RequestNo";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@RequestNo", SqlDbType.VarChar).Value = RequestNo;
                        try
                        {
                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();
                            if (reader.Read())
                            {
                                txtReqNo.Text = reader["RequestNo"].ToString();
                                dlCompany.SelectedValue = reader["DLECompanyId"].ToString();
                                dlCompany.Enabled = false;
                                txtTerminal.Text = reader["Terminal"].ToString();
                                dpReqdate.SelectedDate = Convert.ToDateTime(reader["RequestDate"]);
                                txtVessel.Text = reader["Vessel"].ToString();
                                dpDOA.SelectedDate = Convert.ToDateTime(reader["DOA"]);
                                dlActivity.SelectedText = reader["Activity"].ToString();
                                dlWorkShift.SelectedText = reader["WorkShift"].ToString();
                                chkSubmitted.Checked = Convert.ToBoolean(reader["Submitted"]);
                            }
                            reader.Close();
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        }
                    }
                }
            }
        }

        protected void btnSaveRequest_Click(object sender, EventArgs e)
        {
            string query = "Update tblLabourRequestForm set Terminal=@Terminal,RequestDate=@RequestDate,Vessel=@Vessel,DOA=@DOA,Activity=@Activity,WorkShift=@WorkShift where RequestNo=@RequestNo";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Terminal", SqlDbType.VarChar).Value = txtTerminal.Text;
                    command.Parameters.Add("@RequestDate", SqlDbType.DateTime).Value = dpReqdate.SelectedDate;
                    command.Parameters.Add("@Vessel", SqlDbType.VarChar).Value = txtVessel.Text;
                    command.Parameters.Add("@DOA", SqlDbType.DateTime).Value = dpDOA.SelectedDate;
                    command.Parameters.Add("@Activity", SqlDbType.VarChar).Value = dlActivity.SelectedText;
                    command.Parameters.Add("@WorkShift", SqlDbType.VarChar).Value = dlWorkShift.SelectedText;
                    command.Parameters.Add("@RequestNo", SqlDbType.VarChar).Value = txtReqNo.Text;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Request Changes Saved Successfully', 'Success');", true);
                            btnSubmit.Enabled = true;
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnSaveCategory_Click(object sender, EventArgs e)
        {
            //if (String.IsNullOrEmpty(txtReqNo.Text))
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Please save request before adding labour categories', 'Error');", true);
            //    return;
            //}
            if (String.IsNullOrEmpty(dlLabourCategory.SelectedValue))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Please select a labour category', 'Error');", true);
                return;
            }
            string query = "Insert into tblLabourRequestFormDetails(RequestNo,LabourCategoryId,LabourNo,Justification,Remarks) values(@RequestNo,@LabourCategoryId,@LabourNo,@Justification,@Remarks)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@RequestNo", SqlDbType.VarChar).Value = txtReqNo.Text;
                    command.Parameters.Add("@LabourCategoryId", SqlDbType.Int).Value = dlLabourCategory.SelectedValue;
                    command.Parameters.Add("@LabourNo", SqlDbType.Int).Value = txtNumber.Text;
                    command.Parameters.Add("@Justification", SqlDbType.VarChar).Value = txtJustification.Text;
                    command.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = txtRemarks.Text;

                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Labour Category Saved Successfully', 'Success');", true);
                            dlLabourCategory.ClearSelection();
                            txtNumber.Text = "";
                            txtJustification.Text = "";
                            txtRemarks.Text = "";
                            labourCategoryGrid.Rebind();
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
            if (labourCategoryGrid.Items.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "nolabour", "toastr.error('Cannnot Submit...No labour on this request', 'Not Submitted');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spSubmitLabourRequestForm", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@requestEmail", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@RequestNo", SqlDbType.VarChar).Value = txtReqNo.Text;
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

                            sendEmail(txtReqNo.Text, command.Parameters["@requestEmail"].Value.ToString());
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ex", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
        protected bool sendEmail(string RequestNo, string requestEmail)
        {
            bool mailSent = false;
            try
            {
                GridView objGV = new GridView();
                objGV.AutoGenerateColumns = false;
                BoundField bfLabourCategory = new BoundField();
                bfLabourCategory.HeaderText = "LabourCategory";
                bfLabourCategory.DataField = "LabourCategory";
                objGV.Columns.Add(bfLabourCategory);
                //BoundField bfDateofAttendance = new BoundField();
                //bfDateofAttendance.HeaderText = "DateOfAttendance";
                //bfDateofAttendance.DataField = "DateOfAttendance";
                //bfDateofAttendance.DataFormatString = "{0:dd-MMM-yyyy}";
                //objGV.Columns.Add(bfDateofAttendance);
                BoundField bfLabourNo = new BoundField();
                bfLabourNo.HeaderText = "LabourNo";
                bfLabourNo.DataField = "LabourNo";
                objGV.Columns.Add(bfLabourNo);
                BoundField bfJustification = new BoundField();
                bfJustification.HeaderText = "Justification";
                bfJustification.DataField = "Justification";
                objGV.Columns.Add(bfJustification);
                BoundField bfRemarks = new BoundField();
                bfRemarks.HeaderText = "Remarks";
                bfRemarks.DataField = "Remarks";
                objGV.Columns.Add(bfRemarks);

                SqlConnection sqlConnection = new SqlConnection();
                sqlConnection.ConnectionString = connectionString; //Connection Details   
                                                                   //select fields to mail example student details   
                SqlCommand sqlCommand = new SqlCommand("select LabourCategory,LabourNo,Justification,Remarks from vwLabourRequestFormDetails where RequestNo = @RequestNo", sqlConnection); //select query command  
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
                sqlDataAdapter.SelectCommand = sqlCommand; //add selected rows to sql data adapter 
                sqlDataAdapter.SelectCommand.Parameters.Add("@RequestNo", SqlDbType.VarChar).Value = RequestNo;
                DataSet dataSetStud = new DataSet(); //create new data set  
                sqlConnection.Open();
                sqlDataAdapter.Fill(dataSetStud);

                objGV.DataSource = dataSetStud;
                objGV.DataBind();

                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        objGV.RenderControl(hw);
                        StringReader sr = new StringReader(sw.ToString());
                        string mailSubject = "LABOUR REQUEST-" + dlCompany.SelectedItem.Text;
                        string message = "Dear GDLC, <br><br>";
                        message += "Please find below labour request submitted by <strong>" + dlCompany.SelectedItem.Text + "</strong> from the Client Portal. <br><br> ";
                        message += "Request No: " + RequestNo + "<br>";
                        message += "Terminal : " + txtTerminal.Text + "<br>";
                        message += "Request Date : " + dpReqdate.SelectedDate.Value.ToString("dd-MMM-yyyy") + "<br>";
                        message += "Vessel : " + txtVessel.Text + "<br>";
                        message += "DOA : " + dpDOA.SelectedDate.Value.ToString("dd-MMM-yyyy") + "<br>";
                        message += "Activity : " + dlActivity.SelectedText + "<br>";
                        message += "WorkShift : " + dlWorkShift.SelectedText + "<br>";
                        message += sw.ToString() + "<br><br>";
                        message += "<strong><a href='https://gdlcwave.com/' target='_blank'>Click here</a></strong> to log on to the portal for more details. <br /><br />";
                        message += "<strong>This is an auto generated email. Please do not reply.</strong>";
                        MailMessage myMessage = new MailMessage();
                        myMessage.From = (new MailAddress("admin@gdlcwave.com", "GDLC Client Portal"));
                        myMessage.To.Add(new MailAddress(requestEmail));
                        //myMessage.Bcc.Add(new MailAddress("daniel.wiredu@eupacwebs.com"));
                        myMessage.Subject = mailSubject;
                        myMessage.Body = message;
                        myMessage.IsBodyHtml = true;
                        SmtpClient mySmtpClient = new SmtpClient();
                        mySmtpClient.Send(myMessage);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "mailsuccess", "toastr.success('Email Sent Successfully', 'Success');", true);
                        mailSent = true;
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mailerror", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            return mailSent;
        }

        protected void labourCategoryGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
            }
        }
    }
}