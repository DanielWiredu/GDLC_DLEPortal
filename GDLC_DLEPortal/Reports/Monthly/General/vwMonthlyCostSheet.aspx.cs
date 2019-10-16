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

namespace GDLC_DLEPortal.Reports.Monthly.General
{
    public partial class vwMonthlyCostSheet : System.Web.UI.Page
    {
        static string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);
        rptMonthlyCostSheet cryRpt = new rptMonthlyCostSheet();
        protected void Page_Init(object sender, EventArgs e)
        {
            
        }
        protected void Page_Load(object sender, EventArgs e)
        {
           if (!IsPostBack)
            {
                loadReport();
            }
        }
        protected void Page_UnLoad(object sender, EventArgs e)
        {
            cryRpt.Close();
            cryRpt.Dispose();
        }

        protected void MonthlyCostSheetReport_Load(object sender, EventArgs e)
        {
            
        }

        protected void loadReport()
        {
            try
            {
                string startdate = Request.QueryString["st"].ToString();
                string enddate = Request.QueryString["ed"].ToString();
                string reqno = Request.QueryString["reqno"].ToString();


                //TableLogOnInfos crtableLogoninfos = new TableLogOnInfos();
                //TableLogOnInfo crtableLogoninfo = new TableLogOnInfo();
                //ConnectionInfo crConnectionInfo = new ConnectionInfo();
                //Tables CrTables;

                //string path = "/Reports/Monthly/General/rptMonthlyCostSheet.rpt";
                //cryRpt.Load(Server.MapPath(path));

                //cryRpt.SetParameterValue("Startdate", Convert.ToDateTime(startdate));
                //cryRpt.SetParameterValue("Enddate", Convert.ToDateTime(enddate));
                //cryRpt.SetParameterValue("Reqno", reqno);

                //crConnectionInfo.ServerName = "danDBSource";
                //crConnectionInfo.DatabaseName = connStringBuilder.InitialCatalog;
                //crConnectionInfo.UserID = connStringBuilder.UserID;
                //crConnectionInfo.Password = connStringBuilder.Password;

                //CrTables = cryRpt.Database.Tables;
                //foreach (CrystalDecisions.CrystalReports.Engine.Table CrTable in CrTables)
                //{
                //    crtableLogoninfo = CrTable.LogOnInfo;
                //    crtableLogoninfo.ConnectionInfo = crConnectionInfo;
                //    CrTable.ApplyLogOnInfo(crtableLogoninfo);
                //}

                //cryRpt.DataSourceConnections[0].SetConnection(connStringBuilder.DataSource, connStringBuilder.InitialCatalog, connStringBuilder.UserID, connStringBuilder.Password);
                cryRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);

                // Set connection string from config in existing LogonProperties
                //cryRpt.DataSourceConnections[0].LogonProperties.Set("Connection String",ConfigurationManager.AppSettings["ConnectionString"]);

                // Add existing properties to a new collection
                //NameValuePairs2 logonProps = new NameValuePairs2();
                //logonProps.AddRange(cryRpt.DataSourceConnections[0].LogonProperties);

                // Set our new collection to be the defaults
                // This causes Crystal Reports to actually use our changed properties
                //cryRpt.DataSourceConnections[0].SetLogonProperties(logonProps);

                ParameterValues parameters = new ParameterValues();
                ParameterDiscreteValue sdate = new ParameterDiscreteValue();
                ParameterDiscreteValue edate = new ParameterDiscreteValue();
                ParameterDiscreteValue rno = new ParameterDiscreteValue();

                sdate.Value = startdate;
                edate.Value = enddate;
                rno.Value = reqno;

                parameters.Add(sdate);
                cryRpt.DataDefinition.ParameterFields["Startdate"].ApplyCurrentValues(parameters);
                parameters.Add(edate);
                cryRpt.DataDefinition.ParameterFields["Enddate"].ApplyCurrentValues(parameters);
                parameters.Add(rno);
                cryRpt.DataDefinition.ParameterFields["Reqno"].ApplyCurrentValues(parameters);

                MonthlyCostSheetReport.ReportSource = cryRpt;
                //MonthlyCostSheetReport.RefreshReport();

                cryRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Context.Response, false, String.Empty);
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}