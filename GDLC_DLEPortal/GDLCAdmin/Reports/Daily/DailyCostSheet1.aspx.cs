using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace GDLC_DLEPortal.GDLCAdmin.Reports.Daily
{
    public partial class DailyCostSheet1 : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpStartDate.SelectedDate = DateTime.Now;
                dpEndDate.SelectedDate = DateTime.Now;
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

            if (dlReportType.SelectedText == "Daily Cost Sheet")
            {
                //string reqno = "";
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Daily/General/vwDailyCostSheet.aspx?reqno=" + reqno + "&st=" + startdate + "&ed=" + enddate + "');", true);

                if (Cache["rptDailyCostSheet_All"] != null)
                    Cache.Remove("rptDailyCostSheet_All");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Daily/General/vwDailyCostSheet_All.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Daily Processed")
            {
                if (Cache["rptDailyProcessed"] != null)
                    Cache.Remove("rptDailyProcessed");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Daily/Approved/vwDailyProcessed.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Daily Invoice")
            {
                if (Cache["rptDailyInvoice"] != null)
                    Cache.Remove("rptDailyInvoice");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Daily/Approved/vwDailyInvoice.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }

        }

    }
}