using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace GDLC_DLEPortal
{
    public partial class Dashboard : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string accountType = Request.Cookies.Get("accounttype").Value;
                string dleCompanyId = Request.Cookies.Get("dlecompanyId").Value;
                loadDashboard(accountType, dleCompanyId);
            }
        }
        protected void loadDashboard(string accountType, string dleCompanyId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetDLEDashboard", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@accountType", SqlDbType.VarChar).Value = accountType;
                    command.Parameters.Add("@dleCompanyId", SqlDbType.VarChar).Value = dleCompanyId;
                    command.Parameters.Add("@dailyAll", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@dailyApproved", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@dailyUnapproved", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@users", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        lblDailyAll.InnerText = command.Parameters["@dailyAll"].Value.ToString();
                        lblDailyApproved.InnerText = command.Parameters["@dailyApproved"].Value.ToString();
                        lblDailyUnapproved.InnerText = command.Parameters["@dailyUnapproved"].Value.ToString();
                        lblUsers.InnerText = command.Parameters["@users"].Value.ToString();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
    }
}