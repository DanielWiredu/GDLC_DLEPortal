using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using CrystalDecisions.Shared;

namespace GDLC_DLEPortal.Reports.Daily.General
{
    public partial class vwDailyCostSheet_All : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            string cachedReports = "rptDailyCostSheet_All";
            if (Cache[cachedReports] == null)
            {
                loadReport(cachedReports);
            }
            else
            {
                DailyCostSheetReport_All.ReportSource = Cache[cachedReports];
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loadReport(string cachedReports)
        {
            int rptCacheTimeout = Convert.ToInt32(ConfigurationManager.AppSettings.Get("rptCacheTimeout").ToString());
            DailyCostSheet rpt = new DailyCostSheet();
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectionString);
            SqlDataAdapter adapter = new SqlDataAdapter();
            DataSet ds = new DataSet();

            string startdate = Request.QueryString["st"].ToString();
            string enddate = Request.QueryString["ed"].ToString();
            string dleCompanyId = Request.Cookies["dlecompanyId"].Value;
            adapter = new SqlDataAdapter("select * from vwDailyCostSheet where DLEcodeCompanyID IN (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) AND (date_ between @startdate and @enddate)", connection);
            adapter.SelectCommand.Parameters.Add("@DLEcodeCompanyID", SqlDbType.VarChar).Value = dleCompanyId;
            adapter.SelectCommand.Parameters.Add("@startdate", SqlDbType.DateTime).Value = startdate;
            adapter.SelectCommand.Parameters.Add("@enddate", SqlDbType.DateTime).Value = enddate;
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "vwDailyCostSheet");
            rpt.SetDataSource(ds);

            adapter.Dispose();
            connection.Dispose();
            Cache.Insert(cachedReports, rpt, null, DateTime.MaxValue, TimeSpan.FromMinutes(rptCacheTimeout));
            DailyCostSheetReport_All.ReportSource = rpt;
        }
    }
}