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
                dpStartDate.SelectedDate = DateTime.UtcNow;
                dpEndDate.SelectedDate = DateTime.UtcNow;

                dpStartDateByCompany.SelectedDate = DateTime.UtcNow;
                dpEndDateByCompany.SelectedDate = DateTime.UtcNow;
            }
        }

        protected void btnProcess_Click(object sender, EventArgs e)
        {
            string startdate = dpStartDate.SelectedDate.Value.ToString();
            string enddate = dpEndDate.SelectedDate.Value.ToShortDateString() + " 11:59:59 PM";

            if (dlReportType.SelectedText == "Daily Cost Sheet")
            {
                //string reqno = "";
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Daily/General/vwDailyCostSheet.aspx?reqno=" + reqno + "&st=" + startdate + "&ed=" + enddate + "');", true);

                if (Session["rptDailyCostSheet_All"] != null)
                    Session.Remove("rptDailyCostSheet_All");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Daily/General/vwDailyCostSheet_All.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Daily Processed")
            {
                if (Session["rptDailyProcessed"] != null)
                    Session.Remove("rptDailyProcessed");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Daily/Approved/vwDailyProcessed.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Daily Invoice")
            {
                if (Session["rptDailyInvoice"] != null)
                    Session.Remove("rptDailyInvoice");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Daily/Approved/vwDailyInvoice.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }

        }
        protected void btnReportByCompany_Click(object sender, EventArgs e)
        {
            string dleCompanyIds = "";
            foreach (RadComboBoxItem item in dlCompany.CheckedItems)
            {
                dleCompanyIds += item.Value + ",";
            }
            dleCompanyIds = dleCompanyIds.TrimEnd(',');

            string startdate = dpStartDateByCompany.SelectedDate.Value.ToString();
            string enddate = dpEndDateByCompany.SelectedDate.Value.ToShortDateString() + " 11:59:59 PM";

            if (dlReportTypeByCompany.SelectedText == "Daily Cost Sheet")
            {
                if (Session["rptDailyCostSheet_All_ByCompany"] != null)
                    Session.Remove("rptDailyCostSheet_All_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Daily/General/vwDailyCostSheet_All_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportTypeByCompany.SelectedText == "Daily Processed")
            {
                if (Session["rptDailyProcessed_ByCompany"] != null)
                    Session.Remove("rptDailyProcessed_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Daily/Approved/vwDailyProcessed_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportTypeByCompany.SelectedText == "Daily Invoice")
            {
                if (Session["rptDailyInvoice_ByCompany"] != null)
                    Session.Remove("rptDailyInvoice_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Daily/Approved/vwDailyInvoice_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
        }
    }
}