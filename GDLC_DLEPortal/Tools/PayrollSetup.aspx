<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="PayrollSetup.aspx.cs" Inherits="GDLC_DLEPortal.Tools.PayrollSetup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Payroll Setup</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                         <asp:UpdatePanel runat="server" >
                    <ContentTemplate>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Union Dues</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtUnionDues" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Welfare</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtWelfare" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>SSF (Employee) %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtSSFEmployee" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>SSF (Employer) %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtSSFEmployer" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Provident Fund Employee %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtPFEmployee" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Provident Fund Employer %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtPFEmployer" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Annual Bonus %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtAnnualBonus" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Annual Leave %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtAnnualLeave" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Premium Shareholder %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtPremShareholder" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Premium Non Shareholder %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtPremNonShareholder" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Premium Without Transport %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtPremWithoutTransport" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Tax on Bonus %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtTaxOnBonus" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Tax on Basic %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtTaxOnBasic" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Tax on Overtime %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtTaxOnOvertime" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Tax on Provident Fund %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtTaxOnPF" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Tax on Transport %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtTaxOnTransport" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>On Board Allowance</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtOnBoardAllowance" Width="100%" MinValue="0"  NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>VAT %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtVAT" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Get Fund %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtGetFund" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>NHIL %</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtNHIL" Width="100%" MinValue="0" NumberFormat-DecimalDigits="3"></telerik:RadNumericTextBox>
                                </div>
                            </div>
                        </div>
                       
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
