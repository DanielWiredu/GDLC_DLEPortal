using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace GDLC_DLEPortal.GDLCAdmin.Operations
{
    public partial class Advice : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void txtSearchStaffReq_TextChanged(object sender, EventArgs e)
        {
            weeklyAdviceGrid.Rebind();
        }
        protected void weeklyAdviceGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/GDLCAdmin/Operations/EditAdvice.aspx?adviceno=" + item["AdviceNo"].Text);
            }
        }
    }
}