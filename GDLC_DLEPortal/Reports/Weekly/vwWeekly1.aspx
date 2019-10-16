<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="vwWeekly1.aspx.cs" Inherits="GDLC_DLEPortal.Reports.Weekly.vwWeekly1" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="/Content/css/telerikCombo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Weekly Reports</h5>
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
                         <asp:UpdatePanel ID="upProcess" runat="server" >
                    <ContentTemplate>
                        <div runat="server" id="lblMsg" class="alert alert-info"> Generate All Weekly Reports Here</div>
                  
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-1">

                                </div>
                                <div class="col-md-4">
                                    <label>Report Type</label>
                                    <telerik:RadDropDownList runat="server" ID="dlReportType" Width="100%" DefaultMessage="Select Report Type" DropDownHeight="150px">
                                        <Items >
                                            <telerik:DropDownListItem Text="Weekly Cost Sheet" />
                                            <telerik:DropDownListItem Text="Weekly Processed" />
                                            <telerik:DropDownListItem Text="Weekly Invoice" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="dlReportType" Display="Dynamic" ErrorMessage="Select Report Type" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                    <label>Approval Start Date</label>
                                    <telerik:RadDatePicker runat="server" ID="dpStartDate" DateInput-ReadOnly="false" Width="100%"></telerik:RadDatePicker>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dpStartDate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                     <label>Approval End Date</label>
                                    <telerik:RadDatePicker runat="server" ID="dpEndDate" DateInput-ReadOnly="false" Width="100%"></telerik:RadDatePicker>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dpEndDate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                 <div class="col-md-1">

                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnProcess" Text="Generate Report" CssClass="btn btn-primary" OnClick="btnProcess_Click" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" />
                        </div> 

                        <hr />

                        <div runat="server" id="Div1" class="alert alert-info"> Generate Weekly Reports By Company Here</div>
                  
                        <div class="form-group" >
                            <div class="row">
                                <div class="col-md-3">
                         <label>DLE Company</label>
                                        <telerik:RadComboBox ID="dlCompany" runat="server" Width="100%" DataSourceID="dleSource" MaxHeight="300px" EmptyMessage="Select 1 or more companies" Filter="None" Localization-AllItemsCheckedString="All companies checked"
                                          DataTextField="DLEcodeCompanyName" DataValueField="DLEcodeCompanyID" MarkFirstMatch="false" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"></telerik:RadComboBox>
                                        <asp:SqlDataSource ID="dleSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlCompany" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="company"></asp:RequiredFieldValidator>
                         </div>
                                <div class="col-md-3">
                                    <label>Report Type</label>
                                    <telerik:RadDropDownList runat="server" ID="dlReportTypeByCompany" Width="100%" DefaultMessage="Select Report Type" DropDownHeight="150px">
                                        <Items >
                                            <telerik:DropDownListItem Text="Weekly Cost Sheet" />
                                            <telerik:DropDownListItem Text="Weekly Processed" />
                                            <telerik:DropDownListItem Text="Weekly Invoice" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dlReportTypeByCompany" Display="Dynamic" ErrorMessage="Select Report Type" SetFocusOnError="true" ForeColor="Red" ValidationGroup="company"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                    <label>Approval Start Date</label>
                                    <telerik:RadDatePicker runat="server" ID="dpStartDateByCompany" DateInput-ReadOnly="false" Width="100%"></telerik:RadDatePicker>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dpStartDateByCompany" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="company"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                     <label>Approval End Date</label>
                                    <telerik:RadDatePicker runat="server" ID="dpEndDateByCompany" DateInput-ReadOnly="false" Width="100%"></telerik:RadDatePicker>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dpEndDateByCompany" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="company"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" >
                            <asp:Button runat="server" ID="btnReportByCompany" Text="Generate Report" CssClass="btn btn-primary" OnClick="btnReportByCompany_Click" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" ValidationGroup="company" />
                        </div>  
                        
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>

</asp:Content>
