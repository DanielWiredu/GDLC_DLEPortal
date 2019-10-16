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

namespace GDLC_DLEPortal.GDLCAdmin.Operations
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

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            if (hfReqNo.Value.StartsWith("D"))
                Response.Redirect("/GDLCAdmin/Operations/DailyHoursUpdateNew.aspx?reqno=" + hfReqNo.Value);
            else if (hfReqNo.Value.StartsWith("PW"))
                Response.Redirect("/GDLCAdmin/Operations/EditWeeklyReq.aspx?reqno=" + hfReqNo.Value);
            else if (hfReqNo.Value.StartsWith("PM"))
                Response.Redirect("/GDLCAdmin/Operations/EditMonthlyReq.aspx?reqno=" + hfReqNo.Value);
        }
    }
}