<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ReqComments.aspx.cs" Inherits="GDLC_DLEPortal.GDLCAdmin.Operations.ReqComments" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Comments / Remarks </h5>
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
                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                            
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnReturn" CssClass="btn btn-warning" Text="Return" OnClick="btnReturn_Click" />
                                            </div>
                                        </div>
                                    </div>
                       <hr />
                        <asp:HiddenField runat="server" ID="hfReqNo" />
                             <telerik:RadGrid ID="commentGrid" runat="server" DataSourceID="commentSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" >
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                 <MasterTableView DataKeyNames="Id" DataSourceID="commentSource" AllowAutomaticDeletes="true">
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" SortExpression="Id" UniqueName="Id">
                                         <HeaderStyle Width="70px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="ReqNo" FilterControlAltText="Filter ReqNo column" HeaderText="Req No" ReadOnly="True" SortExpression="ReqNo" UniqueName="ReqNo">
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Comment" FilterControlAltText="Filter Comment column" HeaderText="Comment" SortExpression="Comment" UniqueName="Comment">
                                         <HeaderStyle Width="300px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="DateCreated" DataType="System.DateTime" FilterControlAltText="Filter DateCreated column" HeaderText="DateCreated" SortExpression="DateCreated" UniqueName="DateCreated">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="commentSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id, ReqNo, Comment, DateCreated FROM tblReqComments WHERE ReqNo = @ReqNo ORDER BY Id DESC">
                            <SelectParameters>
                                <%--<asp:CookieParameter Name="DLEcodeCompanyID" CookieName="dlecompanyId" Type="Int32" />--%>
                                <asp:QueryStringParameter Name="ReqNo" QueryStringField="reqno" Type="String" ConvertEmptyStringToNull="false" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
