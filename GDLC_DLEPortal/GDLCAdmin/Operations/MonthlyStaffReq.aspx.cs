using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace GDLC_DLEPortal.GDLCAdmin.Operations
{
    public partial class MonthlyStaffReq : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearchStaffReq_TextChanged(object sender, EventArgs e)
        {
            monthlyStaffReqGrid.Rebind();
        }

        protected void monthlyStaffReqGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/GDLCAdmin/Operations/EditMonthlyReq.aspx?reqno=" + item["ReqNo"].Text);
            }
        }
    }
}