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
using System.Security.Permissions;

namespace GDLC_DLEPortal.Audit.Approvals
{
    public partial class WeeklyApprovalNew : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDisapprove.Enabled = User.IsInRole("Administrator") || User.IsInRole("Audit-Disapproval"); 
            }
            btnFind.Focus();
        }

        protected void loadReqNo()
        {
            string reqno = txtSearchValue.Text.Trim().ToUpper();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetWeeklyReqNoDetails", connection))
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
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = reqno;
                    command.Parameters.Add("@WorkerName", SqlDbType.VarChar, 80).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@TradeGroup", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@TradeCategory", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@ezwichid", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@Processed", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@Stored", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        dpRegdate.SelectedDate = Convert.ToDateTime(command.Parameters["@date_"].Value);
                        txtAutoNo.Text = command.Parameters["@AutoNo"].Value.ToString();
                        txtReqNo.Text = reqno;
                        txtWorkerId.Text = command.Parameters["@WorkerID"].Value.ToString();
                        hfTradegroup.Value = command.Parameters["@TradegroupID"].Value.ToString();
                        hfTradetype.Value = command.Parameters["@TradetypeID"].Value.ToString();
                        txtJobDescription.Text = command.Parameters["@job"].Value.ToString();
                        chkApproved.Checked = Convert.ToBoolean(command.Parameters["@Approved"].Value);
                        ViewState["Approved"] = Convert.ToBoolean(command.Parameters["@Approved"].Value); //use to validate if cost sheet is approved or not instead of enabled checkbox
                        if (ViewState["Approved"].ToString() == "True")
                        {
                            dpApprovalDate.SelectedDate = Convert.ToDateTime(command.Parameters["@Adate"].Value);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "approved", "toastr.error('Cost Sheet Approved...Changes Not Allowed', 'Error');", true);
                        }
                        else
                        {
                            dpApprovalDate.SelectedDate = DateTime.Now;
                        }
                        txtWorkerName.Text = command.Parameters["@WorkerName"].Value.ToString();
                        txtGroupName.Text = command.Parameters["@TradeGroup"].Value.ToString();
                        txtCategory.Text = command.Parameters["@TradeCategory"].Value.ToString();
                        txtEzwichNo.Text = command.Parameters["@ezwichid"].Value.ToString();

                        string query = "";
                        string companyId = command.Parameters["@DLEcodeCompanyID"].Value.ToString();
                        query = "SELECT DLEcodeCompanyID, DLEcodeCompanyName FROM tblDLECompany WHERE DLEcodeCompanyID ='" + companyId + "'";
                        dleSource.SelectCommand = query;
                        dlCompany.DataBind();
                        dlCompany.SelectedValue = companyId;
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

                        chkProcessed.Checked = Convert.ToBoolean(command.Parameters["@Processed"].Value);
                        chkStored.Checked = Convert.ToBoolean(command.Parameters["@Stored"].Value);

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                        txtSearchValue.Text = "";
                    }
                    catch (Exception ex)
                    {
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet not found', 'Error');", true);
                        //txtReqNo.Text = "";
                        //txtAutoNo.Text = "";
                        //txtWorkerId.Text = "";
                        txtSearchValue.Focus();
                    }
                }
            }
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


        protected void subStaffReqGrid_DataBound(object sender, EventArgs e)
        {
            lblDays.InnerText = "Total Days : " + subStaffReqGrid.Items.Count;
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(txtReqNo.Text))
            {
                string startdate = dpRegdate.SelectedDate.Value.ToString();
                string enddate = dpRegdate.SelectedDate.Value.ToShortDateString() + " 11:59:59 PM";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Weekly/General/vwWeeklyCostSheet.aspx?reqno=" + txtReqNo.Text + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            dlCompany.ClearSelection();
            dlLocation.ClearSelection();
            dlReportingPoint.ClearSelection();
            loadReqNo();
        }
        protected void btnApprove_Click(object sender, EventArgs e)
        {
            //if (chkProcessed.Checked)
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet Already Processed...', 'Error');", true);
            //    return;
            //}
            if (ViewState["Approved"].ToString() == "True")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet Approved...Changes Not Allowed', 'Error');", true);
                return;
            }
            if (String.IsNullOrEmpty(txtAutoNo.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet not found', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spApproveWeeklyReq", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@Adate", SqlDbType.DateTime).Value = dpApprovalDate.SelectedDate;
                    command.Parameters.Add("@Approvedby", SqlDbType.VarChar).Value = User.Identity.Name;
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = txtReqNo.Text;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Approved Successfully', 'Success');", true);
                            chkApproved.Checked = true;
                            ViewState["Approved"] = "True";
                            //btnApprove.Enabled = false;
                            //btnDisapprove.Enabled = true;
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        [PrincipalPermission(SecurityAction.Demand, Role = "Administrator")]
        [PrincipalPermission(SecurityAction.Demand, Role = "Audit-Disapproval")]
        protected void btnDisapprove_Click(object sender, EventArgs e)
        {
            //if (!User.IsInRole("Administrator"))
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('You do not have the privilege to disapprove a cost sheet...Please contact the administrator', 'Error');", true);
            //    return;
            //}
            if (ViewState["Approved"].ToString() == "False")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet not yet Approved...', 'Error');", true);
                return;
            }
            if (chkStored.Checked)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet Stored...Changes Not Allowed', 'Error');", true);
                return;
            }
            //if cost sheet is processed, unprocess(clear approved), save in disapproved, unprocess/disapprove
            //else disapprove
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spDisapproveWeeklyReq", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@Processed", SqlDbType.Bit).Value = chkProcessed.Checked;
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = txtReqNo.Text;
                    command.Parameters.Add("@DisApprovedBy", SqlDbType.VarChar).Value = User.Identity.Name;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Disapproved Successfully', 'Success');", true);
                            chkApproved.Checked = false;
                            ViewState["Approved"] = "False";
                            chkProcessed.Checked = false;
                            //btnApprove.Enabled = false;
                            //btnDisapprove.Enabled = true;
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
    }
}