﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace GDLC_DLEPortal.Reports.Daily
{
    public partial class DailyCostSheet1 : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpStartDate.SelectedDate = DateTime.Now;
                dpEndDate.SelectedDate = DateTime.Now;

                dpStartDateByCompany.SelectedDate = DateTime.Now;
                dpEndDateByCompany.SelectedDate = DateTime.Now;

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
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Daily/General/vwDailyCostSheet_All.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Daily Processed")
            {
                if (Cache["rptDailyProcessed"] != null)
                    Cache.Remove("rptDailyProcessed");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Daily/Approved/vwDailyProcessed.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportType.SelectedText == "Daily Invoice")
            {
                if (Cache["rptDailyInvoice"] != null)
                    Cache.Remove("rptDailyInvoice");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Daily/Approved/vwDailyInvoice.aspx?st=" + startdate + "&ed=" + enddate + "');", true);
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
                if (Cache["rptDailyCostSheet_All_ByCompany"] != null)
                    Cache.Remove("rptDailyCostSheet_All_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Daily/General/vwDailyCostSheet_All_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportTypeByCompany.SelectedText == "Daily Processed")
            {
                if (Cache["rptDailyProcessed_ByCompany"] != null)
                    Cache.Remove("rptDailyProcessed_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Daily/Approved/vwDailyProcessed_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
            else if (dlReportTypeByCompany.SelectedText == "Daily Invoice")
            {
                if (Cache["rptDailyInvoice_ByCompany"] != null)
                    Cache.Remove("rptDailyInvoice_ByCompany");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Daily/Approved/vwDailyInvoice_ByCompany.aspx?comps=" + dleCompanyIds + "&st=" + startdate + "&ed=" + enddate + "');", true);
            }
        }
    }
}