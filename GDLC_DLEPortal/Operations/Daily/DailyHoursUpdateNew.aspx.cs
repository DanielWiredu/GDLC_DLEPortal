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

namespace GDLC_DLEPortal.Operations.Daily
{
    public partial class DailyHoursUpdateNew : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = "select AutoNo,ReqNo,DLEcodeCompanyName,VesselName,Location,ReportingPoint,CargoName,GangName,job,date_,Normal,Overtime,Weekends,Night,Approved,Adate,OnBoardAllowance,NormalHrsFrom,NormalHrsTo,OvertimeHrsFrom,OvertimeHrsTo, Processed,Stored from vwDailyReq where DLEcodeCompanyID = @DLEcodeCompanyID AND ReqNo=@ReqNo";
                string reqno = Request.QueryString["reqno"].ToString();
                if (!String.IsNullOrEmpty(reqno))
                    loadReqNo(reqno, query, "load");
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
                    command.Parameters.Add("@DLEcodeCompanyID", SqlDbType.Int).Value = dleCompanyId;
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = reqno; 
                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            txtAutoNo.Text = reader["AutoNo"].ToString();
                            txtReqNo.Text = reader["ReqNo"].ToString();
                            txtDLECompany.Text = reader["DLEcodeCompanyName"].ToString();
                            txtVessel.Text = reader["VesselName"].ToString();
                            txtLocation.Text = reader["Location"].ToString();
                            txtReportingPoint.Text = reader["ReportingPoint"].ToString();
                            txtCargo.Text = reader["CargoName"].ToString();
                            txtGang.Text = reader["GangName"].ToString();
                            txtJobDescription.Text = reader["job"].ToString();
                            dpRegdate.SelectedDate = Convert.ToDateTime(reader["date_"]);
                            txtNormalHrs.Text = reader["Normal"].ToString();
                            txtOvertimeHrs.Text = reader["Overtime"].ToString();
                            chkHoliday.Checked = Convert.ToBoolean(reader["Weekends"]);
                            chkNight.Checked = Convert.ToBoolean(reader["Night"]);
                            chkApproved.Checked = Convert.ToBoolean(reader["Approved"]);
                            ViewState["Approved"] = reader["Approved"].ToString(); //use to validate if cost sheet is approved or not instead of enabled checkbox
                            if (ViewState["Approved"].ToString() == "True")
                            {
                                dpApprovalDate.SelectedDate = Convert.ToDateTime(reader["Adate"]);
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "approved", "toastr.error('Cost Sheet Approved...Changes Not Allowed', 'Error');", true);
                            }
                            else
                            {
                                dpApprovalDate.SelectedDate = DateTime.UtcNow;
                            }

                            chkShipSide.Checked = Convert.ToBoolean(reader["OnBoardAllowance"]);

                            tpNormalFrom.SelectedDate = DateTime.SpecifyKind(DateTime.Parse(reader["NormalHrsFrom"].ToString()), DateTimeKind.Utc);
                            tpNormalTo.SelectedDate = DateTime.SpecifyKind(DateTime.Parse(reader["NormalHrsTo"].ToString()), DateTimeKind.Utc);
                            tpOvertimeFrom.SelectedDate = DateTime.SpecifyKind(DateTime.Parse(reader["OvertimeHrsFrom"].ToString()), DateTimeKind.Utc);
                            tpOvertimeTo.SelectedDate = DateTime.SpecifyKind(DateTime.Parse(reader["OvertimeHrsTo"].ToString()), DateTimeKind.Utc);

                            chkProcessed.Checked = Convert.ToBoolean(reader["Processed"]);
                            chkStored.Checked = Convert.ToBoolean(reader["Stored"]);

                            if (request == "search")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                                txtSearchValue.Text = "";
                            }
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
            if (Convert.ToDouble(txtNormalHrs.Text.Trim()) <= 0.0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cannot Update Cost Sheet..... Normal hours shold be greater than 0', 'Error');", true);
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
            string query = "select AutoNo,ReqNo,DLEcodeCompanyName,VesselName,Location,ReportingPoint,CargoName,GangName,job,date_,Normal,Overtime,Weekends,Night,Approved,Adate,OnBoardAllowance,NormalHrsFrom,NormalHrsTo,OvertimeHrsFrom,OvertimeHrsTo, Processed,Stored from vwDailyReq where DLEcodeCompanyID = @DLEcodeCompanyID AND ReqNo=@ReqNo";
            loadReqNo(txtSearchValue.Text.Trim(), query,"search");
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            string query = "select top(1) AutoNo,ReqNo,DLEcodeCompanyName,VesselName,Location,ReportingPoint,CargoName,GangName,job,date_,Normal,Overtime,Weekends,Night,Approved,Adate,OnBoardAllowance,NormalHrsFrom,NormalHrsTo,OvertimeHrsFrom,OvertimeHrsTo, Processed,Stored from vwDailyReq where DLEcodeCompanyID = @DLEcodeCompanyID AND ReqNo<@ReqNo and Normal = 0 order by reqno desc";
            loadReqNo(txtReqNo.Text, query, "load");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            string query = "select top(1) AutoNo,ReqNo,DLEcodeCompanyName,VesselName,Location,ReportingPoint,CargoName,GangName,job,date_,Normal,Overtime,Weekends,Night,Approved,Adate,OnBoardAllowance,NormalHrsFrom,NormalHrsTo,OvertimeHrsFrom,OvertimeHrsTo, Processed,Stored from vwDailyReq where DLEcodeCompanyID = @DLEcodeCompanyID AND ReqNo>@ReqNo and Normal = 0 order by reqno";
            loadReqNo(txtReqNo.Text, query, "load");
        }

        protected void btnComments_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Operations/ReqComments.aspx?reqno=" + txtReqNo.Text);
        }
    }
}