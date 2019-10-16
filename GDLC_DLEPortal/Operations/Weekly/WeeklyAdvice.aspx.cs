using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using Telerik.Web.UI;

namespace GDLC_DLEPortal.Operations.Weekly
{
    public partial class WeeklyAdvice : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
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
                Response.Redirect("/Operations/Weekly/EditWeeklyAdvice.aspx?adviceno=" + item["AdviceNo"].Text);
            }
        }

        protected void weeklyAdviceGrid_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            GridDataItem item = e.Item as GridDataItem;
            string adviceno = item["AdviceNo"].Text;
            CheckBox chk = item["Processed"].Controls[0] as CheckBox;
            bool approved = chk.Checked;
            if (approved)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Labour Adive has been processed...Cannot Delete', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spDeleteLabourAdvice", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@AdviceNo", SqlDbType.VarChar).Value = adviceno;
                    command.Parameters.Add("@DeleteBy", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
    }
}