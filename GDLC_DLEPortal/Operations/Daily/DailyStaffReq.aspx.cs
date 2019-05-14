using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace GDLC_DLEPortal.Operations.Daily
{
    public partial class DailyStaffReq : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearchStaffReq_TextChanged(object sender, EventArgs e)
        {
            dailyStaffReqGrid.Rebind();
        }

        protected void dailyStaffReqGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/Operations/Daily/DailyHoursUpdateNew.aspx?reqno=" + item["ReqNo"].Text);
            }
        }
        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            dailyStaffReqGrid.MasterTableView.ExportToExcel();
        }

        protected void btnPDFExport_Click(object sender, EventArgs e)
        {
            dailyStaffReqGrid.MasterTableView.ExportToPdf();
        }
    }
}