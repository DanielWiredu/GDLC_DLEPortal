using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace GDLC_DLEPortal.GDLCAdmin.Reports.Weekly
{
    public partial class vwWeekly1 : MasterPageChange
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
            string startdate = dpStartDate.SelectedDate.Value.ToString();
            string enddate = dpEndDate.SelectedDate.Value.ToShortDateString() + " 11:59:59 PM";

            if (dlReportType.SelectedText == "Weekly Cost Sheet")
            {
                //string reqno = "";
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Weekly/General/vwWeeklyCostSheet.aspx?reqno=" + reqno + "&st=" + startdate + "&ed=" + enddate + "');", true);

                if (Cache["rptWeeklyCostSheet_All"] != null)
                    Cache.Remove("rptWeeklyCostSheet_All");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Weekly/General/vwWeeklyCostSheet_All.aspx?&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Weekly Processed")
            {
                if (Cache["rptWeeklyProcessed"] != null)
                    Cache.Remove("rptWeeklyProcessed");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Weekly/Approved/vwWeeklyProcessed.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Weekly Invoice")
            {
                if (Cache["rptWeeklyInvoice"] != null)
                    Cache.Remove("rptWeeklyInvoice");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Weekly/Approved/vwWeeklyInvoice.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            
        }
    }
}