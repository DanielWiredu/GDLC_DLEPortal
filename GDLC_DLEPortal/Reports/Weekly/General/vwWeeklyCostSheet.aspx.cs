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

namespace GDLC_DLEPortal.Reports.Weekly.General
{
    public partial class vwWeeklyCostSheet : System.Web.UI.Page
    {
        rptWeeklyCostSheet rpt = new rptWeeklyCostSheet();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Page_UnLoad(object sender, EventArgs e)
        {
            rpt.Close();
            rpt.Dispose();
        }

        protected void WeeklyCostSheetReport_Load(object sender, EventArgs e)
        {
            string startdate = Request.QueryString["st"].ToString();
            string enddate = Request.QueryString["ed"].ToString();
            string reqno = Request.QueryString["reqno"].ToString();
            string dleCompanyId = Request.Cookies["dlecompanyId"].Value;
            adapter = new SqlDataAdapter("select * from vwWeeklyCostSheet where DLEcodeCompanyID IN (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) AND Reqno like '%' + @reqno + '%' and (date_ between @startdate and @enddate)", connection);
            adapter.SelectCommand.Parameters.Add("@DLEcodeCompanyID", SqlDbType.VarChar).Value = dleCompanyId;
            adapter.SelectCommand.Parameters.Add("@reqno", SqlDbType.VarChar).Value = reqno;
            adapter.SelectCommand.Parameters.Add("@startdate", SqlDbType.DateTime).Value = startdate;
            adapter.SelectCommand.Parameters.Add("@enddate", SqlDbType.DateTime).Value = enddate;
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "vwWeeklyCostSheet");
            rpt.SetDataSource(ds);

            adapter.Dispose();
            connection.Dispose();

            WeeklyCostSheetReport.ReportSource = rpt;

            rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Context.Response, false, String.Empty);
        }
    }
}