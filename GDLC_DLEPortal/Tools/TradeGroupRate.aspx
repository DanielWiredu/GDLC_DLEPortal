<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="TradeGroupRate.aspx.cs" Inherits="GDLC_DLEPortal.Tools.TradeGroupRate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
    <link href="/Content/css/aspControlStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Trade Group Rates</h5>
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
                        <div class="alert alert-info" runat="server" id="lblTradeGroup"></div>
                        <div class="row">
                                        <div class="col-sm-4 pull-right" style="width:inherit">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnReturn" CssClass="btn btn-warning" Text="Return" CausesValidation="false" PostBackUrl="~/Tools/TradeGroup.aspx" />  
                                            </div>
                                        </div>
                                    </div>

                             <telerik:RadGrid ID="tradeGroupRateGrid" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="False" AllowPaging="True" AllowSorting="True" CellSpacing="-1" GridLines="Both" DataSourceID="tradeGroupRateSource" OnItemCommand="tradeGroupRateGrid_ItemCommand">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                 <MasterTableView DataKeyNames="Id" DataSourceID="tradeGroupRateSource" >
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" HeaderText="Id" SortExpression="Id" UniqueName="Id">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="EffectiveDate" DataType="System.DateTime" HeaderText="Effective Date" SortExpression="EffectiveDate" UniqueName="EffectiveDate" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="EndDate" DataType="System.DateTime" HeaderText="End Date" SortExpression="EndDate" UniqueName="EndDate" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridButtonColumn ButtonType="PushButton" CommandName="View" ButtonCssClass="btn-info" Text="View" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="tradeGroupRateSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Id], [EffectiveDate], [EndDate] FROM [tblTradeGroupRates] WHERE TradeGroupId = @TradeGroupId">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="TradeGroupId" QueryStringField="tradeGroupId" Type="String" ConvertEmptyStringToNull="false" DefaultValue=" " />
                        </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>

    <!-- edit modal -->
         <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:70%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">View Group Rate</h4>
                </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-8">
                                       <div class="form-group bg-primary">Rate for Workers</div>
                                   
                                        <div class="form-horizontal">

                                     <div class="form-group">
                                    <label class="col-sm-5 control-label">Daily Basic Wage</label>
                                    <div class="col-sm-7">
                                        <telerik:RadNumericTextBox ID="txtDBWage1" runat="server" Width="100%" MinValue="0"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                     <div class="form-group">
                                    <label class="col-sm-5 control-label">Daily Basic Wage Weekend</label>
                                    <div class="col-sm-7">
                                        <telerik:RadNumericTextBox ID="txtDBWageWknd1" runat="server" Width="100%" MinValue="0"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                     <div class="form-group">
                                    <label class="col-sm-5 control-label">1 Hour Overtime Weekday</label>
                                    <div class="col-sm-7">
                                        <telerik:RadNumericTextBox ID="txtHourOvertimeWkday1" runat="server" Width="100%" MinValue="0"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label">1 Hour Overtime Weekend</label>
                                    <div class="col-sm-7">
                                    <telerik:RadNumericTextBox ID="txtHourOvertimeWknd1" runat="server" Width="100%" MinValue="0"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label">Night Allowance Weekday</label>
                                    <div class="col-sm-7">
                                        <telerik:RadNumericTextBox ID="txtNightAllowanceWkday1" runat="server" Width="100%" ></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label">Night Allowance Weekend</label>
                                    <div class="col-sm-7">
                                        <telerik:RadNumericTextBox ID="txtNightAllowanceWknd1" runat="server" Width="100%"> </telerik:RadNumericTextBox>
                                    </div>
                                </div>     
                                <div class="form-group">
                                    <label class="col-sm-5 control-label">Transport Allowance </label>
                                    <div class="col-sm-7">
                                        <telerik:RadNumericTextBox ID="txtTransportAllowance1" runat="server" Width="100%"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label">Subsidy</label>
                                    <div class="col-sm-7">
                                        <telerik:RadNumericTextBox ID="txtSubsidy1" runat="server" Width="100%" ></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label">PPE Medicals</label>
                                    <div class="col-sm-7">
                                        <telerik:RadNumericTextBox ID="txtPPEMedicals1" runat="server" Width="100%"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label">Bussing</label>
                                    <div class="col-sm-7">
                                        <telerik:RadNumericTextBox ID="txtBussing1" runat="server" Width="100%"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                            </div>
                                </div>
                                <div class="col-md-4">
                                     <div class="form-group bg-primary">Rate for DLE Companies</div>
                                   
                                    <div class="form-horizontal">

                                        <div class="form-group">
                                    <div class="col-sm-12">
                                        <telerik:RadNumericTextBox ID="txtDBWageDLE1" runat="server" Width="100%" MinValue="0" Height="24px"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                            <div class="form-group">
                                    <div class="col-sm-12">
                                        <telerik:RadNumericTextBox ID="txtDBWageWkndDLE1" runat="server" Width="100%" MinValue="0" Height="24px"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                     <div class="form-group">
                                    <div class="col-sm-12">
                                        <telerik:RadNumericTextBox ID="txtHourOvertimeWkdayDLE1" runat="server" Width="100%" MinValue="0" Height="24px"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                     <div class="form-group">
                                    <div class="col-sm-12">
                                        <telerik:RadNumericTextBox ID="txtHourOvertimeWkndDLE1" runat="server" Width="100%" MinValue="0" Height="24px"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                     <div class="form-group">
                                    <div class="col-sm-12">
                                        <telerik:RadNumericTextBox ID="txtNightAllowanceWkdayDLE1" runat="server" Width="100%" MinValue="0" Height="24px"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                     <div class="form-group">
                                    <div class="col-sm-12">
                                        <telerik:RadNumericTextBox ID="txtNightAllowanceWkndDLE1" runat="server" Width="100%" MinValue="0" Height="24px"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="form-horizontal">
                                     <div class="form-group">
                                     <label class="col-sm-5 control-label">Effective Date </label>
                                    <div class="col-sm-7">
                                        <telerik:RadDatePicker runat="server" ID="dpEffectiveDate1" Enabled="false" Width="100%" DateInput-ReadOnly="true" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpEffectiveDate1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                </div>
                                </div>
                            </div>    
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="form-horizontal">
                                     <div class="form-group">
                                     <label class="col-sm-5 control-label">End Date </label>
                                    <div class="col-sm-7">
                                        <telerik:RadDatePicker runat="server" ID="dpEndDate1" Enabled="false" Width="100%" DateInput-ReadOnly="true" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                                    </div>
                                </div>
                                </div>
                                </div>
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
