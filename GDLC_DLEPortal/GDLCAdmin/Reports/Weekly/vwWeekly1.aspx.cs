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

                dpStartDateByCompany.SelectedDate = DateTime.UtcNow;
                dpEndDateByCompany.SelectedDate = DateTime.UtcNow;
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

                if (Session["rptWeeklyCostSheet_All"] != null)
                    Session.Remove("rptWeeklyCostSheet_All");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Weekly/General/vwWeeklyCostSheet_All.aspx?&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Weekly Processed")
            {
                if (Session["rptWeeklyProcessed"] != null)
                    Session.Remove("rptWeeklyProcessed");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Weekly/Approved/vwWeeklyProcessed.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Weekly Invoice")
            {
                if (Session["rptWeeklyInvoice"] != null)
                    Session.Remove("rptWeeklyInvoice");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Weekly/Approved/vwWeeklyInvoice.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
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

            if (dlReportTypeByCompany.SelectedText == "Weekly Cost Sheet")
            {
                if (Session["rptWeeklyCostSheet_All_ByCompany"] != null)
                    Session.Remove("rptWeeklyCostSheet_All_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Weekly/General/vwWeeklyCostSheet_All_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportTypeByCompany.SelectedText == "Weekly Processed")
            {
                if (Session["rptWeeklyProcessed_ByCompany"] != null)
                    Session.Remove("rptWeeklyProcessed_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Weekly/Approved/vwWeeklyProcessed_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportTypeByCompany.SelectedText == "Weekly Invoice")
            {
                if (Session["rptWeeklyInvoice_ByCompany"] != null)
                    Session.Remove("rptWeeklyInvoice_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/GDLCAdmin/Reports/Weekly/Approved/vwWeeklyInvoice_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
        }
    }
}