<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="TradeGroup.aspx.cs" Inherits="GDLC_DLEPortal.Tools.TradeGroup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Trade Group</h5>
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
                                        <div class="col-sm-4 pull-right" style="width:inherit">
                                           <asp:Button runat="server" ID="btnExcelExport" CssClass="btn btn-primary" Text="Excel" CausesValidation="false" OnClick="btnExcelExport_Click"/>
                                            <asp:Button runat="server" ID="btnPDFExport" CssClass="btn btn-warning" Text="PDF" CausesValidation="false" OnClick="btnPDFExport_Click"/>
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <%--<asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add Group" CausesValidation="false" OnClientClick="newModal()" />--%>  
                                            </div>
                                        </div>
                                    </div>

                             <telerik:RadGrid ID="tradeGroupGrid" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" CellSpacing="-1" GridLines="Both" DataSourceID="tradeGroupSource" OnItemCommand="tradeGroupGrid_ItemCommand">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                 <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="tradegroup_list" HideStructureColumns="true"  >
                                        <Pdf AllowPrinting="true" AllowCopy="true" PaperSize="Letter" PageTitle="Trade Group List" PageWidth="700"></Pdf>
                                    </ExportSettings>
                                 <MasterTableView DataKeyNames="TradegroupID" DataSourceID="tradeGroupSource" AllowAutomaticDeletes="true" PageSize="50">
                                     <Columns>
                                         <telerik:GridButtonColumn CommandName="Rates" Text="Rates" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                             <ItemStyle ForeColor="Red" Font-Underline="true" Font-Bold="true" Font-Size="Small"/>
                                        </telerik:GridButtonColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="TradegroupID" DataType="System.Int32" FilterControlAltText="Filter TradegroupID column" HeaderText="TradegroupID" ReadOnly="True" SortExpression="TradegroupID" UniqueName="TradegroupID">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="TradegroupNAME" FilterControlAltText="Filter TradegroupNAME column" HeaderText="TradeGroup Name" SortExpression="TradegroupNAME" UniqueName="TradegroupNAME" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                         <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="DNOTES" FilterControlAltText="Filter DNOTES column" HeaderText="Notes" SortExpression="DNOTES" UniqueName="DNOTES" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="200px">
                                         <HeaderStyle Width="300px" />
                                         </telerik:GridBoundColumn>
                                     </Columns>
                                 </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="tradeGroupSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [tblTradeGroup] WHERE [TradegroupID] = @TradegroupID" SelectCommand="SELECT [TradegroupID], [TradegroupNAME], [DNOTES] FROM [tblTradeGroup]">
                            <DeleteParameters>
                                <asp:Parameter Name="TradegroupID" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                             <Triggers>
                                  <asp:PostBackTrigger ControlID="btnExcelExport" />
                                  <asp:PostBackTrigger ControlID="btnPDFExport" />
                              </Triggers>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>

</asp:Content>
