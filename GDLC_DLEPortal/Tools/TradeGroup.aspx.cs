using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace GDLC_DLEPortal.Tools
{
    public partial class TradeGroup : MasterPageChange
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void tradeGroupGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Rates")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/Tools/TradeGroupRate.aspx?tradeGroupId=" + item["TradegroupID"].Text + "&tradeGroup=" + item["TradegroupNAME"].Text);
            }
        }

        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            tradeGroupGrid.MasterTableView.ExportToExcel();
        }

        protected void btnPDFExport_Click(object sender, EventArgs e)
        {
            tradeGroupGrid.MasterTableView.ExportToPdf();
        }

    }
}