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
    public partial class DailyApprovalNew : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        #region
        SqlConnection sc = new SqlConnection(connectionString);
        DataSet ds;
        int Maxrow = 0;
        int inc = 0;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //btnDisapprove.Enabled = User.IsInRole("Administrator") || User.IsInRole("Audit-Disapproval");
                string query = "select AutoNo,ReqNo,DLEcodeCompanyName,VesselName,Location,ReportingPoint,CargoName,GangName,job,date_,Normal,Overtime,Weekends,Night,Approved,Adate,OnBoardAllowance,NormalHrsFrom,NormalHrsTo,OvertimeHrsFrom,OvertimeHrsTo, Processed,Stored from vwDailyReq where DLEcodeCompanyID = @DLEcodeCompanyID AND ReqNo=@ReqNo";
                string reqno = Request.QueryString["reqno"].ToString();
                if (!String.IsNullOrEmpty(reqno))
                    loadReqNo(reqno, query, "load");

                //sc.Open();
                //ds = new DataSet();
                //SqlDataAdapter da = new SqlDataAdapter("select * from Customer", sc);
                //da.Fill(ds, "ad");
                //Navigate();
                //Maxrow = ds.Tables["ad"].Rows.Count;
                
            }
            //btnFind.Focus();
        }
        //private void Navigate()
        //{
        //    DataRow drow = ds.Tables["ad"].Rows[inc];
        //    TextBox1.Text = drow.ItemArray.GetValue(1).ToString();
        //    TextBox2.Text = drow.ItemArray.GetValue(2).ToString();
        //}
        protected void loadReqNo(string reqno, string query, string request)
        {
            string dleCompanyId = Request.Cookies["dlecompanyId"].Value;
            //string query = "select AutoNo,ReqNo,DLEcodeCompanyName,VesselName,Location,ReportingPoint,CargoName,GangName,job,date_,Normal,Overtime,Weekends,Night,Approved,Adate,OnBoardAllowance, Processed,Stored from vwDailyReq where ReqNo=@ReqNo";
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
                            if (Convert.ToDouble(reader["Normal"]) == 0.0)
                                btnApprove.Enabled = false;
                            else
                                btnApprove.Enabled = true;
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

                            //lstItems.Items.Add(DateTime.SpecifyKind(DateTime.Parse(reader["NormalHrsFrom"].ToString()), DateTimeKind.Utc).ToString());
                            //lstItems.Items.Add(DateTime.Parse(reader["NormalHrsFrom"].ToString()).ToString());
                            //lstItems.Items.Add(DateTimeOffset.Parse(reader["NormalHrsFrom"].ToString()).ToString());
                            //lstItems.Items.Add(DateTimeOffset.Parse(reader["NormalHrsFrom"].ToString()).ToUniversalTime().ToString());
                            //lstItems.Items.Add(DateTimeOffset.Parse(reader["NormalHrsFrom"].ToString()).UtcDateTime.ToString());
                            //lstItems.Items.Add(DateTime.Parse(reader["NormalHrsFrom"].ToString()).ToString());
                            //lstItems.Items.Add(DateTimeOffset.Parse(reader["NormalHrsFrom"].ToString()).TimeOfDay.ToString());
                            //lstItems.Items.Add(DateTime.UtcNow.ToString());
                            //lstItems.Items.Add(DateTime.UtcNow.TimeOfDay.ToString());
                            //lstItems.Items.Add(DateTime.Now.ToString());
                            //lstItems.Items.Add(DateTime.Now.TimeOfDay.ToString());
                            //lstItems.Items.Add(DateTimeOffset.UtcNow.ToString());
                            //lstItems.Items.Add(DateTimeOffset.UtcNow.TimeOfDay.ToString());
                            //lstItems.Items.Add(DateTimeOffset.Now.ToString());
                            //lstItems.Items.Add(DateTimeOffset.Now.TimeOfDay.ToString());

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
                            btnApprove.Enabled = true;
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            //if (chkProcessed.Checked)
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cost Sheet Already Processed...', 'Error');", true);
            //    return;
            //}
            if (Convert.ToDouble(txtNormalHrs.Text.Trim()) <= 0.0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cannot approve Cost Sheet..... Normal hours shold be greater than 0', 'Error');", true);
                return;
            }
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
                using (SqlCommand command = new SqlCommand("spApproveDailyReq", connection))
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

        protected void subStaffReqGrid_DataBound(object sender, EventArgs e)
        {
            lblGangs.InnerText = "Total Members : " + subStaffReqGrid.Items.Count;
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
                using (SqlCommand command = new SqlCommand("spDisapproveDailyReq", connection))
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
            loadReqNo(txtSearchValue.Text.Trim(), query, "search");
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            //if (inc > 0)
            //{
            //    inc--;
            //    Navigate();
            //}
            //else
            //{
            //    MessageBox.Show("first ");
            //}
            string query = "select top(1) AutoNo,ReqNo,DLEcodeCompanyName,VesselName,Location,ReportingPoint,CargoName,GangName,job,date_,Normal,Overtime,Weekends,Night,Approved,Adate,OnBoardAllowance,NormalHrsFrom,NormalHrsTo,OvertimeHrsFrom,OvertimeHrsTo, Processed,Stored from vwDailyReq where DLEcodeCompanyID = @DLEcodeCompanyID AND ReqNo<@ReqNo and Approved = 0 order by reqno desc";
            loadReqNo(txtReqNo.Text, query, "load");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            //if (inc != Maxrow - 1)
            //{
            //    inc++;
            //    Navigate();
            //}
            //else
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('No more records', 'Error');", true);
            //}
            string query = "select top(1) AutoNo,ReqNo,DLEcodeCompanyName,VesselName,Location,ReportingPoint,CargoName,GangName,job,date_,Normal,Overtime,Weekends,Night,Approved,Adate,OnBoardAllowance,NormalHrsFrom,NormalHrsTo,OvertimeHrsFrom,OvertimeHrsTo, Processed,Stored from vwDailyReq where DLEcodeCompanyID = @DLEcodeCompanyID AND ReqNo>@ReqNo and Approved = 0 order by reqno";
            loadReqNo(txtReqNo.Text, query, "load");
        }
    }
}