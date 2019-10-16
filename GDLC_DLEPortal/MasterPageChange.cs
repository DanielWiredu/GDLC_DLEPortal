using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GDLC_DLEPortal
{
    public class MasterPageChange : System.Web.UI.Page
    {
        protected override void OnPreInit(EventArgs e)
        {
            //this.MasterPageFile = "~/Home.Master";
            string accounttype = Request.Cookies["accounttype"].Value;
            if (accounttype != null)    //check the user weather user is logged in or not
            {
                if (accounttype == "GDLC")
                {
                    this.MasterPageFile = "~/Admin.Master";
                }
                else if (accounttype == "Employer")
                {
                    this.MasterPageFile = "~/Home.Master";
                }
            }
            base.OnPreInit(e);
        }
    }
}