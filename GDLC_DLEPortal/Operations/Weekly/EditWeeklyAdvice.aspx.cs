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
    public partial class EditWeeklyAdvice : System.Web.UI.Page
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
                //if (!dleCompanyId.Contains(","))
                //{
                //    dlCompany.SelectedValue = dleCompanyId;
                //    dlCompany.Enabled = false;
                //}

                dpDate.SelectedDate = DateTime.UtcNow;

                workersGrid.DataSource = new DataTable();
                //workersGrid.DataBind();

                //load Req Details
                loadAdviceNo(Request.QueryString["adviceno"].ToString(), "load");
            }
        }
        protected void loadAdviceNo(string adviceno, string request)
        {
            string dleCompanyId = Request.Cookies.Get("dlecompanyId").Value;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetLabourAdviceNoDetails", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@AdviceNo", SqlDbType.VarChar).Value = adviceno;
                    command.Parameters.Add("@companies", SqlDbType.VarChar).Value = dleCompanyId;
                    command.Parameters.Add("@request", SqlDbType.VarChar).Value = request;
                    command.Parameters.Add("@AutoNo", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@ReturnAdviceNo", SqlDbType.VarChar, 20).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@DLEcodeCompanyID", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@WorkerID", SqlDbType.VarChar, 10).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@TradegroupID", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@TradetypeID", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@ReportingpointID", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@LocationID", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@job", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@date_", SqlDbType.DateTime).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@Processed", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar, 10).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@WorkerName", SqlDbType.VarChar, 80).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@TradeGroup", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@TradeCategory", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    //command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        string autoNo = command.Parameters["@AutoNo"].Value.ToString();
                        if (!String.IsNullOrEmpty(autoNo))
                        {
                            txtAdviceNo.Text = command.Parameters["@ReturnAdviceNo"].Value.ToString();
                            txtReqNo.Text = command.Parameters["@ReqNo"].Value.ToString();
                            txtWorkerId.Text = command.Parameters["@WorkerID"].Value.ToString();
                            hfTradegroup.Value = command.Parameters["@TradegroupID"].Value.ToString();
                            hfTradetype.Value = command.Parameters["@TradetypeID"].Value.ToString();
                            txtJobDescription.Text = command.Parameters["@job"].Value.ToString();
                            dpRegdate.SelectedDate = Convert.ToDateTime(command.Parameters["@date_"].Value);
                            chkProcessed.Checked = Convert.ToBoolean(command.Parameters["@Processed"].Value);
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
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.warning('Advice not found', 'Note');", true);
                        }

                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
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
                    using (SqlCommand command = new SqlCommand("spToogleAdviceDayTransport", connection))
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
                if (String.IsNullOrEmpty(txtAdviceNo.Text))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Please Save Advice before adding days worked', 'Error');", true);
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

                tpHrsFrom1.SelectedDate = DateTime.SpecifyKind(DateTime.Parse(item["HrsFrom"].Text), DateTimeKind.Utc);
                tpHrsTo1.SelectedDate = DateTime.SpecifyKind(DateTime.Parse(item["HrsTo"].Text), DateTimeKind.Utc);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
            }
        }
        protected DataTable GetDataTable()
        {
            DataTable dt = new DataTable();
            string query = "SELECT top(500) [WorkerID], [SName], [OName], [GangName], [TradegroupID], [TradegroupNAME], [TradetypeID], [TradetypeNAME], [flags] FROM [vwWorkers] WHERE WorkerID LIKE '% ' @SearchValue + '%'";
            if (rdSearchType.SelectedValue == "WorkerID")
                query = "SELECT top(500) [WorkerID], [SName], [OName], [GangName], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [flags] FROM [vwWorkers] WHERE WorkerID LIKE '%' + @SearchValue + '%'";
            else if (rdSearchType.SelectedValue == "Gang")
                query = "SELECT top(500) [WorkerID], [SName], [OName], [GangName], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [flags] FROM [vwWorkers] WHERE GangName LIKE '%' + @SearchValue + '%'";
            else if (rdSearchType.SelectedValue == "Surname")
                query = "SELECT top(500) [WorkerID], [SName], [OName], [GangName], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [flags] FROM [vwWorkers] WHERE SName LIKE '%' + @SearchValue + '%' ORDER BY [OName]";
            else if (rdSearchType.SelectedValue == "Othernames")
                query = "SELECT top(500) [WorkerID], [SName], [OName], [GangName], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [flags] FROM [vwWorkers] WHERE OName LIKE '%' + @SearchValue + '%' ORDER BY [SName]";
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

                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeWorkersModal();", true);

                e.Canceled = true;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //workersGrid.MasterTableView.AllowSorting = true;
            //workersGrid.MasterTableView.AllowFilteringByColumn = true;
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
            if (chkProcessed.Checked)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Advice already processed...Changes Not Allowed', 'Error');", true);
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
                using (SqlCommand command = new SqlCommand("spUpdateLabourAdvice", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@DLEcodeCompanyID", SqlDbType.Int).Value = dlCompany.SelectedValue;
                    command.Parameters.Add("@WorkerID", SqlDbType.VarChar).Value = txtWorkerId.Text;
                    command.Parameters.Add("@TradegroupID", SqlDbType.Int).Value = hfTradegroup.Value;
                    command.Parameters.Add("@TradetypeID", SqlDbType.Int).Value = hfTradetype.Value;
                    command.Parameters.Add("@ReportpointID", SqlDbType.Int).Value = repPointId;
                    command.Parameters.Add("@locationID", SqlDbType.Int).Value = locationId;
                    command.Parameters.Add("@job", SqlDbType.VarChar).Value = txtJobDescription.Text;
                    command.Parameters.Add("@date_", SqlDbType.DateTime).Value = dpRegdate.SelectedDate;
                    command.Parameters.Add("@AdviceNo", SqlDbType.VarChar).Value = txtAdviceNo.Text;
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

        protected void subStaffReqGrid_DataBound(object sender, EventArgs e)
        {
            lblDays.InnerText = "Total Days : " + subStaffReqGrid.Items.Count;
            if (chkProcessed.Checked)
            {
                subStaffReqGrid.Enabled = false;
                btnGenerateCostSheet.Enabled = false;
                btnGenerateCostSheet.ToolTip = "Advice already processed into cost sheet";
            }
            else
            {
                subStaffReqGrid.Enabled = true;
                btnGenerateCostSheet.Enabled = true;
                btnGenerateCostSheet.ToolTip = "";
            }
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

        protected void btnAddDay_Click(object sender, EventArgs e)
        {
            if (Convert.ToDouble(txtNormalHrs.Text.Trim()) != 8.0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cannot Save..... Normal hours should not be more or less than 8', 'Error');", true);
                return;
            }

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
                using (SqlCommand command = new SqlCommand("spAddLabourAdviceDay", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@AdviceNo", SqlDbType.VarChar).Value = txtAdviceNo.Text;
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
                    command.Parameters.Add("@HrsFrom", SqlDbType.Time).Value = tpHrsFrom.SelectedTime;
                    command.Parameters.Add("@HrsTo", SqlDbType.Time).Value = tpHrsTo.SelectedTime;
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
                    }
                }
            }
            btnAddDay.Focus();
        }
        protected void btnUpdateDay_Click(object sender, EventArgs e)
        {
            if (Convert.ToDouble(txtNormalHrs1.Text.Trim()) != 8.0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cannot Save..... Normal hours should not be more or less than 8', 'Error');", true);
                return;
            }

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
                using (SqlCommand command = new SqlCommand("spUpdateLabourAdviceDay", connection))
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
                    command.Parameters.Add("@HrsFrom", SqlDbType.Time).Value = tpHrsFrom1.SelectedTime;
                    command.Parameters.Add("@HrsTo", SqlDbType.Time).Value = tpHrsTo1.SelectedTime;
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
                    }
                }
            }
        }

        protected void workersGrid_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            workersGrid.DataSource = GetDataTable();
        }

        protected void btnGenerateCostSheet_Click(object sender, EventArgs e)
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                if (subStaffReqGrid.Items.Count < 1)
                {
                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('There is no work on the advice. Cannot create cost sheet')", true);
                    return;
                }
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand("spAddWeeklyReqFromAdvice", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@AdviceNo", SqlDbType.VarChar).Value = txtAdviceNo.Text;
                        command.Parameters.Add("@Preparedby", SqlDbType.VarChar).Value = User.Identity.Name;
                        command.Parameters.Add("@ReqNo", SqlDbType.VarChar, 10).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                        try
                        {
                            connection.Open();
                            command.ExecuteNonQuery();
                            string reqno = command.Parameters["@ReqNo"].Value.ToString();
                            int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                            if (retVal == 0)
                            {
                                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "success", "alert('Cost Sheet Created Successfully')", true);
                                txtReqNo.Text = reqno;
                                chkProcessed.Checked = true;
                                btnGenerateCostSheet.Enabled = false;
                                btnGenerateCostSheet.ToolTip = "Advice already processed into cost sheet";
                                subStaffReqGrid.Enabled = false;
                            }
                        }
                        catch (SqlException ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "failure", "alert('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "');", true);
                        }
                    }
                }
            }
        }
        protected void btnFindCostSheet_Click(object sender, EventArgs e)
        {
            txtReqNo.Text = "";
            //dlCompany.ClearSelection();
            dlLocation.ClearSelection();
            dlReportingPoint.ClearSelection();
            loadAdviceNo(txtCostSheet.Text.Trim().ToUpper(), "search");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeCostSheetModal();", true);
            txtCostSheet.Text = "";
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            loadAdviceNo(txtAdviceNo.Text, "previous");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            loadAdviceNo(txtAdviceNo.Text, "next");
        }
    }
}