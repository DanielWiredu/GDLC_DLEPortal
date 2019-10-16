<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="EditWeeklyAdvice.aspx.cs" Inherits="GDLC_DLEPortal.Operations.Weekly.EditWeeklyAdvice" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/telerikCombo.css" rel="stylesheet" />
    <link href="/Content/css/aspControlStyle.css" rel="stylesheet" />
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Edit Weekly Advice</h5>
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
                         <asp:UpdatePanel runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true" ID="upMain">
                    <ContentTemplate>
                        <div runat="server" id="lblMsg"></div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Advice No</label>
                                    <div class="col-sm-8">
                                        <%--<asp:TextBox ID="txtAutoNo" runat="server" Width="49%" Enabled="false"></asp:TextBox>--%>
                                        <asp:TextBox ID="txtAdviceNo" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">DLE Company</label>
                                    <div class="col-sm-8">
                                        <telerik:RadComboBox ID="dlCompany" Enabled="false" runat="server" Width="100%" DataSourceID="dleSource" MaxHeight="300px" EmptyMessage="Select company" DataTextField="DLEcodeCompanyName" DataValueField="DLEcodeCompanyID"></telerik:RadComboBox>
                                        <asp:SqlDataSource ID="dleSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlCompany" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Reporting Point</label>
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
                                        <asp:SqlDataSource ID="repPointSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (30) ReportingPointId,ReportingPoint FROM [tblReportingPoint]"></asp:SqlDataSource>
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
                                        <asp:SqlDataSource ID="locationSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (30) LocationId,Location FROM [tblLocation]"></asp:SqlDataSource>
                                    </div>
                                </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Advice Date</label>
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
                            <asp:TextBox runat="server" ID="txtWorkerName" Width="40%" Enabled="false"></asp:TextBox>
                             <label>Requisition No</label>
                               <asp:TextBox runat="server" ID="txtReqNo" Width="25%" Enabled="false" ForeColor="Red"></asp:TextBox>
                        </div>
                        
                        <div class="row">
                            <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <div runat="server" id="lblDays" class="bg-info">Total Days : </div>
                             <telerik:RadGrid ID="subStaffReqGrid" runat="server" DataSourceID="subStaffReqSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemCommand="subStaffReqGrid_ItemCommand" OnDataBound="subStaffReqGrid_DataBound" OnItemDeleted="subStaffReqGrid_ItemDeleted">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="250px" />
                                <Selecting AllowRowSelect="true" />
                                <ClientEvents OnRowDblClick="WorkGrdRowDblClick" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataKeyNames="AutoId" DataSourceID="subStaffReqSource" CommandItemDisplay="Top" CommandItemSettings-AddNewRecordText="Add Work Date" AllowAutomaticDeletes="true">
                                     <Columns>
                                        <telerik:GridButtonColumn CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="FontIconButton" Exportable="false">
                                            <HeaderStyle Width="30px" />
                                        </telerik:GridButtonColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="AutoId" DataType="System.Int32" FilterControlAltText="Filter AutoId column" HeaderText="AutoId" SortExpression="AutoId" UniqueName="AutoId">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="TransDate" FilterControlAltText="Filter TransDate column" HeaderText="Date" SortExpression="TransDate" UniqueName="TransDate" DataFormatString="{0:MM/dd/yyyy}">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridDateTimeColumn DataField="HrsFrom" FilterControlAltText="Filter HrsFrom column" HeaderText="Time In" SortExpression="HrsFrom" UniqueName="HrsFrom">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridDateTimeColumn DataField="HrsTo" FilterControlAltText="Filter HrsTo column" HeaderText="Time Out" SortExpression="HrsTo" UniqueName="HrsTo">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridBoundColumn DataField="Normal" FilterControlAltText="Filter Normal column" HeaderText="Normal" SortExpression="Normal" UniqueName="Normal">
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Overtime" FilterControlAltText="Filter Overtime column" HeaderText="Overtime" SortExpression="Overtime" UniqueName="Overtime">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Night" FilterControlAltText="Filter Night column" HeaderText="Night" SortExpression="Night" UniqueName="Night" EmptyDataText="">
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Weekends" FilterControlAltText="Filter Weekends column" HeaderText="Weekends" SortExpression="Weekends" UniqueName="Weekends" EmptyDataText="">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Holiday" FilterControlAltText="Filter Holiday column" HeaderText="Holiday" SortExpression="Holiday" UniqueName="Holiday" EmptyDataText="">
                                         <HeaderStyle Width="90px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Remarks" FilterControlAltText="Filter Remarks column" HeaderText="Remarks" SortExpression="Remarks" UniqueName="Remarks" EmptyDataText="">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="VesselberthID" SortExpression="VesselberthID" UniqueName="VesselberthID">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="VesselName" FilterControlAltText="Filter VesselName column" HeaderText="Vessel Name" SortExpression="VesselName" UniqueName="VesselName" EmptyDataText="">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridCheckBoxColumn DataField="OnBoardAllowance" FilterControlAltText="Filter OnBoardAllowance column" HeaderText="Ship Side" SortExpression="OnBoardAllowance" UniqueName="OnBoardAllowance">
                                           <HeaderStyle Width="80px" />
                                            </telerik:GridCheckBoxColumn>
                                         <telerik:GridBoundColumn DataField="transport" FilterControlAltText="Filter transport column" HeaderText="*" SortExpression="transport" UniqueName="transport" EmptyDataText="" ConvertEmptyStringToNull="false">
                                         <HeaderStyle Width="20px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridButtonColumn ButtonType="PushButton" ButtonCssClass="btn-success" CommandName="Transport" UniqueName="Transport" Text="t" Exportable="false">
                                        <HeaderStyle Width="25px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="subStaffReqSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM vwLabourAdviceDays WHERE (AdviceNo = @AdviceNo) ORDER BY TransDate" DeleteCommand="DELETE FROM tblLabourAdviceDays WHERE AutoId=@AutoId">
                            <SelectParameters>
                                <asp:ControlParameter Name="AdviceNo" ControlID="txtAdviceNo" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" DefaultValue=" " />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="AutoId" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                        </div>
                  
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnGenerateCostSheet" Text="Generate Cost Sheet" CssClass="btn btn-success" OnClick="btnGenerateCostSheet_Click" OnClientClick="Confirm();" style="margin-right:50px"  />
                            <asp:Button runat="server" ID="btnPrevious" Text="<<" CssClass="btn btn-default" ToolTip="Previous" OnClick="btnPrevious_Click" />
                            <asp:Button runat="server" ID="btnNext" Text=">>" CssClass="btn btn-default" ToolTip="Next" OnClick="btnNext_Click" />
                            <asp:CheckBox ID="chkProcessed" style="color:red;font-size:medium;margin-right:10px" runat="server" Text="Processed" TextAlign="Left" Enabled="false" />
                            <asp:Button runat="server" ID="btnReturn" Text="Return" CssClass="btn btn-warning" CausesValidation="false" PostBackUrl="~/Operations/Weekly/WeeklyAdvice.aspx" style="margin-bottom:0px" />
                            <asp:Button runat="server" ID="btnFind" Text="Find" CssClass="btn btn-success" OnClientClick="newCostSheetModal()" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnSave" Text="Save Changes" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                        </div>   
                    </ContentTemplate>
                             <Triggers>
                                 <asp:AsyncPostBackTrigger ControlID="btnFindCostSheet" EventName="Click" />
                                 <asp:AsyncPostBackTrigger ControlID="workersGrid" EventName="ItemCommand" />
                                 <asp:PostBackTrigger ControlID="btnGenerateCostSheet" />
                             </Triggers>
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
                                <telerik:RadGrid ID="workersGrid" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="true" CellSpacing="-1" GridLines="Both" OnItemCommand="workersGrid_ItemCommand" OnNeedDataSource="workersGrid_NeedDataSource">
                            <ClientSettings >
                                <%--<Virtualization EnableVirtualization="true" InitiallyCachedItemsCount="100" ItemsPerView="100" />--%>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="350px" SaveScrollPosition="false" />
                                <Selecting AllowRowSelect="true" />
                                <ClientEvents OnRowDblClick="RowDblClick" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataKeyNames="WorkerID" AllowSorting="false" AllowFilteringByColumn="false" PageSize="50">
                                     <Columns>
                                        <%--<telerik:GridButtonColumn ButtonType="FontIconButton" CommandName="Edit" Text="Add" Exportable="false">
                                        <HeaderStyle Width="30px" />
                                        </telerik:GridButtonColumn>--%>
                                         <telerik:GridBoundColumn DataField="WorkerID" FilterControlAltText="Filter WorkerID column" HeaderText="Worker ID" ReadOnly="True" SortExpression="WorkerID" UniqueName="WorkerID" AutoPostBackOnFilter="true" ShowFilterIcon="false" AllowFiltering="false">
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="SName" FilterControlAltText="Filter SName column" HeaderText="Surname" SortExpression="SName" UniqueName="SName" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="110px">
                                         <HeaderStyle Width="140px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="OName" FilterControlAltText="Filter OName column" HeaderText="Othernames" SortExpression="OName" UniqueName="OName" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="140px">
                                         <HeaderStyle Width="170px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="GangName" FilterControlAltText="Filter GangName column" HeaderText="Gang" SortExpression="GangName" UniqueName="GangName" AutoPostBackOnFilter="true" ShowFilterIcon="false" AllowFiltering="false">
                                         <HeaderStyle Width="130px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="TradegroupID" SortExpression="TradegroupID" UniqueName="TradegroupID">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="TradegroupNAME" FilterControlAltText="Filter TradegroupNAME column" HeaderText="Trade Group" SortExpression="TradegroupNAME" UniqueName="TradegroupNAME" AutoPostBackOnFilter="true" ShowFilterIcon="false" AllowFiltering="false">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="TradetypeID" SortExpression="TradetypeID" UniqueName="TradetypeID">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="TradetypeNAME" FilterControlAltText="Filter TradetypeNAME column" HeaderText="Trade Category" SortExpression="TradetypeNAME" UniqueName="TradetypeNAME" AutoPostBackOnFilter="true" ShowFilterIcon="false" AllowFiltering="false">
                                         <HeaderStyle Width="140px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="flags" FilterControlAltText="Filter flags column" HeaderText="flags" SortExpression="flags" UniqueName="flags">
                                         <HeaderStyle Width="50" />
                                         </telerik:GridBoundColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="workerSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [WorkerID], [SName], [OName], [GangName], [SSFNo], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [NHIS], [flags], [ezwichid] FROM [vwWorkers]">
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

    <!-- new modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:Panel runat="server" DefaultButton="btnAddDay">
            <asp:UpdatePanel runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Add</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                 <div class="row">
                                     <div class="col-md-6">
                                   <label>Date</label>
                                        <telerik:RadDatePicker runat="server" ID="dpDate" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpDate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="new"></asp:RequiredFieldValidator>
                                    </div>
                                     <div class="col-md-3">
                                         <label>Time In</label>
                                        <telerik:RadTimePicker ID="tpHrsFrom" runat="server" Width="100%" SelectedTime="0:0:0" TimePopupButton-Visible="true"> </telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="tpHrsFrom" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="new"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <label>Time Out</label>
                                        <telerik:RadTimePicker ID="tpHrsTo" runat="server" Width="100%" SelectedTime="0:0:0" TimePopupButton-Visible="true"> </telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="tpHrsTo" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="new"></asp:RequiredFieldValidator>
                                    </div>
                                 </div>
                             </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-3">
                                         <label>Normal Hrs</label>
                                        <telerik:RadNumericTextBox ID="txtNormalHrs" runat="server" Width="100%" MinValue="0" Value="8" NumberFormat-DecimalDigits="1"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNormalHrs" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="new"></asp:RequiredFieldValidator>
                                    </div>
                                     <div class="col-md-3">
                                         <label>Overtime Hrs</label>
                                        <telerik:RadNumericTextBox ID="txtOvertimeHrs" runat="server" Width="100%"  MinValue="0" Value="4" NumberFormat-DecimalDigits="1"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOvertimeHrs" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="new"></asp:RequiredFieldValidator>
                                    </div>
                                    <%--<div class="col-md-6">
                                        <asp:CheckBox ID="chkShipSide" runat="server" Text="Ship Side" TextAlign="Left" /> 
                                        <asp:CheckBox ID="chkHoliday" runat="server" Text="Holiday" TextAlign="Left" /> 
                                        <asp:CheckBox ID="chkNight" runat="server" Text="Night" TextAlign="Left" /> 
                                    </div>--%>
                                    <div class="col-md-2">
                                        <label>Ship Side</label>
                                        <asp:CheckBox ID="chkShipSide" runat="server" Width="100%" /> 
                                    </div>
                                    <div class="col-md-2">
                                        <label>Holiday</label>
                                        <asp:CheckBox ID="chkHoliday" runat="server" Width="100%" /> 
                                    </div>
                                    <div class="col-md-2">
                                        <label>Night</label>
                                         <asp:CheckBox ID="chkNight" runat="server" Width="100%" /> 
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label>Vessel</label>
                                        <telerik:RadComboBox ID="dlVessel" runat="server" Width="100%" DataSourceID="vesselSource" MaxHeight="200" EmptyMessage="Select Vessel" Filter="Contains"
                                          OnItemDataBound="dlVessel_ItemDataBound" OnDataBound="dlVessel_DataBound" OnItemsRequested="dlVessel_ItemsRequested" 
                                           OnClientItemsRequested="UpdateVesselItemCountField" HighlightTemplatedItems="true"
                                            EnableLoadOnDemand="true" MarkFirstMatch="true"  >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncolfull">VESSEL NAME</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "VesselName")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="vesselCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="vesselSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (30) VesselId,VesselName FROM [tblVessel]"></asp:SqlDataSource>
                                    </div>
                                </div>
                            </div>
                        <div class="form-group">
                                        <label>Remarks</label>
                                       <asp:TextBox runat="server" ID="txtRemarks" Width="100%" ></asp:TextBox>
                             </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnAddDay" runat="server" Text="Save" CssClass="btn btn-primary" ClientIDMode="Static" OnClick="btnAddDay_Click" ValidationGroup="new" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </asp:Panel>
        </div>
         </div>

       <!-- edit modal -->
         <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:Panel runat="server" DefaultButton="btnUpdateDay">
            <asp:UpdatePanel runat="server" UpdateMode="Always">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                 <div class="row">
                                     <div class="col-md-6">
                                   <label>Date</label>
                                        <telerik:RadDatePicker runat="server" ID="dpDate1" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpDate1" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                    </div>
                                     <div class="col-md-3">
                                         <label>Time In</label>
                                        <telerik:RadTimePicker ID="tpHrsFrom1" runat="server" Width="100%" TimePopupButton-Visible="true"> </telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="tpHrsFrom1" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <label>Time Out</label>
                                        <telerik:RadTimePicker ID="tpHrsTo1" runat="server" Width="100%" TimePopupButton-Visible="true"> </telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="tpHrsTo1" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                    </div>
                                 </div>
                             </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-3">
                                         <label>Normal Hrs</label>
                                        <telerik:RadNumericTextBox ID="txtNormalHrs1" runat="server" Width="100%" MinValue="0" NumberFormat-DecimalDigits="1"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNormalHrs1" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                    </div>
                                     <div class="col-md-3">
                                         <label>Overtime Hrs</label>
                                        <telerik:RadNumericTextBox ID="txtOvertimeHrs1" runat="server" Width="100%"  MinValue="0" NumberFormat-DecimalDigits="1"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOvertimeHrs1" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                    </div>
                                    <%--<div class="col-md-6">
                                        <asp:CheckBox ID="chkShipSide1" runat="server" Text="Ship Side" TextAlign="Left" /> 
                                        <asp:CheckBox ID="chkHoliday1" runat="server" Text="Holiday" TextAlign="Left" /> 
                                        <asp:CheckBox ID="chkNight1" runat="server" Text="Night" TextAlign="Left" /> 
                                    </div>--%>
                                    <div class="col-md-2">
                                        <label>Ship Side</label>
                                        <asp:CheckBox ID="chkShipSide1" runat="server" Width="100%" /> 
                                    </div>
                                    <div class="col-md-2">
                                        <label>Holiday</label>
                                        <asp:CheckBox ID="chkHoliday1" runat="server" Width="100%" /> 
                                    </div>
                                    <div class="col-md-2">
                                        <label>Night</label>
                                        <asp:CheckBox ID="chkNight1" runat="server" Width="100%" /> 
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label>Vessel</label>
                                        <telerik:RadComboBox ID="dlVessel1" runat="server" Width="100%" DataSourceID="vesselSource" MaxHeight="200" EmptyMessage="Select Vessel" Filter="Contains"
                                          OnItemDataBound="dlVessel1_ItemDataBound" OnDataBound="dlVessel1_DataBound" OnItemsRequested="dlVessel1_ItemsRequested" 
                                           OnClientItemsRequested="UpdateVesselItemCountField" HighlightTemplatedItems="true"
                                            EnableLoadOnDemand="true" MarkFirstMatch="true"  >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncolfull">VESSEL NAME</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "VesselName")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="vesselCount1" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (30) VesselId,VesselName FROM [tblVessel]"></asp:SqlDataSource>--%>
                                    </div>
                                </div>
                            </div>
                        <div class="form-group">
                                        <label>Remarks</label>
                                       <asp:TextBox runat="server" ID="txtRemarks1" Width="100%" ></asp:TextBox>
                             </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdateDay" runat="server" Text="Update" CssClass="btn btn-primary"  OnClick="btnUpdateDay_Click" ValidationGroup="edit" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </asp:Panel>
        </div>
         </div>

     <!-- find cost sheed modal -->
         <div class="modal fade" id="costsheetmodal">
    <div class="modal-dialog" style="width:40%">
        <asp:Panel runat="server" DefaultButton="btnFindCostSheet">
            <asp:UpdatePanel runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Find Advice</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>Enter Advice No</label>
                                       <asp:TextBox runat="server" ID="txtCostSheet" Width="100%" MaxLength="50" ClientIDMode="Static"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCostSheet" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="searchcostsheet"></asp:RequiredFieldValidator>
                             </div>
                            <div>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnFindCostSheet" runat="server" Text="Find" CssClass="btn btn-primary" OnClick="btnFindCostSheet_Click" ValidationGroup="searchcostsheet" />
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
            function newModal() {
                $('#newmodal').modal('show');
                $('#newmodal').appendTo($("form:first"));
            }
            $('#newmodal').on('shown.bs.modal', function () {
                $('#btnAddDay').focus();
            });
            function closenewModal() {
                $('#newmodal').modal('hide');
            }
            function editModal() {
                $('#editmodal').modal('show');
                $('#editmodal').appendTo($("form:first"));
            }
            function closeeditModal() {
                $('#editmodal').modal('hide');
            }
            function Confirm() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Advice will be converted to a cost sheet. This action is not reversible")) {
                    confirm_value.value = "Yes";
                } else {
                    confirm_value.value = "No";
                }
                document.forms[0].appendChild(confirm_value);
            }
            function newCostSheetModal() {
                $('#costsheetmodal').modal('show');
                $('#costsheetmodal').appendTo($("form:first"));
            }
            $('#costsheetmodal').on('shown.bs.modal', function () {
                $('#txtCostSheet').focus();
            });
            function closeCostSheetModal() {
                $('#costsheetmodal').modal('hide');
            }
    </script>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function UpdateVesselItemCountField(sender, args) {
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
            function WorkGrdRowDblClick(sender, eventArgs) {
                var editedRow = eventArgs.get_itemIndexHierarchical();
                sender.get_masterTableView().fireCommand("EditWork", editedRow);
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
