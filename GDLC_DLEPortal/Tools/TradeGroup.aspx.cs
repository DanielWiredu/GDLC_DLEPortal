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

namespace GDLC_DLEPortal.Tools
{
    public partial class TradeGroup : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void tradeGroupGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["ID"] = item["TradegroupID"].Text;
                string query = "select * from tblTradeGroup where TradegroupID=@TradegroupID";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@TradegroupID", SqlDbType.Int).Value = ViewState["ID"].ToString();
                        try
                        {
                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();
                            if (reader.Read())
                            {
                                txtTradeGroup1.Text = reader["TradegroupNAME"].ToString();
                                txtNotes1.Text = reader["DNOTES"].ToString();
                                txtDBWage1.Text = reader["DBWage"].ToString();
                                txtDBWageWknd1.Text = reader["DBWageWkend"].ToString();
                                txtHourOvertimeWkday1.Text = reader["HourOtimeWkday"].ToString();
                                txtHourOvertimeWknd1.Text = reader["HourOtimeWkend"].ToString();
                                txtNightAllowanceWkday1.Text = reader["NAWkday"].ToString();
                                txtNightAllowanceWknd1.Text = reader["NAWkend"].ToString();
                                txtTransportAllowance1.Text = reader["Transport"].ToString();
                                txtDBWageDLE1.Text = reader["DBWageDLE"].ToString();
                                txtDBWageWkndDLE1.Text = reader["DBWageWkendDLE"].ToString();
                                txtHourOvertimeWkdayDLE1.Text = reader["HourOtimeWkdayDLE"].ToString();
                                txtHourOvertimeWkndDLE1.Text = reader["HourOtimeWkendDLE"].ToString();
                                txtNightAllowanceWkdayDLE1.Text = reader["NAWkdayDLE"].ToString();
                                txtNightAllowanceWkndDLE1.Text = reader["NAWkendDLE"].ToString();
                                txtSubsidy1.Text = reader["Subsidy"].ToString();
                                txtPPEMedicals1.Text = reader["PPEMedical"].ToString();
                                txtBussing1.Text = reader["Bussing"].ToString();

                                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
                                e.Canceled = true;
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
        }

        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            tradeGroupGrid.MasterTableView.ExportToExcel();
        }

        protected void btnPDFExport_Click(object sender, EventArgs e)
        {
            tradeGroupGrid.MasterTableView.ExportToPdf();
        }

    }
}