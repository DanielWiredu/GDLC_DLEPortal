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

namespace GDLC_DLEPortal.GDLCAdmin.Downloads
{
    public partial class Invoices : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpDateFrom.SelectedDate = DateTime.UtcNow;
                dpDateTo.SelectedDate = DateTime.UtcNow;
            }
        }

        protected void btnSaveFile_Click(object sender, EventArgs e)
        {
            if (dlCompany.SelectedValue == "")
            {
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Select a Company', 'Error');", true);
                showDialog("Select a Company");
                return;
            }
            if (!FileUpload1.HasFile)
            {
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('No file selected', 'Error');", true);
                showDialog("No file selected");
                return;
            }
            string query = "insert into tblFileUploads(DLEcodeCompanyID,FileName,FileType,FilePath,ReportType,DateFrom,DateTo,CreatedBy) values(@DLEcodeCompanyID,@FileName,@FileType,@FilePath,@ReportType,@DateFrom,@DateTo,@CreatedBy)";
            string fname = "", newfilename = "", ftype = "", filepath = "", ext = "";
            int fsize = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        HttpPostedFile file = FileUpload1.PostedFile;
                        fsize = file.ContentLength / 1024;
                        if (fsize > 2048)
                        {
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('File should not be greater than 1MB', 'Error');", true);
                            showDialog("File should not be greater than 2MB");
                            return;
                        }

                        string yr = DateTime.UtcNow.Year.ToString();
                        string mnth = DateTime.UtcNow.Month.ToString();
                        if (mnth.Length == 1)
                            mnth = "0" + mnth;
                        string path = "/Uploads/Invoices/" + yr + mnth + "/";
                        string savepath = Server.MapPath(path);
                        if (!Directory.Exists(savepath))                   // to create the directory if needed
                            Directory.CreateDirectory(savepath);

                        fname = file.FileName;
                        ext = Path.GetExtension(fname);
                        newfilename = dlCompany.Text.Replace(" ","").Replace("/","").Replace("&","") + "_" + dlReportType.SelectedText.Replace(" ","") + "_" + DateTime.UtcNow.ToString("ddMyyyyhhmmssfff") + ext;
                        ftype = file.ContentType;
                        filepath = path + newfilename;
                        file.SaveAs(Server.MapPath(filepath));

                        command.Parameters.Add("@DLEcodeCompanyID", SqlDbType.Int).Value = dlCompany.SelectedValue;
                        command.Parameters.Add("@FileName", SqlDbType.VarChar).Value = newfilename;
                        command.Parameters.Add("@FileType", SqlDbType.VarChar).Value = ftype;
                        command.Parameters.Add("@FilePath", SqlDbType.VarChar).Value = filepath;
                        command.Parameters.Add("@ReportType", SqlDbType.VarChar).Value = dlReportType.SelectedText;
                        command.Parameters.Add("@DateFrom", SqlDbType.DateTime).Value = dpDateFrom.SelectedDate;
                        command.Parameters.Add("@DateTo", SqlDbType.DateTime).Value = dpDateTo.SelectedDate;
                        command.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = User.Identity.Name;

                        connection.Open();
                        int rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            showDialog("Uploaded and Saved Successfully");
                            invoiceGrid.Rebind();

                            dlCompany.ClearSelection();
                            dlReportType.ClearSelection();
                        }
                    }
                    catch (Exception ex)
                    {
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        showDialog(ex.Message.Replace("'", "").Replace("\r\n", ""));
                    }
                }
            }
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
            if (e.CommandName == "Delete")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["Id"] = item["Id"].Text;
                string filePath = item["FilePath"].Text;
                if (!String.IsNullOrEmpty(filePath))
                {
                    clearFilename(filePath);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Document not found', 'Error');", true);
                }
            }
        }
        protected void clearFilename(string path)
        {
            string query = "delete from tblFileUploads where Id=@Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Id", SqlDbType.Int).Value = ViewState["Id"];
                    try
                    {
                        connection.Open();
                        int rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            File.Delete(Server.MapPath(path));  //delete file from directory
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
                            showDialog("File Deleted Successfully");
                            invoiceGrid.Rebind();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }  
            }  
        }
        protected void dlCompany_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["DLEcodeCompanyName"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["DLEcodeCompanyID"].ToString();
        }

        protected void dlCompany_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlCompany.Footer.FindControl("companyCount")).Text = Convert.ToString(dlCompany.Items.Count);
        }

        protected void dlCompany_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(30) DLEcodeCompanyID,DLEcodeCompanyName FROM [tblDLECompany] WHERE DLEcodeCompanyName LIKE '%" + e.Text.ToUpper() + "%' ORDER BY DLEcodeCompanyName";
            dleSource.SelectCommand = sql;
            dlCompany.DataBind();
        }

        protected void txtSearchStaffReq_TextChanged(object sender, EventArgs e)
        {
            invoiceGrid.Rebind();
        }
        protected void showDialog(string message)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(message);
            sb.Append("')};");
            sb.Append("</script>");

            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }
    }
}