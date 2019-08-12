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
using System.Net.Mail;
using System.IO;

namespace GDLC_DLEPortal.GDLCAdmin.LabourRequest
{
    public partial class EditRequestForm : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string RequestNo = Request.QueryString["requestNo"].ToString();
                string query = "select * from vwLabourRequestForm where RequestNo = @RequestNo";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@RequestNo", SqlDbType.VarChar).Value = RequestNo;
                        try
                        {
                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();
                            if (reader.Read())
                            {
                                txtReqNo.Text = reader["RequestNo"].ToString();
                                txtCompany.Text = reader["DLEcodeCompanyName"].ToString();
                                txtTerminal.Text = reader["Terminal"].ToString();
                                dpReqdate.SelectedDate = Convert.ToDateTime(reader["RequestDate"]);
                                txtVessel.Text = reader["Vessel"].ToString();
                                txtDOA.Text = reader["DOA"].ToString();
                                dlActivity.SelectedText = reader["Activity"].ToString();
                                dlWorkShift.SelectedText = reader["WorkShift"].ToString();
                                chkSubmitted.Checked = Convert.ToBoolean(reader["Submitted"]);
                            }
                            reader.Close();
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
}