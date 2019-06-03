using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Security.Principal;
using System.Net.Mail;
using System.Web.Routing;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace GDLC_DLEPortal
{
    public class Global : System.Web.HttpApplication
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Application_Start(object sender, EventArgs e)
        {
            //RegisterRoutes(RouteTable.Routes);
        }
        //static void RegisterRoutes(RouteCollection routes)
        //{
        //    routes.MapPageRoute("DailyStaffReq", "DailyStaffReq", "~/Operations/Daily/DailyStaffReq.aspx");
        //}

        //protected void Session_Start(object sender, EventArgs e)
        //{
        //    
        //}
        protected void Application_AuthenticateRequest(Object sender, EventArgs e)
        {
            if (HttpContext.Current.User != null)
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    if (HttpContext.Current.User.Identity is FormsIdentity)
                    {
                        FormsIdentity id = (FormsIdentity)HttpContext.Current.User.Identity;
                        FormsAuthenticationTicket ticket = id.Ticket;
                        string userData = ticket.UserData;
                        string[] roles = userData.Split(',');
                        HttpContext.Current.User = new GenericPrincipal(id, roles);
                    }
                }
            }
        }
        void Application_Error(object sender, EventArgs e)
        {
            //Response.TrySkipIisCustomErrors = true;
            if (HttpContext.Current.Server.GetLastError() != null)
            {
                //Exception myException =
                //HttpContext.Current.Server.GetLastError().GetBaseException();
                //string mailSubject = "Error in page " + Request.Url.ToString();
                //string message = Context.User.Identity.Name;
                //message += "<strong> (Message)</strong><br />" + myException.Message + "<br />";
                //message += "<strong>Stack Trace</strong><br />" + myException.StackTrace + "<br />";
                //message += "<strong>Query String</strong><br />" +
                //Request.QueryString.ToString() + "<br />";
                //MailMessage myMessage = new MailMessage("postmaster@desertpastures.net", "danielwiredu@gmail.com", mailSubject, message);
                //myMessage.IsBodyHtml = true;
                //SmtpClient mySmtpClient = new SmtpClient();
                //mySmtpClient.Host = "mail.desertpastures.net";
                //mySmtpClient.EnableSsl = false;                
                //mySmtpClient.Credentials = new System.Net.NetworkCredential("postmaster@desertpastures.net", "0lds0ld1er@Mail");
                //mySmtpClient.UseDefaultCredentials = true;
                //mySmtpClient.Port = 25;
                //mySmtpClient.Send(myMessage);

                //Server.ClearError();

                //Code that runs when an unhandled error occurs
                Exception ex = Server.GetLastError().GetBaseException();
                string errorpage = Request.Url.ToString();
                //Server.Transfer("Default5s.aspx");
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand("spAddErrorLog", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@ErrorMessage", SqlDbType.VarChar).Value = ex.Message;
                        command.Parameters.Add("@ErrorPage", SqlDbType.VarChar).Value = errorpage;
                        command.Parameters.Add("@ErrorUser", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                        connection.Open();
                        command.ExecuteNonQuery();
                        //Server.ClearError();
                    }
                }
            }
        }
    }
}