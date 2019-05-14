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

namespace GDLC_DLEPortal.Operations.Weekly
{
    public partial class NewWeeklyReq : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpRegdate.SelectedDate = DateTime.Now;
                //dpRegdate.FocusedDate = DateTime.Now;
                dpDate.SelectedDate = DateTime.Now;

                workersGrid.DataSource = new DataTable();
                //workersGrid.DataBind();

                txtReqNo.Text = getNewReqNo();
                btnSave.Enabled = true;
            }
        }

        protected string getNewReqNo()
        {
            string reqno = "";
            string userkey = Request.Cookies.Get("userkey").Value;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetNewWeeklyReqNo", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@userKey", SqlDbType.VarChar, 2).Value = userkey;
                    command.Parameters.Add("@WeeklyReqNo", SqlDbType.VarChar, 10).Direction = ParameterDirection.Output;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        reqno = command.Parameters["@WeeklyReqNo"].Value.ToString();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
            return reqno;
        }

        protected void subStaffReqGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {

            if (e.CommandName == "Transport")
            {
                //toogle transport on Cost Sheet
                GridDataItem item = e.Item as GridDataItem;
                string autoId = item["AutoId"].Text;
                string transport = item["transport"].Text;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand("spToogleWorkDayTransport", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@AutoId", SqlDbType.Int).Value = autoId;
                        command.Parameters.Add("@transport", SqlDbType.Char).Value = transport;
                        command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                        try
                        {
                            connection.Open();
                            command.ExecuteNonQuery();
                            int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                            if (retVal == 0)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Transport Toggled', 'Success');", true);
                                subStaffReqGrid.Rebind();
                            }
                        }
                        catch (SqlException ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        }
                    }
                }
            }
            else if (e.CommandName == "InitInsert")
            {
                if (String.IsNullOrEmpty(txtAutoNo.Text))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Please Save ReqNo before adding days worked', 'Error');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "newModal();", true);
                }
                e.Canceled = true;
            }

            else if (e.CommandName == "EditWork")
            {
                var item = subStaffReqGrid.Items[e.CommandArgument.ToString()];
                ViewState["autoId"] = item["AutoId"].Text;
                dpDate1.SelectedDate = Convert.ToDateTime(item["TransDate"].Text);
                txtNormalHrs1.Text = item["Normal"].Text;
                txtOvertimeHrs1.Text = item["Overtime"].Text;
                if (item["Night"].Text == "Night")
                    chkNight1.Checked = true;
                else
                    chkNight1.Checked = false;
                if (item["Holiday"].Text == "Holiday")
                    chkHoliday1.Checked = true;
                else
                    chkHoliday1.Checked = false;
                CheckBox chk = item["OnBoardAllowance"].Controls[0] as CheckBox;
                chkShipSide1.Checked = chk.Checked;
                txtRemarks1.Text = item["Remarks"].Text;

                dlVessel1.ClearSelection();
                string vesselid = item["VesselberthID"].Text;
                vesselSource.SelectCommand = "SELECT VesselId, VesselName FROM tblVessel WHERE VesselId ='" + vesselid + "'";
                dlVessel1.DataBind();
                dlVessel1.SelectedValue = vesselid;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        protected DataTable GetDataTable()
        {
            DataTable dt = new DataTable();
            string query = "SELECT top(500) [WorkerID], [SName], [OName], [GangName], [SSFNo], [TradegroupID], [TradegroupNAME], [TradetypeID], [TradetypeNAME], [NHIS], [flags], [ezwichid] FROM [vwWorkers] WHERE WorkerID LIKE '% ' @SearchValue + '%'";
            if (rdSearchType.SelectedValue == "WorkerID")
                query = "SELECT top(500) [WorkerID], [SName], [OName], [GangName], [SSFNo], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [NHIS], [flags], [ezwichid] FROM [vwWorkers] WHERE WorkerID LIKE '%' + @SearchValue + '%'";
            else if (rdSearchType.SelectedValue == "SSFNo")
                query = "SELECT top(500) [WorkerID], [SName], [OName], [GangName], [SSFNo], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [NHIS], [flags], [ezwichid] FROM [vwWorkers] WHERE SSFNo LIKE '%' + @SearchValue + '%'";
            else if (rdSearchType.SelectedValue == "NHISNo")
                query = "SELECT top(500) [WorkerID], [SName], [OName], [GangName], [SSFNo], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [NHIS], [flags], [ezwichid] FROM [vwWorkers] WHERE NHIS LIKE '%' + @SearchValue + '%'";
            else if (rdSearchType.SelectedValue == "Gang")
                query = "SELECT top(500) [WorkerID], [SName], [OName], [GangName], [SSFNo], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [NHIS], [flags], [ezwichid] FROM [vwWorkers] WHERE GangName LIKE '%' + @SearchValue + '%'";
            else if (rdSearchType.SelectedValue == "Surname")
                query = "SELECT top(500) [WorkerID], [SName], [OName], [GangName], [SSFNo], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [NHIS], [flags], [ezwichid] FROM [vwWorkers] WHERE SName LIKE '%' + @SearchValue + '%' ORDER BY [OName]";
            else if (rdSearchType.SelectedValue == "Othernames")
                query = "SELECT top(500) [WorkerID], [SName], [OName], [GangName], [SSFNo], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [NHIS], [flags], [ezwichid] FROM [vwWorkers] WHERE OName LIKE '%' + @SearchValue + '%' ORDER BY [SName]";
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
                hfTradegroup.Value = item["TradegroupID"].Text;
                txtGroupName.Text = item["TradegroupNAME"].Text;
                hfTradetype.Value = item["TradetypeID"].Text;
                txtCategory.Text = item["TradetypeNAME"].Text;
                txtEzwichNo.Text = item["ezwichid"].Text;

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
            //workersGrid.DataSource = GetDataTable();
            //workersGrid.DataBind();

            workersGrid.MasterTableView.AllowSorting = true;
            workersGrid.MasterTableView.AllowFilteringByColumn = true;
            workersGrid.Rebind();
        }
        protected void dlVessel_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["VesselName"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["VesselId"].ToString();
        }

        protected void dlVessel_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlVessel.Footer.FindControl("vesselCount")).Text = Convert.ToString(dlVessel.Items.Count);
        }

        protected void dlVessel_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(30) VesselId, VesselName FROM tblVessel WHERE VesselName LIKE '%" + e.Text.ToUpper() + "%'";
            vesselSource.SelectCommand = sql;
            dlVessel.DataBind();
        }


        protected void dlVessel1_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["VesselName"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["VesselId"].ToString();
        }

        protected void dlVessel1_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlVessel1.Footer.FindControl("vesselCount1")).Text = Convert.ToString(dlVessel1.Items.Count);
        }

        protected void dlVessel1_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(30) VesselId, VesselName FROM tblVessel WHERE VesselName LIKE '%" + e.Text.ToUpper() + "%'";
            vesselSource.SelectCommand = sql;
            dlVessel1.DataBind();
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
                using (SqlCommand command = new SqlCommand("spAddWeeklyReq", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = txtReqNo.Text;
                    command.Parameters.Add("@DLEcodeCompanyID", SqlDbType.Int).Value = dlCompany.SelectedValue;
                    command.Parameters.Add("@WorkerID", SqlDbType.VarChar).Value = txtWorkerId.Text;
                    command.Parameters.Add("@TradegroupID", SqlDbType.Int).Value = hfTradegroup.Value;
                    command.Parameters.Add("@TradetypeID", SqlDbType.Int).Value = hfTradetype.Value;
                    command.Parameters.Add("@ReportpointID", SqlDbType.Int).Value = repPointId;
                    command.Parameters.Add("@locationID", SqlDbType.Int).Value = locationId;
                    command.Parameters.Add("@job", SqlDbType.VarChar).Value = txtJobDescription.Text;
                    command.Parameters.Add("@date_", SqlDbType.DateTime).Value = dpRegdate.SelectedDate;
                    command.Parameters.Add("@Adate", SqlDbType.DateTime).Value = dpApprovalDate.SelectedDate;
                    command.Parameters.Add("@Preparedby", SqlDbType.VarChar).Value = User.Identity.Name;
                    command.Parameters.Add("@AutoNo", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        long autoID = Convert.ToInt64(command.Parameters["@AutoNo"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            txtAutoNo.Text = autoID.ToString();
                            btnPrint.Enabled = true;
                            btnPrintCopy.Enabled = true;
                            btnSave.Enabled = false;
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

        protected void subStaffReqGrid_DataBound(object sender, EventArgs e)
        {
            lblDays.InnerText = "Total Days : " + subStaffReqGrid.Items.Count;
        }

        protected void subStaffReqGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(txtReqNo.Text))
            {
                string startdate = dpRegdate.SelectedDate.Value.ToString();
                string enddate = dpRegdate.SelectedDate.Value.ToShortDateString() + " 11:59:59 PM";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Weekly/General/vwWeeklyCostSheet.aspx?reqno=" + txtReqNo.Text + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
        }

        protected void btnAddDay_Click(object sender, EventArgs e)
        {
            int vesselId = 0;
            if (!String.IsNullOrEmpty(dlVessel.SelectedValue))
                vesselId = Convert.ToInt32(dlVessel.SelectedValue);

            string weekend = "";
            DateTime workdate = dpDate.SelectedDate.Value;
            if (workdate.DayOfWeek == DayOfWeek.Saturday || workdate.DayOfWeek == DayOfWeek.Sunday || chkHoliday.Checked)
                weekend = "Weekend";
            string night = "";
            if (chkNight.Checked)
                night = "Night";
            string holiday = "";
            if (chkHoliday.Checked)
                holiday = "Holiday";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spAddSubStaffWReq", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = txtReqNo.Text;
                    command.Parameters.Add("@TransDate", SqlDbType.DateTime).Value = dpDate.SelectedDate;
                    command.Parameters.Add("@Normal", SqlDbType.Float).Value = txtNormalHrs.Text;
                    command.Parameters.Add("@Overtime", SqlDbType.Float).Value = txtOvertimeHrs.Text;
                    command.Parameters.Add("@Night", SqlDbType.VarChar).Value = night;
                    command.Parameters.Add("@Weekends", SqlDbType.VarChar).Value = weekend;
                    command.Parameters.Add("@Holiday", SqlDbType.VarChar).Value = holiday;
                    command.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
                    command.Parameters.Add("@VesselberthID", SqlDbType.Int).Value = vesselId;
                    command.Parameters.Add("@Transport", SqlDbType.Char).Value = "*";
                    command.Parameters.Add("@OnBoardAllowance", SqlDbType.Bit).Value = chkShipSide.Checked;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            dpDate.SelectedDate = dpDate.SelectedDate.Value.AddDays(1);
                            subStaffReqGrid.Rebind();
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
            btnAddDay.Focus();
        }
        protected void btnUpdateDay_Click(object sender, EventArgs e)
        {
            int vesselId = 0;
            if (!String.IsNullOrEmpty(dlVessel1.SelectedValue))
                vesselId = Convert.ToInt32(dlVessel1.SelectedValue);

            string weekend = "";
            DateTime workdate = dpDate1.SelectedDate.Value;
            if (workdate.DayOfWeek == DayOfWeek.Saturday || workdate.DayOfWeek == DayOfWeek.Sunday || chkHoliday1.Checked)
                weekend = "Weekend";
            string night = "";
            if (chkNight1.Checked)
                night = "Night";
            string holiday = "";
            if (chkHoliday1.Checked)
                holiday = "Holiday";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spUpdateSubStaffWReq", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@TransDate", SqlDbType.DateTime).Value = dpDate1.SelectedDate;
                    command.Parameters.Add("@Normal", SqlDbType.Float).Value = txtNormalHrs1.Text;
                    command.Parameters.Add("@Overtime", SqlDbType.Float).Value = txtOvertimeHrs1.Text;
                    command.Parameters.Add("@Night", SqlDbType.VarChar).Value = night;
                    command.Parameters.Add("@Weekends", SqlDbType.VarChar).Value = weekend;
                    command.Parameters.Add("@Holiday", SqlDbType.VarChar).Value = holiday;
                    command.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = txtRemarks1.Text;
                    command.Parameters.Add("@VesselberthID", SqlDbType.Int).Value = vesselId;
                    command.Parameters.Add("@OnBoardAllowance", SqlDbType.Bit).Value = chkShipSide1.Checked;
                    command.Parameters.Add("@autoId", SqlDbType.Int).Value = ViewState["autoId"].ToString();
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
                            subStaffReqGrid.Rebind();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closeeditModal();", true);
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

        protected void btnPrintCopy_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(txtReqNo.Text))
            {
                string startdate = dpRegdate.SelectedDate.Value.ToString();
                string enddate = dpRegdate.SelectedDate.Value.ToShortDateString() + " 11:59:59 PM";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Weekly/General/vwWeeklyCostSheet_Copy.aspx?reqno=" + txtReqNo.Text + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
        }
        protected void workersGrid_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            workersGrid.DataSource = GetDataTable();
        }
    }
}