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
    public partial class TradeType : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            tradetypeGrid.MasterTableView.ExportToExcel();
        }

        protected void btnPDFExport_Click(object sender, EventArgs e)
        {
            tradetypeGrid.MasterTableView.ExportToPdf();
        }

        protected void tradetypeGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["ID"] = item["TradetypeID"].Text;
                txtTradeType1.Text = item["TradetypeNAME"].Text;
                txtNotes1.Text = item["TRNOTE"].Text;
                dlTradeGroup1.SelectedValue = item["TradegroupID"].Text;
                txtPrefix1.Text = item["prefixname"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
                e.Canceled = true;
            }
        }

    }
}