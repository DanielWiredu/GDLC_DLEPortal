using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace GDLC_DLEPortal.GDLCAdmin.Operations
{
    public partial class WeeklyStaffReq : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearchStaffReq_TextChanged(object sender, EventArgs e)
        {
            weeklyStaffReqGrid.Rebind();
        }

        protected void weeklyStaffReqGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/GDLCAdmin/Operations/EditWeeklyReq.aspx?reqno=" + item["ReqNo"].Text);
            }
        }
    }
}