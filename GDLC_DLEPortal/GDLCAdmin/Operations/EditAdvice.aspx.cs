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

namespace GDLC_DLEPortal.GDLCAdmin.Operations
{
    public partial class EditAdvice : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //load Req Details
                loadAdviceNo(Request.QueryString["adviceno"].ToString(), "loadall");
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

        protected void subStaffReqGrid_DataBound(object sender, EventArgs e)
        {
            lblDays.InnerText = "Total Days : " + subStaffReqGrid.Items.Count;
        }

        protected void btnFindCostSheet_Click(object sender, EventArgs e)
        {
            txtReqNo.Text = "";
            //dlCompany.ClearSelection();
            dlLocation.ClearSelection();
            dlReportingPoint.ClearSelection();
            loadAdviceNo(txtCostSheet.Text.Trim().ToUpper(), "searchall");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeCostSheetModal();", true);
            txtCostSheet.Text = "";
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            loadAdviceNo(txtAdviceNo.Text, "previousall");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            loadAdviceNo(txtAdviceNo.Text, "nextall");
        }
    }
}