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

namespace GDLC_DLEPortal.Tools
{
    public partial class PayrollSetup : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = "select * from tblPayrollSetup";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        try
                        {
                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();
                            if (reader.Read())
                            {
                                txtUnionDues.Text = reader["UnionDues"].ToString();
                                txtWelfare.Text = reader["Welfare"].ToString();
                                txtSSFEmployee.Text = reader["SSFemployee"].ToString();
                                txtSSFEmployer.Text = reader["SSFemployer"].ToString();
                                txtPFEmployee.Text = reader["ProvidentFundEmployee"].ToString();
                                txtPFEmployer.Text = reader["ProvidentFundEmployer"].ToString();
                                txtAnnualBonus.Text = reader["AnnualBonus"].ToString();
                                txtAnnualLeave.Text = reader["AnnualLeave"].ToString();
                                txtPremShareholder.Text = reader["PremiumShareHolder"].ToString();
                                txtPremNonShareholder.Text = reader["PremiumNonShareHolder"].ToString();
                                txtPremWithoutTransport.Text = reader["PremiumWithoutTT"].ToString();
                                txtTaxOnBonus.Text = reader["TaxOnBonus"].ToString();
                                txtTaxOnBasic.Text = reader["TaxOnBasic"].ToString();
                                txtTaxOnOvertime.Text = reader["TaxOnOvertime"].ToString();
                                txtTaxOnPF.Text = reader["TaxOnProvidentFund"].ToString();
                                txtTaxOnTransport.Text = reader["TaxOnTransport"].ToString();
                                txtOnBoardAllowance.Text = reader["OnBoardAllowance"].ToString();
                                txtVAT.Text = reader["Vat"].ToString();
                                txtGetFund.Text = reader["GetFund"].ToString();
                                txtNHIL.Text = reader["NHIL"].ToString();
                            }
                            reader.Close();
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
}