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

namespace GDLC_DLEPortal.Reports.Weekly.Approved
{
    public partial class vwWeeklyInvoice_ByCompany : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            string cachedReports = "rptWeeklyInvoice_ByCompany";

            if (Session[cachedReports] == null)
            {
                ReportDocument rd = new rptWeeklyInvoiceNew();
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection connection = new SqlConnection(connectionString);
                SqlDataAdapter adapter = new SqlDataAdapter();
                DataSet ds = new DataSet();
                string startdate = Request.QueryString["st"].ToString();
                string enddate = Request.QueryString["ed"].ToString();
                string dleCompanyId = Request.QueryString["comps"].ToString();
                ParameterValues parameters = new ParameterValues();
                ParameterDiscreteValue sdate = new ParameterDiscreteValue();
                ParameterDiscreteValue edate = new ParameterDiscreteValue();
                sdate.Value = startdate;
                edate.Value = enddate;
                adapter = new SqlDataAdapter("select * from vwWeeklyInvoice where DLEcodeCompanyID IN (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) AND (Adate between @startdate and @enddate)", connection);
                adapter.SelectCommand.Parameters.Add("@DLEcodeCompanyID", SqlDbType.VarChar).Value = dleCompanyId;
                adapter.SelectCommand.Parameters.Add("@startdate", SqlDbType.DateTime).Value = startdate;
                adapter.SelectCommand.Parameters.Add("@enddate", SqlDbType.DateTime).Value = enddate;
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                adapter.Fill(ds, "vwWeeklyInvoice");
                //rd.Load(Server.MapPath("rptDailyInvoice.rpt"));
                rd.SetDataSource(ds);
                parameters.Add(sdate);
                rd.DataDefinition.ParameterFields["Startdate"].ApplyCurrentValues(parameters);
                parameters.Add(edate);
                rd.DataDefinition.ParameterFields["Enddate"].ApplyCurrentValues(parameters);
                adapter.Dispose();
                connection.Dispose();
                Session[cachedReports] = rd;
                WeeklyInvoiceReport_ByCompany.ReportSource = rd;
            }
            else
            {
                WeeklyInvoiceReport_ByCompany.ReportSource = Session[cachedReports];
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}