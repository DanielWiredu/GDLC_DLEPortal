﻿using System;
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
    public partial class vwWeeklyCostSheet_All_ByCompany : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            string cachedReports = "rptWeeklyCostSheet_All_ByCompany";
            if (Session[cachedReports] == null)
            {
                loadReport(cachedReports);
            }
            else
            {
                WeeklyCostSheetReport_All_ByCompany.ReportSource = Session[cachedReports];
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loadReport(string cachedReports)
        {
            rptWeeklyCostSheet rpt = new rptWeeklyCostSheet();
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectionString);
            SqlDataAdapter adapter = new SqlDataAdapter();
            DataSet ds = new DataSet();

            string startdate = Request.QueryString["st"].ToString();
            string enddate = Request.QueryString["ed"].ToString();
            string dleCompanyId = Request.QueryString["comps"].ToString(); ;
            adapter = new SqlDataAdapter("select * from vwWeeklyCostSheet where DLEcodeCompanyID IN (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) AND (date_ between @startdate and @enddate)", connection);
            adapter.SelectCommand.Parameters.Add("@DLEcodeCompanyID", SqlDbType.VarChar).Value = dleCompanyId;
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
            Session[cachedReports] = rpt;
            WeeklyCostSheetReport_All_ByCompany.ReportSource = rpt;
        }
    }
}