<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="RequestForms.aspx.cs" Inherits="GDLC_DLEPortal.GDLCAdmin.LabourRequest.RequestForms" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Labour Request Form</h5>
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
                                            <asp:TextBox runat="server" ID="txtSearchReq" Width="100%" placeholder="Request No/ Company Name..." AutoPostBack="true" OnTextChanged="txtSearchReq_TextChanged"></asp:TextBox>                                        
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                
                                            </div>
                                        </div>
                                    </div>
                        <hr />
                             <telerik:RadGrid ID="RequestGrid" runat="server" DataSourceID="RequestSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemCommand="RequestGrid_ItemCommand" >
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                 <MasterTableView DataKeyNames="RequestNo" DataSourceID="RequestSource">
                                     <Columns>
                                         <telerik:GridBoundColumn DataField="RequestNo" FilterControlAltText="Filter RequestNo column" HeaderText="RequestNo" SortExpression="RequestNo" UniqueName="RequestNo">
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="RequestDate" DataType="System.DateTime" FilterControlAltText="Filter RequestDate column" HeaderText="RequestDate" SortExpression="RequestDate" UniqueName="RequestDate" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridBoundColumn DataField="Terminal" FilterControlAltText="Filter Terminal column" HeaderText="Terminal" SortExpression="Terminal" UniqueName="Terminal">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Vessel" FilterControlAltText="Filter Vessel column" HeaderText="Vessel" SortExpression="Vessel" UniqueName="Vessel">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <%--<telerik:GridBoundColumn DataField="Activity" FilterControlAltText="Filter Activity column" HeaderText="Activity" SortExpression="Activity" UniqueName="Activity">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>--%>
                                         <%--<telerik:GridBoundColumn DataField="WorkShift" FilterControlAltText="Filter WorkShift column" HeaderText="WorkShift" SortExpression="WorkShift" UniqueName="WorkShift">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>--%>
                                         <telerik:GridBoundColumn DataField="DLECompanyId" DataType="System.Int32" SortExpression="DLECompanyId" UniqueName="DLECompanyId" Display="false"> </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="DLEcodeCompanyName" FilterControlAltText="Filter DLEcodeCompanyName column" HeaderText="Company Name" SortExpression="DLEcodeCompanyName" UniqueName="DLEcodeCompanyName">
                                         <HeaderStyle Width="160px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="CreatedBy" FilterControlAltText="Filter CreatedBy column" HeaderText="CreatedBy" SortExpression="CreatedBy" UniqueName="CreatedBy">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="CreatedDate" DataType="System.DateTime" FilterControlAltText="Filter CreatedDate column" HeaderText="CreatedDate" SortExpression="CreatedDate" UniqueName="CreatedDate">
                                         <HeaderStyle Width="140px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridCheckBoxColumn DataField="Submitted" AllowFiltering="true" DataType="System.Boolean" FilterControlAltText="Filter Submitted column" HeaderText="S" SortExpression="Submitted" UniqueName="Submitted" StringTrueValue="1" StringFalseValue="0" >
                                         <HeaderStyle Width="30px" />
                                         </telerik:GridCheckBoxColumn>
                                         <telerik:GridButtonColumn ButtonType="PushButton" CommandName="View" ButtonCssClass="btn-info" Text="View" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="RequestSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP (100) RequestNo, RequestDate, Terminal, Vessel, Activity, WorkShift, DLECompanyId, DLEcodeCompanyName, Submitted, CreatedBy, CreatedDate FROM vwLabourRequestForm WHERE Submitted = 1 AND (RequestNo LIKE '%' + @SearchValue + '%' OR DLEcodeCompanyName LIKE '%' + @SearchValue + '%') ORDER BY RequestNo DESC">
                            <SelectParameters>
                                <asp:ControlParameter Name="SearchValue" ControlID="txtSearchReq" Type="String" PropertyName="Text" DefaultValue="0" ConvertEmptyStringToNull="false" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
