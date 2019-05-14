using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Drawing;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace GDLC_DLEPortal.Security
{
    public partial class Users : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void userGrid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                TableCell status = item["ACTIVE"];
                TableCell uname = item["USERNAME"];
                if (status.Text == "True")
                {
                    uname.BackColor = Color.GreenYellow;
                }
                else if (status.Text == "False")
                {
                    uname.BackColor = Color.Pink;
                }

            }
        }

        protected void userGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                //Get the GridEditFormInsertItem(for Editform mode) of the RadGrid  
                GridDataItem dataItem = (GridDataItem)e.Item;

                string userid = dataItem.GetDataKeyValue("ID").ToString();
                TableCell status = dataItem["ACTIVE"];
                string newstatus = null;
                if (status.Text == "True")
                {
                    newstatus = "0";
                }
                else if (status.Text == "False")
                {
                    newstatus = "1";
                }

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "update tblUsers set active = '" + newstatus + "' where ID = '" + userid + "'";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        try
                        {
                            connection.Open();
                            rows = command.ExecuteNonQuery();
                            if (rows > 0)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Active Status Changed Successfully', 'Success');", true);
                                userGrid.Rebind();
                            }
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                            e.Canceled = true;
                        }
                    }
                }
            }

            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/Security/EditUser.aspx?uId=" + item["ID"].Text);
            }
        }

        protected void userGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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
    }
}