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

namespace GDLC_DLEPortal.GDLCAdmin.Reports.Daily.General
{
    public partial class vwDailyCostSheet_All : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            string cachedReports = "rptDailyCostSheet_All";
            if (Session[cachedReports] == null)
            {
                loadReport(cachedReports);
            }
            else
            {
                DailyCostSheetReport_All.ReportSource = Session[cachedReports];
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loadReport(string cachedReports)
        {
            DailyCostSheet rpt = new DailyCostSheet();
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectionString);
            SqlDataAdapter adapter = new SqlDataAdapter();
            DataSet ds = new DataSet();

            string startdate = Request.QueryString["st"].ToString();
            string enddate = Request.QueryString["ed"].ToString();

            adapter = new SqlDataAdapter("select * from vwDailyCostSheet where (date_ between @startdate and @enddate)", connection);
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
            Session[cachedReports] = rpt;
            DailyCostSheetReport_All.ReportSource = rpt;
        }
    }
}