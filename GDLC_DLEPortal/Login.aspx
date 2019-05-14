<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GDLC_DLEPortal.Login" %>

<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>GDLC Client Portal</title>

    <link href="/Content/css/bootstrap.min.css" rel="stylesheet">
    <link href="/Content/font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="/Content/css/animate.css" rel="stylesheet">
    <link href="/Content/css/style.css" rel="stylesheet">

    <link href="/Content/css/plugins/toastr/toastr.min.css" rel="stylesheet"/>

</head>

<body style="background-color:white">

    <%--<body style="background:url(/Content/img/NMH_Logo1.png) no-repeat; ">--%>
     <%--<img alt="image" src="/Content/img/NMH_logo1.png" style="position:center" />--%>

        <div class="img-container" style="padding-top:10px">
         <img alt="image" src="/Content/img/GDLC_Logo.png" />
    </div>

    <div class="loginColumns animated fadeInDown">
        <div class="row">
            <div class="col-md-4" style="color:black">
                <h2 class="font-bold">GDLC Client Portal</h2>

                <p style="font-style:italic;">
                    Request for Labour
                </p>

                <p style="font-style:italic;">
                    Verify and Approve Time Sheets
                </p>
                <%--<p style="font-weight:bold; font-size:medium; font-style:italic;">
                    Log complaint
                </p>--%>
                <p style="font-style:italic;">
                    Generate Real Time Invoices
                </p>
                <p style="font-style:italic;">
                    Download Final GLDC Invoices
                </p>
            </div>
            
            <div class="col-md-4">
                <div class="ibox-content">
                    <form class="m-t" runat="server" defaultbutton="btnLogin">
                            <asp:ScriptManager runat="server"></asp:ScriptManager>

                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Username" id="txtUsername" required="required" runat="server">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" placeholder="Password" id="txtPassword" required="required" runat="server">
                        </div>
                            <asp:Button runat="server"  Text="Login" ID="btnLogin" CssClass="btn btn-primary block full-width m-b" OnClick="btnLogin_Click" />
                        <%--<button type="submit" class="btn btn-primary block full-width m-b" runat="server" onclick="return ValidateForm()" onserverclick="btnLogin_Click">Login</button>--%>

                        <%--<a href="#">
                            <small>Forgot password?</small>
                        </a>--%>

                        <%--<p class="text-muted text-center">
                            <small>Do not have an account?</small>
                        </p>--%>
                        <%--<a class="btn btn-sm btn-white btn-block" href="register.html">Create an account</a>--%>
                   
                        </ContentTemplate>
                    </asp:UpdatePanel>
                     </form>
                    <p class="m-t">
                        <small>Enter your username and password to sign in</small>
                    </p>
                </div>
            </div>
            <div class="col-md-4">

            </div>
        </div>
        <hr/>
        <div class="row">
            <div class="col-md-6"> 
                <strong>Developed by <a href="http://eupacwebs.com/" target="_blank">Eupac Web Solutions Limited</a></strong>
            </div>
            <div class="col-md-6 text-right">
               <strong>Copyright &copy; <%=DateTime.Now.Year.ToString() %> <a href="https://docklabour.com/" target="_blank" >Ghana Dock Labour Company</a>.</strong> 
            </div>
        </div>
    </div>
    
    <script src="/Content/js/jquery-2.1.1.js"></script>
    <script src="/Content/js/bootstrap.min.js"></script>
    <script src="/Content/js/plugins/toastr/toastr.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            setTimeout(function () {
                toastr.options = {
                    closeButton: true,
                    progressBar: true,
                    showMethod: 'slideDown',
                    timeOut: 3000
                };
            }, 1300);
        });

        function ValidateForm() {
            var valid = true;
            //All Validations. If any validations failed, set valid = false;
            if ($('#txtUsername').val() == "" || $('#txtUsername').val() == null) {
                toastr.error('Username Required', 'Error');
                $('#txtUsername').focus();
                valid = false;
            }
            if ($('#txtPassword').val() == "" || $('#txtPassword').value() == null) {
                toastr.error('Password Required', 'Error');
                $('#txtPassword').focus();
                valid = false;
            }
            return valid;
        }
    </script>

    </body>
</html>
