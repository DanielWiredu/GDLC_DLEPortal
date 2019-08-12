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
    public partial class Requests : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RequestGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                GridDataItem item = e.Item as GridDataItem;
                lblCompany.InnerText = item["DLEcodeCompanyName"].Text;
                txtRequestNo1.Text = item["RequestNo"].Text;
                txtRequest1.Text = item["Request"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void txtSearchValue_TextChanged(object sender, EventArgs e)
        {
            RequestGrid.Rebind();
        }
    }
}