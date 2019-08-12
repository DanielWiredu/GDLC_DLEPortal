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

namespace GDLC_DLEPortal.LabourRequest
{
    public partial class RequestForms : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void txtSearchReq_TextChanged(object sender, EventArgs e)
        {
            RequestGrid.Rebind();
        }

        protected void RequestGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/LabourRequest/EditRequestForm.aspx?requestNo=" + item["RequestNo"].Text);
            }
        }

        protected void RequestGrid_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            GridDataItem item = e.Item as GridDataItem;
            string requestno = item["RequestNo"].Text;
            CheckBox chk = item["Submitted"].Controls[0] as CheckBox;
            bool submitted = chk.Checked;
            if (submitted)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Request Submitted...Cannot Delete', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("Delete from tblLabourRequestForm where RequestNo = @RequestNo", connection))
                {
                    command.Parameters.Add("@RequestNo", SqlDbType.Int).Value = requestno;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
                            RequestGrid.Rebind();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
    }
}