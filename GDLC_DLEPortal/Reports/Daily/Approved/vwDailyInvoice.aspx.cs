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
using CrystalDecisions.CrystalReports.Engine;

namespace GDLC_DLEPortal.Reports.Daily.Approved
{
    public partial class vwDailyInvoice : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            string cachedReports = "rptDailyInvoice";

            if (Session[cachedReports] == null)
            {
                ReportDocument rd = new rptDailyInvoiceNew();
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection connection = new SqlConnection(connectionString);
                SqlDataAdapter adapter = new SqlDataAdapter();
                DataSet ds = new DataSet();
                string startdate = Request.QueryString["st"].ToString();
                string enddate = Request.QueryString["ed"].ToString();
                string dleCompanyId = Request.Cookies["dlecompanyId"].Value;
                ParameterValues parameters = new ParameterValues();
                ParameterDiscreteValue sdate = new ParameterDiscreteValue();
                ParameterDiscreteValue edate = new ParameterDiscreteValue();
                sdate.Value = startdate;
                edate.Value = enddate;
                adapter = new SqlDataAdapter("select * from vwDailyInvoice where DLEcodeCompanyID IN (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) AND (Adate between @startdate and @enddate)", connection);
                adapter.SelectCommand.Parameters.Add("@DLEcodeCompanyID", SqlDbType.VarChar).Value = dleCompanyId;
                adapter.SelectCommand.Parameters.Add("@startdate", SqlDbType.DateTime).Value = startdate;
                adapter.SelectCommand.Parameters.Add("@enddate", SqlDbType.DateTime).Value = enddate;
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                adapter.Fill(ds, "vwDailyInvoice");
                //rd.Load(Server.MapPath("rptDailyInvoice.rpt"));
                rd.SetDataSource(ds);
                parameters.Add(sdate);
                rd.DataDefinition.ParameterFields["Startdate"].ApplyCurrentValues(parameters);
                parameters.Add(edate);
                rd.DataDefinition.ParameterFields["Enddate"].ApplyCurrentValues(parameters);
                adapter.Dispose();
                connection.Dispose();
                Session[cachedReports] = rd;
                DailyInvoiceReport.ReportSource = rd;
            }
            else
            {
                DailyInvoiceReport.ReportSource = Session[cachedReports];
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
    }
}