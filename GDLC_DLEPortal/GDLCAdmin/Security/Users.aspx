<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="GDLC_DLEPortal.GDLCAdmin.Security.Users" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Users</h5>
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
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add User" CausesValidation="false" PostBackUrl="~/GDLCAdmin/Security/NewUser.aspx" />  
                                            </div>
                                        </div>
                                    </div>
                        <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="upMain">
                           <ProgressTemplate>
                            <div class="divWaiting">            
	                            <asp:Label ID="lblWait" runat="server" Text="Processing... " />
	                              <asp:Image ID="imgWait" runat="server" ImageAlign="Top" ImageUrl="/Content/img/loader.gif" />
                                </div>
                             </ProgressTemplate>
                       </asp:UpdateProgress>
                         <asp:UpdatePanel runat="server" ID="upMain" >
                    <ContentTemplate>

                            <telerik:RadGrid ID="userGrid" runat="server" AllowFilteringByColumn="True" AllowSorting="True" DataSourceID="userSource" GroupPanelPosition="Top" OnItemDataBound="userGrid_ItemDataBound" OnItemCommand="userGrid_ItemCommand" OnItemDeleted="userGrid_ItemDeleted">
                                   <GroupingSettings CaseSensitive="False" />
                                   <ClientSettings>
                                       <Selecting AllowRowSelect="True" />
                                       <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="400px" />
                                   </ClientSettings>
                                   <GroupingSettings CaseSensitive="false" />
                                   <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="None" DataKeyNames="ID" DataSourceID="userSource">
                                       <CommandItemSettings ShowAddNewRecordButton="false" />
                                       <RowIndicatorColumn Visible="False">
                                       </RowIndicatorColumn>
                                       <Columns>
                                           <telerik:GridBoundColumn  DataField="ID" FilterControlAltText="Filter ID column"  SortExpression="ID" UniqueName="ID" Display="false">
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn AutoPostBackOnFilter="True" CurrentFilterFunction="Contains" DataField="USERNAME" EmptyDataText="" FilterControlAltText="Filter USERNAME column" FilterDelay="1000" HeaderText="Username"  SortExpression="USERNAME" UniqueName="USERNAME" ShowFilterIcon="false" FilterControlWidth="120px">
                                           <HeaderStyle Width="150px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn AutoPostBackOnFilter="True" CurrentFilterFunction="Contains" DataField="FULLNAME" FilterControlAltText="Filter FULLNAME column" FilterDelay="1000" HeaderText="Full Name" SortExpression="FULLNAME" UniqueName="FULLNAME" ShowFilterIcon="false" FilterControlWidth="170px">
                                           <HeaderStyle Width="200px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="ACCOUNTTYPE" FilterControlAltText="Filter ACCOUNTTYPE column" HeaderText="Account Type" SortExpression="ACCOUNTTYPE" UniqueName="ACCOUNTTYPE" ShowFilterIcon="false" FilterControlWidth="80px">
                                           <HeaderStyle Width="100px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="DLEcodeCompanyName" FilterControlAltText="Filter DLEcodeCompanyName column" HeaderText="Base CompanyName" SortExpression="DLEcodeCompanyName" UniqueName="DLEcodeCompanyName" ShowFilterIcon="false" FilterControlWidth="170px">
                                           <HeaderStyle Width="200px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="ContactNo" FilterControlAltText="Filter ContactNo column" HeaderText="ContactNo" SortExpression="ContactNo" UniqueName="ContactNo" ShowFilterIcon="false" FilterControlWidth="80px">
                                           <HeaderStyle Width="100px" />
                                           </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ACTIVE" FilterControlAltText="Filter ACTIVE column" HeaderText="ACTIVE" SortExpression="ACTIVE" UniqueName="ACTIVE" Display="false" >
                                           <HeaderStyle Width="120px" />
                                            </telerik:GridBoundColumn>
                                           <telerik:GridButtonColumn CommandName="Edit" Text="Edit" UniqueName="Edit" ButtonType="PushButton" ButtonCssClass="btn-info">
                                           <HeaderStyle Width="50px" />
                                           </telerik:GridButtonColumn>
                                           <telerik:GridButtonColumn CommandName="ToggleActive" Text="Toggle Active" ButtonType="PushButton" ButtonCssClass="btn-warning" UniqueName="ToggleActive" ConfirmText="Toggle User's active status?">
                                           <HeaderStyle Width="100px" />
                                           </telerik:GridButtonColumn>
                                       </Columns>
                                   </MasterTableView>
                               </telerik:RadGrid>
                               <asp:SqlDataSource ID="userSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ID, USERNAME, FULLNAME, ACCOUNTTYPE, DLEcodeCompanyName, ContactNo, ACTIVE FROM vwUsersMain ORDER BY FULLNAME">
                                   <%--<DeleteParameters>
                                       <asp:Parameter Name="ID" Type="Int32" />
                                   </DeleteParameters>--%>
                               </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
