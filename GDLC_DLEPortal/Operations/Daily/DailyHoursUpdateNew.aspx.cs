using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using Telerik.Web.UI;
using System.Net.Mail;

namespace GDLC_DLEPortal.Operations.Daily
{
    public partial class DailyHoursUpdateNew : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = "select AutoNo,ReqNo,DLEcodeCompanyID,VesselberthID,locationID,ReportpointID,cargoID,gangID,job,date_,Normal,Overtime,Weekends,Night,Approved,Adate,OnBoardAllowance,NormalHrsFrom,NormalHrsTo,OvertimeHrsFrom,OvertimeHrsTo, Processed,Stored from tblStaffReq where DLEcodeCompanyID IN (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) AND ReqNo=@ReqNo";
                string reqno = Request.QueryString["reqno"].ToString();
                if (!String.IsNullOrEmpty(reqno))
                    loadReqNo(reqno, query, "load");

                btnConfirm.Enabled = User.IsInRole("Operations Manager");
            }
            //btnFind.Focus();
        }
        protected void loadReqNo(string reqno, string query, string request)
        {
            string dleCompanyId = Request.Cookies["dlecompanyId"].Value;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@DLEcodeCompanyID", SqlDbType.VarChar).Value = dleCompanyId;
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = reqno; 
                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            dlLocation.ClearSelection();
                            dlReportingPoint.ClearSelection();
                            dlCargo.ClearSelection();

                            txtAutoNo.Text = reader["AutoNo"].ToString();
                            txtReqNo.Text = reader["ReqNo"].ToString();
                            string companyId = reader["DLEcodeCompanyID"].ToString();
                            query = "SELECT DLEcodeCompanyID, DLEcodeCompanyName FROM tblDLECompany WHERE DLEcodeCompanyID ='" + companyId + "'";
                            dleSource.SelectCommand = query;
                            dlCompany.DataBind();
                            dlCompany.SelectedValue = companyId;
                            string vesselId = reader["VesselberthID"].ToString();
                            query = "SELECT VesselId, VesselName FROM tblVessel WHERE VesselId ='" + vesselId + "'";
                            vesselSource.SelectCommand = query;
                            dlVessel.DataBind();
                            dlVessel.SelectedValue = vesselId;
                            string locationId = reader["locationID"].ToString();
                            query = "SELECT LocationId,Location FROM [tblLocation] WHERE LocationId = '" + locationId + "'";
                            locationSource.SelectCommand = query;
                            dlLocation.DataBind();
                            dlLocation.SelectedValue = locationId;
                            string repPoint = reader["ReportpointID"].ToString();
                            query = "SELECT ReportingPointId, ReportingPoint FROM tblReportingPoint WHERE ReportingPointId = '" + repPoint + "'";
                            repPointSource.SelectCommand = query;
                            dlReportingPoint.DataBind();
                            dlReportingPoint.SelectedValue = repPoint;
                            string cargoId = reader["CargoId"].ToString();
                            query = "SELECT CargoId, CargoName FROM tblCargo WHERE CargoId = '" + cargoId + "'";
                            cargoSource.SelectCommand = query;
                            dlCargo.DataBind();
                            dlCargo.SelectedValue = cargoId;
                            string gangId = reader["GangId"].ToString();
                            query = "SELECT GangId, GangName FROM tblGangs WHERE GangId = '" + gangId + "'";
                            gangSource.SelectCommand = query;
                            dlGang.DataBind();
                            dlGang.SelectedValue = gangId;
                            txtJobDescription.Text = reader["job"].ToString();
                            dpRegdate.SelectedDate = Convert.ToDateTime(reader["date_"]);
                            txtNormalHrs.Text = reader["Normal"].ToString();
                            txtOvertimeHrs.Text = reader["Overtime"].ToString();
                            chkHoliday.Checked = Convert.ToBoolean(reader["Weekends"]);
                            chkNight.Checked = Convert.ToBoolean(reader["Night"]);
                            chkApproved.Checked = Convert.ToBoolean(reader["Approved"]);
                            ViewState["Approved"] = reader["Approved"].ToString(); //use to validate if cost sheet is approved or not instead of enabled checkbox
                            dpApprovalDate.SelectedDate = Convert.ToDateTime(reader["Adate"]);
                            if (ViewState["Approved"].ToString() == "True" && request != "load")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "approved", "toastr.error('Cost Sheet Approved...Changes Not Allowed', 'Error');", true);
                            }

                            chkShipSide.Checked = Convert.ToBoolean(reader["OnBoardAllowance"]);

                            tpNormalFrom.SelectedDate = DateTime.SpecifyKind(DateTime.Parse(reader["NormalHrsFrom"].ToString()), DateTimeKind.Utc);
                            tpNormalTo.SelectedDate = DateTime.SpecifyKind(DateTime.Parse(reader["NormalHrsTo"].ToString()), DateTimeKind.Utc);
                            tpOvertimeFrom.SelectedDate = DateTime.SpecifyKind(DateTime.Parse(reader["OvertimeHrsFrom"].ToString()), DateTimeKind.Utc);
                            tpOvertimeTo.SelectedDate = DateTime.SpecifyKind(DateTime.Parse(reader["OvertimeHrsTo"].ToString()), DateTimeKind.Utc);

                            chkProcessed.Checked = Convert.ToBoolean(reader["Processed"]);
                            chkStored.Checked = Convert.ToBoolean(reader["Stored"]);

                            //if (request == "search")
                            //{
                            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            //    txtSearchValue.Text = "";
                            //}
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.warning('Cost Sheet not found', 'Note');", true);
                            txtSearchValue.Focus();
                        }
                        reader.Close();
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (subStaffReqGrid.Items.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "noworker", "toastr.error('Cannnot Update Hours...No worker on this cost sheet', 'Not Updated');", true);
                return;
            }
            if (Convert.ToDouble(txtNormalHrs.Text.Trim()) != 8.0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cannot Update..... Normal hours should not be more or less than 8', 'Error');", true);
                return;
            }
            if (ViewState["Approved"].ToString() == "True")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet Approved...Changes Not Allowed', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spUpdateDailyReqHours", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@Normal", SqlDbType.Float).Value = txtNormalHrs.Text;
                    command.Parameters.Add("@Overtime", SqlDbType.Float).Value = txtOvertimeHrs.Text;
                    command.Parameters.Add("@Hourby", SqlDbType.VarChar).Value = User.Identity.Name;
                    command.Parameters.Add("@HourDate", SqlDbType.DateTime).Value = DateTime.UtcNow;
                    command.Parameters.Add("@NormalHrsFrom", SqlDbType.Time).Value = tpNormalFrom.SelectedTime;
                    command.Parameters.Add("@NormalHrsTo", SqlDbType.Time).Value = tpNormalTo.SelectedTime;
                    command.Parameters.Add("@OvertimeHrsFrom", SqlDbType.Time).Value = tpOvertimeFrom.SelectedTime;
                    command.Parameters.Add("@OvertimeHrsTo", SqlDbType.Time).Value = tpOvertimeTo.SelectedTime;
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = txtReqNo.Text;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Hours Updated Successfully', 'Success');", true);
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "newModal();", true);
                            
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void subStaffReqGrid_DataBound(object sender, EventArgs e)
        {
            lblGangs.InnerText = "Total Members : " + subStaffReqGrid.Items.Count;
        }


        protected void btnPrint_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(txtReqNo.Text))
            {
                string startdate = dpRegdate.SelectedDate.Value.ToString();
                string enddate = dpRegdate.SelectedDate.Value.ToShortDateString() + " 11:59:59 PM";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Daily/General/vwDailyCostSheet.aspx?reqno=" + txtReqNo.Text + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string query = "select AutoNo,ReqNo,DLEcodeCompanyID,VesselberthID,locationID,ReportpointID,cargoID,gangID,job,date_,Normal,Overtime,Weekends,Night,Approved,Adate,OnBoardAllowance,NormalHrsFrom,NormalHrsTo,OvertimeHrsFrom,OvertimeHrsTo, Processed,Stored from tblStaffReq where DLEcodeCompanyID IN (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) AND ReqNo=@ReqNo";
            loadReqNo(txtSearchValue.Text.Trim(), query,"search");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
            txtSearchValue.Text = "";
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            string query = "select top(1) AutoNo,ReqNo,DLEcodeCompanyID,VesselberthID,locationID,ReportpointID,cargoID,gangID,job,date_,Normal,Overtime,Weekends,Night,Approved,Adate,OnBoardAllowance,NormalHrsFrom,NormalHrsTo,OvertimeHrsFrom,OvertimeHrsTo, Processed,Stored from tblStaffReq where DLEcodeCompanyID IN (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) AND ReqNo<@ReqNo and Normal = 0 order by reqno desc";
            loadReqNo(txtReqNo.Text, query, "loop");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            string query = "select top(1) AutoNo,ReqNo,DLEcodeCompanyID,VesselberthID,locationID,ReportpointID,cargoID,gangID,job,date_,Normal,Overtime,Weekends,Night,Approved,Adate,OnBoardAllowance,NormalHrsFrom,NormalHrsTo,OvertimeHrsFrom,OvertimeHrsTo, Processed,Stored from tblStaffReq where DLEcodeCompanyID IN (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) AND ReqNo>@ReqNo and Normal = 0 order by reqno";
            loadReqNo(txtReqNo.Text, query, "loop");
        }

        protected void btnComments_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Operations/ReqComments.aspx?reqno=" + txtReqNo.Text);
        }
        protected void dlVessel_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["VesselName"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["VesselId"].ToString();
        }

        protected void dlCompany_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["DLEcodeCompanyName"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["DLEcodeCompanyID"].ToString();
        }

        protected void dlReportingPoint_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["ReportingPoint"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["ReportingPointId"].ToString();
        }

        protected void dlLocation_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["Location"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["LocationId"].ToString();
        }

        protected void dlCargo_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["CargoName"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["CargoId"].ToString();
        }

        protected void dlGang_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["GangName"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["GangId"].ToString();
        }
        protected void getCompanyAuditEmail()
        {
            DataTable dt = new DataTable();
            string dleCompanyId = Request.Cookies["dlecompanyId"].Value;
            string query = "SELECT Username, Email FROM vwUsersMain WHERE BaseCompanyId in (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) and Active=1 and Userroles like '%Audit%'";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@DLEcodeCompanyID", SqlDbType.Int).Value = dleCompanyId;
                    try
                    {
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            dt.Load(reader);
                            if (dt.Rows.Count > 0)
                                sendCostSheetEmail(dt, txtReqNo.Text);
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "getEmail", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
        protected void sendCostSheetEmail(DataTable emailList, string reqno)
        {
            try
            {
                string emailAddress = "";
                string mailSubject = "GDLC - COST SHEET";
                string message = "Dear Auditor, " +  "<br><br>";
                message += "Please note that, cost sheet <strong>" + reqno + "</strong> has been confirmed by your Operations Department on the GDLC Client Portal awaiting your approval. Thank you. <br><br> ";
                message += "<strong><a href='https://gdlcwave.com/' target='_blank'>Click here</a></strong> to log on to the client portal for more details. <br /><br />";
                message += "<strong>This is an auto generated email. Please do not reply.</strong>";
                MailMessage myMessage = new MailMessage();
                myMessage.From = (new MailAddress("admin@gdlcwave.com", "GDLC Client Portal"));
                foreach (DataRow dr in emailList.Rows)
                {
                    emailAddress = dr.Field<string>("Email");
                    if (!String.IsNullOrEmpty(emailAddress))
                    {
                        myMessage.To.Add(new MailAddress(emailAddress));
                    }
                }
                //myMessage.Bcc.Add(new MailAddress("daniel.wiredu@eupacwebs.com"));
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
        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (Convert.ToDouble(txtNormalHrs.Text.Trim()) != 8.0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cannot Confirm..... Normal hours should not be more or less than 8', 'Error');", true);
                return;
            }

            getCompanyAuditEmail();

            //if (chkConfirmed.Checked)
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet Already Confirmed...', 'Error');", true);
            //    return;
            //}
            //if (String.IsNullOrEmpty(txtAutoNo.Text))
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet not found', 'Error');", true);
            //    return;
            //}
            //using (SqlConnection connection = new SqlConnection(connectionString))
            //{
            //    using (SqlCommand command = new SqlCommand("spConfirmDailyReq", connection))
            //    {
            //        command.CommandType = CommandType.StoredProcedure;
            //        command.Parameters.Add("@Confirmedby", SqlDbType.VarChar).Value = User.Identity.Name;
            //        command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = txtReqNo.Text;
            //        command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            //        try
            //        {
            //            connection.Open();
            //            command.ExecuteNonQuery();
            //            int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
            //            if (retVal == 0)
            //            {
            //                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Confirmed Successfully', 'Success');", true);
            //                chkConfirmed.Checked = true;
            //            }
            //        }
            //        catch (SqlException ex)
            //        {
            //            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            //        }
            //    }
            //}
        }
    }
}