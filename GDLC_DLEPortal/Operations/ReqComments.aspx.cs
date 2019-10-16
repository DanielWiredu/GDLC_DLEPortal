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

namespace GDLC_DLEPortal.Operations
{
    public partial class ReqComments : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfReqNo.Value = Request.QueryString["reqno"].ToString();
            }
        }

        protected void commentGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
            }
        }

        protected void btnSaveComment_Click(object sender, EventArgs e)
        {
            string query = "insert into tblReqComments(reqno,comment,createdby) values(@reqno,@comment,@createdby)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@ReqNo", SqlDbType.VarChar).Value = hfReqNo.Value;
                    command.Parameters.Add("@Comment", SqlDbType.VarChar).Value = txtComment.Text;
                    command.Parameters.Add("@createdby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            commentGrid.Rebind();
                            txtComment.Text = "";
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            if (hfReqNo.Value.StartsWith("D"))
                Response.Redirect("/Operations/Daily/DailyHoursUpdateNew.aspx?reqno=" + hfReqNo.Value);
            else if (hfReqNo.Value.StartsWith("PW"))
                Response.Redirect("/Operations/Weekly/EditWeeklyReq.aspx?reqno=" + hfReqNo.Value);
            else if (hfReqNo.Value.StartsWith("PM"))
                Response.Redirect("/Operations/Monthly/EditMonthlyReq.aspx?reqno=" + hfReqNo.Value);
        }
    }
}