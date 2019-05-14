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
using System.IO;

namespace GDLC_DLEPortal.Downloads
{
    public partial class Invoices : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void invoiceGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Download")
            {
                GridDataItem item = e.Item as GridDataItem;
                string fileName = item["FileName"].Text;
                string filePath = item["FilePath"].Text;
                string fileType = item["FileType"].Text;
                if (!String.IsNullOrEmpty(filePath))
                {
                    try
                    {
                        //Response.Clear();
                        //Response.Charset = "";
                        Response.ContentType = fileType;
                        Response.AddHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");
                        Response.TransmitFile(Server.MapPath(filePath));
                        Response.End();

                        //HttpContext.Current.Response.Flush(); // Sends all currently buffered output to the client.
                        //HttpContext.Current.Response.SuppressContent = true;  // Gets or sets a value indicating whether to send HTTP content to the client.
                        //HttpContext.Current.ApplicationInstance.CompleteRequest(); // Causes ASP.NET to bypass all events and filtering in the HTTP pipeline chain of execution and directly execute the EndRequest event.

                        //Response.Clear();
                        //Response.Buffer = true;
                        //Response.Charset = "";
                        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
                        //Response.ContentType = fileType;
                        //Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
                        //Response.Flush();
                        //Response.End();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Document not found', 'Error');", true);
                }

            }
        }

        protected void txtSearchStaffReq_TextChanged(object sender, EventArgs e)
        {
            invoiceGrid.Rebind();
        }
    }
}