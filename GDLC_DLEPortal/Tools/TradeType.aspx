<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="TradeType.aspx.cs" Inherits="GDLC_DLEPortal.Tools.TradeType" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Trade Type</h5>
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
                                                <%--<asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add TradeType" CausesValidation="false" OnClientClick="newModal()" />--%>  
                                            </div>
                                        </div>
                                    </div>

                             <telerik:RadGrid ID="tradetypeGrid" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" ShowGroupPanel="true" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" CellSpacing="-1" GridLines="Both" DataSourceID="tradeTypeSource" OnItemCommand="tradetypeGrid_ItemCommand">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" ShowUnGroupButton="true" />
                                 <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="tradeType_list" HideStructureColumns="true"  >
                                        <Pdf AllowPrinting="true" AllowCopy="true" PaperSize="Letter" PageTitle="Trade Type List" PageWidth="500"></Pdf>
                                    </ExportSettings>

                                 <MasterTableView DataKeyNames="TradetypeID" DataSourceID="tradeTypeSource" AllowAutomaticDeletes="true" PageSize="50">
                                     <GroupByExpressions>
                                           <telerik:GridGroupByExpression>
                                               <SelectFields>
                                                   <telerik:GridGroupByField FieldAlias="Group" FieldName="TradegroupNAME"></telerik:GridGroupByField>
                                               </SelectFields>
                                               <GroupByFields>
                                                   <telerik:GridGroupByField FieldName="TradegroupNAME" SortOrder="Ascending"></telerik:GridGroupByField>
                                               </GroupByFields>
                                           </telerik:GridGroupByExpression>
                                       </GroupByExpressions>
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataField="TradetypeID" DataType="System.Int32" FilterControlAltText="Filter TradetypeID column" HeaderText="TradetypeID" ReadOnly="True" SortExpression="TradetypeID" UniqueName="TradetypeID">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="TradetypeNAME" FilterControlAltText="Filter TradetypeNAME column" HeaderText="Trade Type" SortExpression="TradetypeNAME" UniqueName="TradetypeNAME" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="250px">
                                         <HeaderStyle Width="300px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="TradegroupID" DataType="System.Int32" FilterControlAltText="Filter TradegroupID column" HeaderText="TradegroupID" SortExpression="TradegroupID" UniqueName="TradegroupID">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="TradegroupNAME" FilterControlAltText="Filter TradegroupNAME column" HeaderText="TradegroupNAME" SortExpression="TradegroupNAME" UniqueName="TradegroupNAME">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="TRNOTE" SortExpression="TRNOTE" UniqueName="TRNOTE" EmptyDataText="">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="prefixname" SortExpression="prefixname" UniqueName="prefixname" EmptyDataText="">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="View" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="tradeTypeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [vwTradeType]" DeleteCommand="DELETE FROM [tblTradeType] WHERE [TradeTypeID] = @TradeTypeID">
                            <DeleteParameters>
                                <asp:Parameter Name="TradeTypeID" Type="Int32" />
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

    <asp:SqlDataSource ID="tradeGroupSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT TradegroupID,TradegroupNAME FROM tblTradeGroup"></asp:SqlDataSource>  

    <!-- edit modal -->
    <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">View Trade Type</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label> Name</label>
                                       <asp:TextBox runat="server" ID="txtTradeType1" Width="100%" MaxLength="50" ReadOnly="true"></asp:TextBox>
                                   <%--<asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtTradeType1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>--%>
                             </div>
                            <div class="form-group">
                                <label>Trade Group</label>
                                <telerik:RadComboBox ID="dlTradeGroup1" runat="server" Width="100%" DataSourceID="tradeGroupSource" DataTextField="TradegroupNAME" DataValueField="TradegroupID" Filter="Contains" MarkFirstMatch="true" Enabled="false" ></telerik:RadComboBox>
                            </div>
                            <div class="form-group">
                                <label>Prefix</label>
                                <asp:TextBox runat="server" ID="txtPrefix1" Width="100%" MaxLength="5" ReadOnly="true" ></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Notes</label>
                                <asp:TextBox runat="server" ID="txtNotes1" Width="100%" TextMode="MultiLine" Rows="3" ReadOnly="true"></asp:TextBox>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <script type="text/javascript">
            function editModal() {
                $('#editmodal').modal('show');
                $('#editmodal').appendTo($("form:first"));
            }
            function closeeditModal() {
                $('#editmodal').modal('hide');
            }
    </script>
</asp:Content>
