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

                dpStartDateByCompany.SelectedDate = DateTime.UtcNow;
                dpEndDateByCompany.SelectedDate = DateTime.UtcNow;

                string dleCompanyId = Request.Cookies.Get("dlecompanyId").Value;
                dleSource.SelectCommand = "SELECT DLEcodeCompanyID, DLEcodeCompanyName FROM tblDLECompany WHERE DLEcodeCompanyID IN (SELECT * FROM dbo.DLEIdToTable(@DLEcodeCompanyID)) ORDER BY DLEcodeCompanyName";
                dleSource.SelectParameters.Add("DLEcodeCompanyID", DbType.String, dleCompanyId);
                dlCompany.DataBind();
                if (!dleCompanyId.Contains(","))
                {
                    dlCompany.Items.FindItemByValue(dleCompanyId).Checked = true;
                    dlCompany.CheckedItemsTexts = RadComboBoxCheckedItemsTexts.DisplayAllInInput;
                    dlCompany.Enabled = false;
                }
            }
        }

        protected void btnProcess_Click(object sender, EventArgs e)
        {
            string startdate = dpStartDate.SelectedDate.Value.ToString();
            string enddate = dpEndDate.SelectedDate.Value.ToShortDateString() + " 11:59:59 PM";
            if (dlReportType.SelectedText == "Monthly Cost Sheet")
            {
                string reqno = "";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/General/vwMonthlyCostSheet.aspx?reqno=" + reqno + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Monthly Processed")
            {
                if (Session["rptMonthlyProcessed"] != null)
                    Session.Remove("rptMonthlyProcessed");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/Approved/vwMonthlyProcessed.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Monthly Invoice")
            {
                if (Session["rptMonthlyInvoice"] != null)
                    Session.Remove("rptMonthlyInvoice");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/Approved/vwMonthlyInvoice.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Monthly Invoice Summary")
            {
                if (Session["rptMonthlyInvoiceSummary"] != null)
                    Session.Remove("rptMonthlyInvoiceSummary");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/Approved/vwMonthlyInvoiceSummary.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
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

            if (dlReportTypeByCompany.SelectedText == "Monthly Cost Sheet")
            {
                if (Session["rptMonthlyCostSheet_All_ByCompany"] != null)
                    Session.Remove("rptMonthlyCostSheet_All_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/General/vwDMonthlyCostSheet_All_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportTypeByCompany.SelectedText == "Monthly Processed")
            {
                if (Session["rptMonthlyProcessed_ByCompany"] != null)
                    Session.Remove("rptMonthlyProcessed_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/Approved/vwMonthlyProcessed_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportTypeByCompany.SelectedText == "Monthly Invoice")
            {
                if (Session["rptMonthlyInvoice_ByCompany"] != null)
                    Session.Remove("rptMonthlyInvoice_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/Approved/vwMonthlyInvoice_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportTypeByCompany.SelectedText == "Monthly Invoice Summary")
            {
                if (Session["rptMonthlyInvoiceSummary_ByCompany"] != null)
                    Session.Remove("rptMonthlyInvoiceSummary_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Monthly/Approved/vwMonthlyInvoiceSummary_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
        }
    }
}