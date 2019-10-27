<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="WeeklyStaffReq.aspx.cs" Inherits="GDLC_DLEPortal.GDLCAdmin.Operations.WeeklyStaffReq" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Weekly Requisition</h5>
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
                                            <asp:TextBox runat="server" ID="txtSearchStaffReq" Width="100%" placeholder="Req No, Worker ID/ Name..." OnTextChanged="txtSearchStaffReq_TextChanged" AutoPostBack="true"></asp:TextBox>
                                           
                                           <%--<asp:Button runat="server" ID="btnExcelExport" CssClass="btn btn-primary" Text="Excel" CausesValidation="false" OnClick="btnExcelExport_Click"/>--%>
                                            <%--<asp:Button runat="server" ID="btnPDFExport" CssClass="btn btn-warning" Text="PDF" CausesValidation="false" OnClick="btnPDFExport_Click"/>--%>
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <%--<asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add" CausesValidation="false" PostBackUrl="~/Operations/Weekly/NewWeeklyReq.aspx" />--%>  
                                            </div>
                                        </div>
                                    </div>
                         <hr />
                             <telerik:RadGrid ID="weeklyStaffReqGrid" runat="server" DataSourceID="weeklyStaffReqSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="true" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemCommand="weeklyStaffReqGrid_ItemCommand">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataKeyNames="ReqNo" DataSourceID="weeklyStaffReqSource" PageSize="100">
                                     <Columns>
                                         <telerik:GridBoundColumn DataField="AutoNo" DataType="System.Int32" FilterControlAltText="Filter AutoNo column" HeaderText="AutoNo" SortExpression="AutoNo" UniqueName="AutoNo">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="ReqNo" FilterControlAltText="Filter ReqNo column" HeaderText="Req No" ReadOnly="True" SortExpression="ReqNo" UniqueName="ReqNo">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="date_" DataType="System.DateTime" FilterControlAltText="Filter date_ column" HeaderText="Date" SortExpression="date_" UniqueName="date_" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridBoundColumn DataField="DLEcodeCompanyName" FilterControlAltText="Filter DLEcodeCompanyName column" HeaderText="DLE Company" SortExpression="DLEcodeCompanyName" UniqueName="DLEcodeCompanyName">
                                         <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="WorkerId" FilterControlAltText="Filter WorkerId column" HeaderText="WorkerId" SortExpression="WorkerId" UniqueName="WorkerId">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="WorkerName" FilterControlAltText="Filter WorkerName column" HeaderText="Worker Name" SortExpression="WorkerName" UniqueName="WorkerName">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridCheckBoxColumn DataField="Approved" DataType="System.Boolean" FilterControlAltText="Filter Approved column" HeaderText="A" SortExpression="Approved" UniqueName="Approved" StringTrueValue="1" StringFalseValue="0" >
                                         <HeaderStyle Width="30px" />
                                         </telerik:GridCheckBoxColumn>
                                         <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="View" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="weeklyStaffReqSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP (100) AutoNo, ReqNo, date_, Approved, DLEcodeCompanyName, WorkerId, WorkerName FROM vwWeeklyReq WHERE (ReqNo LIKE '%' + @SearchValue + '%' OR WorkerId LIKE '%' + @SearchValue + '%' OR WorkerName LIKE '%' + @SearchValue + '%') ORDER BY AutoNo DESC">
                            <SelectParameters>
                                <asp:ControlParameter Name="SearchValue" ControlID="txtSearchStaffReq" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                             <%--<Triggers>
                                  <asp:PostBackTrigger ControlID="btnSearch" />
                              </Triggers>--%>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
