﻿using System;
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

namespace GDLC_DLEPortal.Operations.Monthly
{
    public partial class EditMonthlyReq : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string dleCompanyId = Request.Cookies.Get("dlecompanyId").Value;
                dleSource.SelectCommand = "SELECT DLEcodeCompanyID, DLEcodeCompanyName FROM tblDLECompany WHERE DLEcodeCompanyID IN (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) ORDER BY DLEcodeCompanyName";
                dleSource.SelectParameters.Add("DLEcodeCompanyID", DbType.String, dleCompanyId);
                dlCompany.DataBind();

                workersGrid.DataSource = new DataTable();
                workersGrid.DataBind();

                //load Req Details
                loadReqNo(Request.QueryString["reqno"].ToString(), "load");

                btnConfirm.Enabled = User.IsInRole("Operations Manager");
            }
        }

        protected void loadReqNo(string reqno, string request)
        {
            string dleCompanyId = Request.Cookies.Get("dlecompanyId").Value;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetMonthlyReqNoDetails", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@AutoNo", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@DLEcodeCompanyID", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@WorkerID", SqlDbType.VarChar, 10).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@TradegroupID", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@TradetypeID", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@ReportingpointID", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@LocationID", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@job", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@date_", SqlDbType.DateTime).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@Adate", SqlDbType.DateTime).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@Approved", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@Confirmed", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@DWkday", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@DWkend", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@DTotal", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@HRWkday", SqlDbType.Float).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@HRWkend", SqlDbType.Float).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@NWkday", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@NWkend", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@Yyyymm", SqlDbType.VarChar, 6).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@PeriodStart", SqlDbType.DateTime).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@PeriodEnd", SqlDbType.DateTime).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = reqno;
                    command.Parameters.Add("@ReturnReqNo", SqlDbType.VarChar, 10).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@request", SqlDbType.VarChar).Value = request;
                    command.Parameters.Add("@companies", SqlDbType.VarChar).Value = dleCompanyId;
                    command.Parameters.Add("@AdviceNo", SqlDbType.VarChar, 20).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@WorkerName", SqlDbType.VarChar, 80).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@TradeGroup", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@TradeCategory", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        string autoNo = command.Parameters["@AutoNo"].Value.ToString();
                        if (!String.IsNullOrEmpty(autoNo))
                        {
                            dlLocation.ClearSelection();
                            dlReportingPoint.ClearSelection();

                            txtAutoNo.Text = autoNo;
                            txtReqNo.Text = command.Parameters["@ReturnReqNo"].Value.ToString();
                            txtAdviceNo.Text = command.Parameters["@AdviceNo"].Value.ToString();
                            txtWorkerId.Text = command.Parameters["@WorkerID"].Value.ToString();
                            dlTradeGroup.SelectedValue = command.Parameters["@TradegroupID"].Value.ToString();
                            hfTradetype.Value = command.Parameters["@TradetypeID"].Value.ToString();
                            txtJobDescription.Text = command.Parameters["@job"].Value.ToString();
                            dpRegdate.SelectedDate = Convert.ToDateTime(command.Parameters["@date_"].Value);
                            dpApprovalDate.SelectedDate = Convert.ToDateTime(command.Parameters["@Adate"].Value);
                            chkApproved.Checked = Convert.ToBoolean(command.Parameters["@Approved"].Value);
                            if (chkApproved.Checked && request != "load")
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "approved", "toastr.error('Cost Sheet Approved...Changes Not Allowed', 'Error');", true);
                            chkConfirmed.Checked = Convert.ToBoolean(command.Parameters["@Confirmed"].Value);
                            txtWorkerName.Text = command.Parameters["@WorkerName"].Value.ToString();
                            txtGroupName.Text = command.Parameters["@TradeGroup"].Value.ToString();
                            txtCategory.Text = command.Parameters["@TradeCategory"].Value.ToString();
                            string query = "";
                            dlCompany.SelectedValue = command.Parameters["@DLEcodeCompanyID"].Value.ToString();
                            string locationId = command.Parameters["@LocationID"].Value.ToString();
                            query = "SELECT LocationId,Location FROM [tblLocation] WHERE LocationId = '" + locationId + "'";
                            locationSource.SelectCommand = query;
                            dlLocation.DataBind();
                            dlLocation.SelectedValue = locationId;
                            string repPoint = command.Parameters["@ReportingpointID"].Value.ToString();
                            query = "SELECT ReportingPointId, ReportingPoint FROM tblReportingPoint WHERE ReportingPointId = '" + repPoint + "'";
                            repPointSource.SelectCommand = query;
                            dlReportingPoint.DataBind();
                            dlReportingPoint.SelectedValue = repPoint;

                            dpPeriod.SelectedDate = DateTime.ParseExact(command.Parameters["@Yyyymm"].Value.ToString(), "yyyyMM", null);
                            dpPeriodStart.SelectedDate = Convert.ToDateTime(command.Parameters["@periodstart"].Value.ToString());
                            dpPeriodEnd.SelectedDate = Convert.ToDateTime(command.Parameters["@periodend"].Value.ToString());
                            txtDaysWkday.Text = command.Parameters["@DWkday"].Value.ToString();
                            txtDaysWkend.Text = command.Parameters["@DWkend"].Value.ToString();
                            txtTotalDays.Text = command.Parameters["@DTotal"].Value.ToString();
                            txtHoursWkday.Text = command.Parameters["@HRWkday"].Value.ToString();
                            txtHoursWkend.Text = command.Parameters["@HRWkend"].Value.ToString();
                            txtNightsWkday.Text = command.Parameters["@NWkday"].Value.ToString();
                            txtNightsWkend.Text = command.Parameters["@NWkend"].Value.ToString();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.warning('Cost Sheet not found', 'Note');", true);
                        }
                        
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected DataTable GetDataTable()
        {
            DataTable dt = new DataTable();
            string query = "SELECT top(100) [WorkerID], [SName], [OName], [GangName], [TradegroupID], [TradegroupNAME], [TradetypeID], [TradetypeNAME], [flags], [DepartmentId] FROM [vwWorkers] WHERE WorkerID LIKE '% ' @SearchValue + '%'";
            if (rdSearchType.SelectedValue == "WorkerID")
                query = "SELECT top(100) [WorkerID], [SName], [OName], [GangName], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [flags], [DepartmentId] FROM [vwWorkers] WHERE WorkerID LIKE '%' + @SearchValue + '%'";
            else if (rdSearchType.SelectedValue == "Gang")
                query = "SELECT top(100) [WorkerID], [SName], [OName], [GangName], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [flags], [DepartmentId] FROM [vwWorkers] WHERE GangName LIKE '%' + @SearchValue + '%'";
            else if (rdSearchType.SelectedValue == "Surname")
                query = "SELECT top(100) [WorkerID], [SName], [OName], [GangName], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [flags], [DepartmentId] FROM [vwWorkers] WHERE SName LIKE '%' + @SearchValue + '%' ORDER BY [OName]";
            else if (rdSearchType.SelectedValue == "Othernames")
                query = "SELECT top(100) [WorkerID], [SName], [OName], [GangName], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [flags], [DepartmentId] FROM [vwWorkers] WHERE OName LIKE '%' + @SearchValue + '%' ORDER BY [SName]";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    adapter.SelectCommand = new SqlCommand(query, connection);
                    adapter.SelectCommand.Parameters.Add("@SearchValue", SqlDbType.VarChar).Value = txtSearchValue.Text.Trim();
                    try
                    {
                        connection.Open();
                        adapter.Fill(dt);
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
            return dt;
        }

        protected void workersGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "AddWorker")
            {
                dlReportingPoint.ClearSelection();
                //get customer's details
                //GridDataItem item = e.Item as GridDataItem;
                var item = workersGrid.Items[e.CommandArgument.ToString()];
                string workerId = item["WorkerID"].Text;
                string flag = item["flags"].Text;
                if (flag != "ACT")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('This Worker " + workerId + " is tagged. Please contact the Administrator', 'Error');", true);
                    e.Canceled = true;
                    return;
                }
                txtWorkerId.Text = item["WorkerID"].Text;
                txtWorkerName.Text = item["SName"].Text + " " + item["OName"].Text;
                dlTradeGroup.SelectedValue = item["TradegroupID"].Text;
                hfTradegroup.Value = item["TradegroupID"].Text;
                txtGroupName.Text = item["TradegroupNAME"].Text;
                hfTradetype.Value = item["TradetypeID"].Text;
                txtCategory.Text = item["TradetypeNAME"].Text;
                string repPoint = item["DepartmentId"].Text;
                repPointSource.SelectCommand = "SELECT ReportingPointId, ReportingPoint FROM tblReportingPoint WHERE ReportingPointId = '" + repPoint + "'";
                dlReportingPoint.DataBind();
                dlReportingPoint.SelectedValue = repPoint;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeWorkersModal();", true);

                //reset Grid
                //workersGrid.DataSource = new DataTable();
                //workersGrid.DataBind();
                //txtSearchValue.Text = "";
                //rdSearchType.SelectedValue = "WorkerID";

                e.Canceled = true;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            workersGrid.DataSource = GetDataTable();
            workersGrid.DataBind();
        }

        protected void dlReportingPoint_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["ReportingPoint"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["ReportingPointId"].ToString();
        }

        protected void dlReportingPoint_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlReportingPoint.Footer.FindControl("repPointCount")).Text = Convert.ToString(dlReportingPoint.Items.Count);
        }

        protected void dlReportingPoint_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(30) ReportingPointId,ReportingPoint FROM [tblReportingPoint] WHERE ReportingPoint LIKE '%" + e.Text.ToUpper() + "%'";
            repPointSource.SelectCommand = sql;
            dlReportingPoint.DataBind();
        }

        protected void dlLocation_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["Location"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["LocationId"].ToString();
        }

        protected void dlLocation_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlLocation.Footer.FindControl("locationCount")).Text = Convert.ToString(dlLocation.Items.Count);
        }

        protected void dlLocation_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(30) LocationId,Location FROM [tblLocation] WHERE Location LIKE '%" + e.Text.ToUpper() + "%'";
            locationSource.SelectCommand = sql;
            dlLocation.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (chkConfirmed.Checked)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet Confirmed...Changes Not Allowed', 'Error');", true);
                return;
            }
            if (chkApproved.Checked)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet Approved...Changes Not Allowed', 'Error');", true);
                return;
            }
            if (dlCompany.SelectedValue == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Select a Company', 'Error');", true);
                return;
            }
            int repPointId = 0;
            if (!String.IsNullOrEmpty(dlReportingPoint.SelectedValue))
                repPointId = Convert.ToInt32(dlReportingPoint.SelectedValue);
            int locationId = 0;
            if (!String.IsNullOrEmpty(dlLocation.SelectedValue))
                locationId = Convert.ToInt32(dlLocation.SelectedValue);

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spUpdateMonthlyReq", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@DLEcodeCompanyID", SqlDbType.Int).Value = dlCompany.SelectedValue;
                    command.Parameters.Add("@WorkerID", SqlDbType.VarChar).Value = txtWorkerId.Text;
                    command.Parameters.Add("@TradegroupID", SqlDbType.Int).Value = dlTradeGroup.SelectedValue;
                    command.Parameters.Add("@TradetypeID", SqlDbType.Int).Value = hfTradetype.Value;
                    command.Parameters.Add("@ReportpointID", SqlDbType.Int).Value = repPointId;
                    command.Parameters.Add("@locationID", SqlDbType.Int).Value = locationId;
                    command.Parameters.Add("@job", SqlDbType.VarChar).Value = txtJobDescription.Text;
                    command.Parameters.Add("@date_", SqlDbType.DateTime).Value = dpRegdate.SelectedDate;
                    command.Parameters.Add("@Preparedby", SqlDbType.VarChar).Value = User.Identity.Name;
                    command.Parameters.Add("@DWkday", SqlDbType.Int).Value = txtDaysWkday.Text;
                    command.Parameters.Add("@DWkend", SqlDbType.Int).Value = txtDaysWkend.Text;
                    command.Parameters.Add("@DTotal", SqlDbType.Int).Value = txtTotalDays.Text;
                    command.Parameters.Add("@HRWkday", SqlDbType.Float).Value = txtHoursWkday.Text;
                    command.Parameters.Add("@HRWkend", SqlDbType.Float).Value = txtHoursWkend.Text;
                    command.Parameters.Add("@NWkday", SqlDbType.Int).Value = txtNightsWkday.Text;
                    command.Parameters.Add("@NWkend", SqlDbType.Int).Value = txtNightsWkend.Text;
                    command.Parameters.Add("@Yyyymm", SqlDbType.VarChar).Value = dpPeriod.SelectedDate.Value.ToString("yyyyMM");
                    command.Parameters.Add("@PeriodStart", SqlDbType.DateTime).Value = dpPeriodStart.SelectedDate;
                    command.Parameters.Add("@PeriodEnd", SqlDbType.DateTime).Value = dpPeriodEnd.SelectedDate;
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = txtReqNo.Text;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Changes Saved Successfully', 'Success');", true);
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        //lblMsg.InnerText = ex.Message.Replace("'", "").Replace("\r\n", "");
                        //lblMsg.Attributes["class"] = "alert alert-danger";
                    }
                }
            }
        }
        protected void btnFindCostSheet_Click(object sender, EventArgs e)
        {
            loadReqNo(txtCostSheet.Text.Trim().ToUpper(), "search");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeCostSheetModal();", true);
            txtCostSheet.Text = "";
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(txtReqNo.Text))
            {
                string startdate = dpRegdate.SelectedDate.Value.ToString();
                string enddate = dpRegdate.SelectedDate.Value.ToShortDateString() + " 11:59:59 PM";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/General/vwMonthlyCostSheet.aspx?reqno=" + txtReqNo.Text + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
        }

        protected void btnComments_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Operations/ReqComments.aspx?reqno=" + txtReqNo.Text);
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            loadReqNo(txtReqNo.Text, "previousconfirm");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            loadReqNo(txtReqNo.Text, "nextconfirm");
        }
        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (chkConfirmed.Checked)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet Already Confirmed...', 'Error');", true);
                return;
            }
            if (String.IsNullOrEmpty(txtAutoNo.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet not found', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spConfirmMonthlyReq", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@Confirmedby", SqlDbType.VarChar).Value = User.Identity.Name;
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = txtReqNo.Text;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Confirmed Successfully', 'Success');", true);
                            chkConfirmed.Checked = true;
                            getCompanyAuditEmail();
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
        protected void btnViewAdvice_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Operations/Monthly/EditMonthlyAdvice.aspx?adviceno=" + txtAdviceNo.Text + "');", true);
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
                    command.Parameters.Add("@DLEcodeCompanyID", SqlDbType.VarChar).Value = dleCompanyId;
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
                string message = "Dear Auditor, " + "<br><br>";
                message += "Please note that, cost sheet <strong>" + reqno + "</strong> has been confirmed by your Operations Supervisor on the GDLC Client Portal awaiting your approval. Thank you. <br><br> ";
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
    }
}