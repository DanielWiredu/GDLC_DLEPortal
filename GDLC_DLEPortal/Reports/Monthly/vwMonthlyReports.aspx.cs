using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace GDLC_DLEPortal.Reports.Monthly
{
    public partial class vwMonthlyReports : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpStartDate.SelectedDate = DateTime.UtcNow;
                dpEndDate.SelectedDate = DateTime.UtcNow;
            }
        }

        protected void btnProcess_Click(object sender, EventArgs e)
        {
            //foreach (System.Collections.DictionaryEntry entry in HttpContext.Current.Cache)
            //{
            //    HttpContext.Current.Cache.Remove((string)entry.Key);
            //}

            //Response.Cache.SetExpires(DateTime.Now);
            //Response.Cache.SetNoServerCaching();
            //Response.Cache.SetNoStore();

            string startdate = dpStartDate.SelectedDate.Value.ToString();
            string enddate = dpEndDate.SelectedDate.Value.ToShortDateString() + " 11:59:59 PM";
            if (dlReportType.SelectedText == "Monthly Cost Sheet")
            {
                string reqno = "";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/General/vwMonthlyCostSheet.aspx?reqno=" + reqno + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Monthly Processed")
            {
                if (Cache["rptMonthlyProcessed"] != null)
                    Cache.Remove("rptMonthlyProcessed");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/Approved/vwMonthlyProcessed.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Monthly Invoice")
            {
                if (Cache["rptMonthlyInvoice"] != null)
                    Cache.Remove("rptMonthlyInvoice");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/Approved/vwMonthlyInvoice.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Monthly Invoice Summary")
            {
                if (Cache["rptMonthlyInvoiceSummary"] != null)
                    Cache.Remove("rptMonthlyInvoiceSummary");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/Approved/vwMonthlyInvoiceSummary.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
        }
    }
}