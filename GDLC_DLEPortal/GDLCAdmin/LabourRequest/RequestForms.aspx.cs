using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace GDLC_DLEPortal.GDLCAdmin.LabourRequest
{
    public partial class RequestForms : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
       
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void txtSearchReq_TextChanged(object sender, EventArgs e)
        {
            RequestGrid.Rebind();
        }

        protected void RequestGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/GDLCAdmin/LabourRequest/EditRequestForm.aspx?requestNo=" + item["RequestNo"].Text);
            }
        }
    }
}