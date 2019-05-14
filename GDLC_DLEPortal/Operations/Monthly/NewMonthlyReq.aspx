<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="NewMonthlyReq.aspx.cs" Inherits="GDLC_DLEPortal.Operations.Monthly.NewMonthlyReq" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/telerikCombo.css" rel="stylesheet" />
    <link href="/Content/css/aspControlStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>New Monthly Requisition</h5>
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
                         <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <div runat="server" id="lblMsg"></div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Requisition No</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtAutoNo" runat="server" Width="49%" Enabled="false"></asp:TextBox>
                                        <asp:TextBox ID="txtReqNo" runat="server" Width="49%" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">DLE Company</label>
                                    <div class="col-sm-8">
                                        <telerik:RadComboBox ID="dlCompany" runat="server" Width="100%" DataSourceID="dleSource" MaxHeight="200" EmptyMessage="Select Company" Filter="Contains"
                                           OnItemDataBound="dlCompany_ItemDataBound" OnDataBound="dlCompany_DataBound" OnItemsRequested="dlCompany_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateCompanyItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true"  >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncolfull">DLE COMPANY</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "DLEcodeCompanyName")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="companyCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="dleSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlCompany" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Department</label>
                                    <div class="col-sm-8">
                                        <telerik:RadComboBox ID="dlReportingPoint" runat="server" Width="100%" DataSourceID="repPointSource" MaxHeight="200" EmptyMessage="Select Reporting Point" Filter="Contains"
                                           OnItemDataBound="dlReportingPoint_ItemDataBound" OnDataBound="dlReportingPoint_DataBound" OnItemsRequested="dlReportingPoint_ItemsRequested" EnableLoadOnDemand="true"
                                          OnClientItemsRequested="UpdateRepPointItemCountField"   HighlightTemplatedItems="true" MarkFirstMatch="true"   >
                                             <HeaderTemplate>
                <ul>
                    <li class="ncolfull">REPORTING POINT</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "ReportingPoint")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="repPointCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="repPointSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Location</label>
                                    <div class="col-sm-8">
                                        <telerik:RadComboBox ID="dlLocation" runat="server" Width="100%" DataSourceID="locationSource" MaxHeight="200px" EmptyMessage="Select Location" Filter="Contains"
                                          OnItemDataBound="dlLocation_ItemDataBound" OnDataBound="dlLocation_DataBound" OnItemsRequested="dlLocation_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateLocationItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true"    >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncolfull">LOCATION</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "Location")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="locationCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="locationSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
                                    </div>
                                </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Requisition Date</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker runat="server" ID="dpRegdate" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpRegdate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <%--<div class="form-group">
                                    <label class="col-sm-4 control-label">Approval Date</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker runat="server" ID="dpApprovalDate" Width="100%" DateInput-ReadOnly="true" Enabled="false" SelectedDate="01/01/2000"></telerik:RadDatePicker>
                                    </div>
                                </div>--%>
                                    <%--<div class="form-group">
                                    <label class="col-sm-4 control-label">Approved</label>
                                    <div class="col-sm-8">
                                        <asp:CheckBox ID="chkApproved" runat="server" Enabled="false" />
                                    </div>
                                </div>--%>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Period Ending</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtJobDescription" runat="server" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Group</label>
                                        <div class="col-sm-8">
                                            <asp:TextBox runat="server" ID="txtGroupName" Width="100%" Enabled="false"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Category</label>
                                        <div class="col-sm-8">
                                            <asp:TextBox runat="server" ID="txtCategory" Width="100%" Enabled="false"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="row">
                               <asp:HiddenField runat="server" ID="hfTradegroup" />
                               <asp:HiddenField runat="server" ID="hfTradetype" />
                                <label>Name</label> 
                            <telerik:RadTextBox runat="server" ID="txtWorkerId" ReadOnly="true" Width="15%" ShowButton="true" EmptyMessage="Select Worker">
                                <ClientEvents OnButtonClick="showWorkersModal" />
                                <EmptyMessageStyle Resize="None" /></telerik:RadTextBox>
                              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtWorkerId" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:TextBox runat="server" ID="txtWorkerName" Width="30%" Enabled="false"></asp:TextBox>
                             <label> ACC# / SC / EZ#</label>
                               <asp:TextBox runat="server" ID="txtEzwichNo" Width="38%" Enabled="false" ForeColor="Red"></asp:TextBox>
                        </div>
                        
                        
                        <%--<div class="bg-info"> Work Details </div>--%>

                        <div class="row">
                            <div class="col-md-4">
                                <hr />
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Trade Group</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlTradeGroup" runat="server" Width="100%" DataSourceID="tradeGroupSource" DataTextField="TradegroupNAME" DataValueField="TradegroupID" DefaultMessage="Select Group" DropDownHeight="200px"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="tradeGroupSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TradegroupID,TradegroupNAME FROM [tblTradeGroup]"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlTradeGroup" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Period </label>
                                    <div class="col-sm-8">
                                        <telerik:RadMonthYearPicker ID="dpPeriod" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadMonthYearPicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpPeriod" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Period Start</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker runat="server" ID="dpPeriodStart" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpPeriodStart" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Period End</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker runat="server" ID="dpPeriodEnd" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpPeriodEnd" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <hr />
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-7 control-label">Days (Wkday)</label>
                                    <div class="col-sm-5">
                                        <telerik:RadNumericTextBox ID="txtDaysWkday" ClientIDMode="Static" runat="server" Width="100%" MinValue="0" Value="0" NumberFormat-DecimalDigits="0">
                                            <ClientEvents OnValueChanging="getTotalDays"  />
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDaysWkday" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-7 control-label">Days (Wkend)</label>
                                    <div class="col-sm-5">
                                        <telerik:RadNumericTextBox ID="txtDaysWkend" ClientIDMode="Static" runat="server" Width="100%" MinValue="0" Value="0" NumberFormat-DecimalDigits="0">
                                            <ClientEvents OnValueChanging="getTotalDays" />
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDaysWkend" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-7 control-label">Hours (Wkday)</label>
                                    <div class="col-sm-5">
                                        <telerik:RadNumericTextBox ID="txtHoursWkday" runat="server" Width="100%" MinValue="0" Value="0" NumberFormat-DecimalDigits="1"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtHoursWkday" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-7 control-label">Hours (Wkend)</label>
                                    <div class="col-sm-5">
                                        <telerik:RadNumericTextBox ID="txtHoursWkend" runat="server" Width="100%" MinValue="0" Value="0" NumberFormat-DecimalDigits="1"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtHoursWkend" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    
                                </div>
                            </div>
                            <div class="col-md-4">
                                <hr />
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-7 control-label">Nights (Wkday)</label>
                                    <div class="col-sm-5">
                                        <telerik:RadNumericTextBox ID="txtNightsWkday" runat="server" Width="100%" MinValue="0" Value="0" NumberFormat-DecimalDigits="0"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNightsWkday" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-7 control-label">Nights (Wkend)</label>
                                    <div class="col-sm-5">
                                        <telerik:RadNumericTextBox ID="txtNightsWkend" runat="server" Width="100%" MinValue="0" Value="0" NumberFormat-DecimalDigits="0"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNightsWkend" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-7 control-label">Total Days</label>
                                    <div class="col-sm-5">
                                        <telerik:RadNumericTextBox ID="txtTotalDays" ClientIDMode="Static" runat="server" Width="100%" MinValue="0" Value="0" NumberFormat-DecimalDigits="0" ReadOnly="true"></telerik:RadNumericTextBox>
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>
                  
                        <div class="modal-footer">
                            <asp:CheckBox ID="chkApproved" style="color:red;font-size:medium" runat="server" Text="Approved" TextAlign="Left" Enabled="false" />
                            <label style="color:green">Approval Date</label>
                            <telerik:RadDatePicker runat="server" ID="dpApprovalDate" Enabled="false" DateInput-ReadOnly="true" SelectedDate="01/01/2000"></telerik:RadDatePicker>
                            <asp:Button runat="server" ID="btnClear" Text="Add" CssClass="btn btn-danger" CausesValidation="false" style="margin-bottom:0px" OnClick="btnClear_Click" />
                            <asp:Button runat="server" ID="btnReturn" Text="Return" CssClass="btn btn-warning" CausesValidation="false" PostBackUrl="~/Operations/Monthly/MonthlyStaffReq.aspx" />
                            <asp:Button runat="server" ID="btnPrint" Text="Print" CssClass="btn btn-info" Enabled="false" OnClick="btnPrint_Click"   />
                            <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" Enabled="false" />
                        </div>   
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>


     <!-- workers modal -->
         <div class="modal fade" id="workersmodal">
    <div class="modal-dialog" style="width:70%">
        <asp:Panel runat="server" DefaultButton="btnSearch">
            <asp:UpdatePanel runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Workers</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <asp:RadioButtonList ID="rdSearchType" runat="server" RepeatDirection="Horizontal" CssClass="rbl">
                                    <asp:ListItem Text="WorkerID" Value="WorkerID" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="SSF No" Value="SSFNo"></asp:ListItem>
                                    <asp:ListItem Text="NHIS No" Value="NHISNo"></asp:ListItem>
                                    <asp:ListItem Text="Gang" Value="Gang"></asp:ListItem>
                                    <asp:ListItem Text="Surname" Value="Surname"></asp:ListItem>
                                    <asp:ListItem Text="Other Names" Value="Othernames"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                             <div class="form-group">
                                        <%--<label>Enter Value</label>--%>
                                       <asp:TextBox runat="server" ID="txtSearchValue" Width="100%" MaxLength="50" ClientIDMode="Static" ></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtSearchValue" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="search"></asp:RequiredFieldValidator>
                             </div>
                            <div>
                                <telerik:RadGrid ID="workersGrid" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="False" AllowPaging="False" AllowSorting="False" CellSpacing="-1" GridLines="Both" OnItemCommand="workersGrid_ItemCommand">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="300px" />
                                <Selecting AllowRowSelect="true" />
                                <ClientEvents OnRowDblClick="RowDblClick" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataKeyNames="WorkerID" >
                                     <Columns>
                                        <%--<telerik:GridButtonColumn ButtonType="FontIconButton" CommandName="Edit" Text="Add" Exportable="false">
                                        <HeaderStyle Width="30px" />
                                        </telerik:GridButtonColumn>--%>
                                         <telerik:GridBoundColumn DataField="WorkerID" FilterControlAltText="Filter WorkerID column" HeaderText="Worker ID" ReadOnly="True" SortExpression="WorkerID" UniqueName="WorkerID" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="SName" FilterControlAltText="Filter SName column" HeaderText="Surname" SortExpression="SName" UniqueName="SName">
                                         <HeaderStyle Width="140px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="OName" FilterControlAltText="Filter OName column" HeaderText="Othernames" SortExpression="OName" UniqueName="OName">
                                         <HeaderStyle Width="170px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="GangName" FilterControlAltText="Filter GangName column" HeaderText="Gang" SortExpression="GangName" UniqueName="GangName">
                                         <HeaderStyle Width="130px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="SSFNo" FilterControlAltText="Filter SSFNo column" HeaderText="SSF No" SortExpression="SSFNo" UniqueName="SSFNo">
                                         <HeaderStyle Width="130px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="TradegroupID" SortExpression="TradegroupID" UniqueName="TradegroupID">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="TradegroupNAME" FilterControlAltText="Filter TradegroupNAME column" HeaderText="Trade Group" SortExpression="TradegroupNAME" UniqueName="TradegroupNAME">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="TradetypeID" SortExpression="TradetypeID" UniqueName="TradetypeID">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="TradetypeNAME" FilterControlAltText="Filter TradetypeNAME column" HeaderText="Trade Category" SortExpression="TradetypeNAME" UniqueName="TradetypeNAME">
                                         <HeaderStyle Width="140px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="NHIS" FilterControlAltText="Filter NHIS column" HeaderText="NHIS No" SortExpression="NHIS" UniqueName="NHIS">
                                         <HeaderStyle Width="130px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="flags" FilterControlAltText="Filter flags column" HeaderText="flags" SortExpression="flags" UniqueName="flags">
                                         <HeaderStyle Width="50px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="ezwichid" FilterControlAltText="Filter ezwichid column" HeaderText="ezwichid" SortExpression="ezwichid" UniqueName="ezwichid" EmptyDataText="">
                                         <HeaderStyle Width="50px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="DepartmentId" FilterControlAltText="Filter DepartmentId column" HeaderText="DepartmentId" SortExpression="DepartmentId" UniqueName="DepartmentId">
                                         <HeaderStyle Width="50px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="BankNumber" SortExpression="BankNumber" UniqueName="BankNumber" EmptyDataText="">
                                         <HeaderStyle Width="50px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="SortCode" SortExpression="SortCode" UniqueName="SortCode" EmptyDataText="">
                                         <HeaderStyle Width="50px" />
                                         </telerik:GridBoundColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="workerSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [WorkerID], [SName], [OName], [GangName], [SSFNo], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [NHIS], [flags], [ezwichid], [DepartmentId], [BankNumber], [SortCode] FROM [vwWorkers]">
                        </asp:SqlDataSource>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSearch" runat="server" Text="Find" CssClass="btn btn-primary"  OnClick="btnSearch_Click" ValidationGroup="search" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </asp:Panel>
        </div>
         </div>

        <script type="text/javascript">
            function showWorkersModal() {
                $('#workersmodal').modal('show');
                $('#workersmodal').appendTo($("form:first"));
            }
            $('#workersmodal').on('shown.bs.modal', function () {
                $('#txtSearchValue').focus();
            });
            function closeWorkersModal() {
                $('#workersmodal').modal('hide');
            }
            function getTotalDays() {
                var total = Number($('#txtDaysWkday').val()) + Number($('#txtDaysWkend').val());
                $('#txtTotalDays').val(total);

                //if (total == 30) {
                //    $('#txtTotalDays').hide();
                //    $('#txtTotalDays').attr('disabled', true);
                //    toastr.info('Days = 30', 'M Info');
                //}
            }
    </script>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function UpdateCompanyItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
            function UpdateRepPointItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
            function UpdateLocationItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
            function RowDblClick(sender, eventArgs) {
                var editedRow = eventArgs.get_itemIndexHierarchical();
                sender.get_masterTableView().fireCommand("AddWorker", editedRow);
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
