<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="Invoices.aspx.cs" Inherits="GDLC_DLEPortal.Downloads.Invoices" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/telerikCombo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>GDLC Invoices</h5>
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

                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                            <asp:TextBox runat="server" ID="txtSearchStaffReq" Width="100%" placeholder="File Name..." OnTextChanged="txtSearchStaffReq_TextChanged" AutoPostBack="true"></asp:TextBox>                                        
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <%--<asp:Button runat="server" ID="btnUpload" CssClass="btn btn-primary" Text="Upload" CausesValidation="false" OnClientClick="showuploadModal();"/>--%>
                                                <%--<a class="btn btn-primary" onclick="showuploadModal();">Upload</a>--%>
                                            </div>
                                        </div>
                                    </div>

                        <hr />
                             <telerik:RadGrid ID="invoiceGrid" runat="server" DataSourceID="invoiceSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemCommand="invoiceGrid_ItemCommand" >
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                 <MasterTableView DataKeyNames="Id" DataSourceID="invoiceSource">
                                     <Columns>
                                         <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" SortExpression="Id" UniqueName="Id">
                                         <HeaderStyle Width="60px" />
                                         </telerik:GridBoundColumn>
                                         <%--<telerik:GridBoundColumn DataField="DLEcodeCompanyName" FilterControlAltText="Filter DLEcodeCompanyName column" HeaderText="DLE Company" SortExpression="DLEcodeCompanyName" UniqueName="DLEcodeCompanyName">
                                         <HeaderStyle Width="180px" />
                                         </telerik:GridBoundColumn>--%>
                                         <telerik:GridBoundColumn DataField="FileName" FilterControlAltText="Filter FileName column" HeaderText="FileName" SortExpression="FileName" UniqueName="FileName">
                                         <HeaderStyle Width="380px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="FileType" FilterControlAltText="Filter FileType column" HeaderText="FileType" SortExpression="FileType" UniqueName="FileType">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="FilePath" FilterControlAltText="Filter FilePath column" HeaderText="FilePath" SortExpression="FilePath" UniqueName="FilePath">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="DateFrom" DataType="System.DateTime" FilterControlAltText="Filter DateFrom column" HeaderText="DateFrom" SortExpression="DateFrom" UniqueName="DateFrom" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="110px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridDateTimeColumn DataField="DateTo" DataType="System.DateTime" FilterControlAltText="Filter DateTo column" HeaderText="DateTo" SortExpression="DateTo" UniqueName="DateTo" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="110px" />
                                         </telerik:GridDateTimeColumn>
                                        <%-- <telerik:GridBoundColumn DataField="ReportType" FilterControlAltText="Filter ReportType column" HeaderText="ReportType" SortExpression="ReportType" UniqueName="ReportType">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>--%>
                                         <telerik:GridDateTimeColumn DataField="CreatedDate" DataType="System.DateTime" FilterControlAltText="Filter CreatedDate column" HeaderText="CreatedDate" SortExpression="CreatedDate" UniqueName="CreatedDate">
                                         <HeaderStyle Width="145px" />
                                         </telerik:GridDateTimeColumn>
                                        <telerik:GridButtonColumn CommandName="Download" Text="Download" UniqueName="Download">
                                        <ItemStyle  ForeColor="Blue" Font-Underline="true" Font-Bold="true"/>
                                         <HeaderStyle Width="70px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="invoiceSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP (50) Id, DLEcodeCompanyName, FileName, FileType, FilePath, DateFrom, DateTo, ReportType, CreatedDate FROM vwFileUploads WHERE DLEcodeCompanyID = @DLEcodeCompanyID AND (FileName LIKE '%' + @FileName + '%') ORDER BY Id DESC">
                            <SelectParameters>
                                <asp:CookieParameter Name="DLEcodeCompanyID" CookieName="dlecompanyId" Type="Int32" />
                                <asp:ControlParameter Name="FileName" ControlID="txtSearchStaffReq" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                   
                    </div>
                </div>
        </div>

</asp:Content>
