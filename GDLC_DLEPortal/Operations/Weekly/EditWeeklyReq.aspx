﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="EditWeeklyReq.aspx.cs" Inherits="GDLC_DLEPortal.Operations.Weekly.EditWeeklyReq" %>

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
                        <h5>Edit Weekly Requisition</h5>
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
                         <asp:UpdatePanel runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false" ID="upMain">
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
                            <asp:TextBox runat="server" ID="txtWorkerName" Width="40%" Enabled="false"></asp:TextBox>
                            <label>Advice No</label>
                               <asp:TextBox runat="server" ID="txtAdviceNo" Width="20%" Enabled="false" ForeColor="Red"></asp:TextBox>
                                <asp:Button runat="server" ID="btnViewAdvice" CssClass="btn-info" Text="Full View" OnClick="btnViewAdvice_Click" />
                        </div>
                        
                        <div class="row">
                            <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <div runat="server" id="lblDays" class="bg-info">Total Days : </div>
                             <telerik:RadGrid ID="subStaffReqGrid" runat="server" DataSourceID="subStaffReqSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemCommand="subStaffReqGrid_ItemCommand" OnDataBound="subStaffReqGrid_DataBound" OnItemDeleted="subStaffReqGrid_ItemDeleted">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="200px" />
                                <Selecting AllowRowSelect="true" />
                                <ClientEvents OnRowDblClick="WorkGrdRowDblClick" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataKeyNames="AutoId" DataSourceID="subStaffReqSource" CommandItemDisplay="Top" CommandItemSettings-AddNewRecordText="Add Work Date" AllowAutomaticDeletes="true">
                                     <Columns>
                                        <telerik:GridButtonColumn CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="FontIconButton" Exportable="false">
                                            <HeaderStyle Width="20px" />
                                        </telerik:GridButtonColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="AutoId" DataType="System.Int32" FilterControlAltText="Filter AutoId column" HeaderText="AutoId" SortExpression="AutoId" UniqueName="AutoId">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="TransDate" FilterControlAltText="Filter TransDate column" HeaderText="Date" ReadOnly="True" SortExpression="TransDate" UniqueName="TransDate" DataFormatString="{0:MM/dd/yyyy}">
                                         <HeaderStyle Width="130px" />
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
                        <asp:SqlDataSource ID="subStaffReqSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM vwSubStaffWReq WHERE (ReqNo = @ReqNo) ORDER BY TransDate" DeleteCommand="DELETE FROM tblSubStaffWReq WHERE AutoId=@AutoId">
                            <SelectParameters>
                                <asp:ControlParameter Name="ReqNo" ControlID="txtReqNo" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" DefaultValue=" " />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="AutoId" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                        </div>
                  
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnComments" Text="Comments" CssClass="btn btn-warning" OnClick="btnComments_Click" style="margin-bottom:0px"  />
                            <asp:Button runat="server" ID="btnPrevious" Text="<<" CssClass="btn btn-default" ToolTip="Previous" OnClick="btnPrevious_Click"  />
                            <asp:Button runat="server" ID="btnNext" Text=">>" CssClass="btn btn-default" ToolTip="Next" OnClick="btnNext_Click" />
                            <asp:CheckBox ID="chkConfirmed" style="color:red;font-size:medium" runat="server" Text="Confirmed" TextAlign="Left" Enabled="false" />
                            <asp:CheckBox ID="chkApproved" style="color:red;font-size:medium" runat="server" Text="Approved" TextAlign="Left" Enabled="false" />
                            <label style="color:green">Approval Date</label>
                            <telerik:RadDatePicker runat="server" ID="dpApprovalDate" Enabled="false" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                            <asp:Button runat="server" ID="btnReturn" Text="Return" CssClass="btn btn-warning" CausesValidation="false" PostBackUrl="~/Operations/Weekly/WeeklyStaffReq.aspx" style="margin-bottom:0px" />
                            <asp:Button runat="server" ID="btnConfirm" Text="Confirm" CssClass="btn btn-primary" OnClick="btnConfirm_Click"/>
                            <asp:Button runat="server" ID="btnFind" Text="Find" CssClass="btn btn-success" OnClientClick="newCostSheetModal()" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnPrint" Text="Print" CssClass="btn btn-info" OnClick="btnPrint_Click"  />
                            <asp:Button runat="server" ID="btnSave" Text="Save Changes" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                        </div>
                       
                        <div class="panel-body">
                                <div class="panel-group" id="accordion">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseAdvice">Advice Details</a>
                                            </h5>
                                        </div>
                                        <div id="collapseAdvice" class="panel-collapse collapse in">
                                            <div class="panel-body">
                                                 <asp:Panel ID="Panel1" runat="server">
                                                   <telerik:RadListView ID="lvAdvice" RenderMode="Lightweight" Width="100%" AllowPaging="True" runat="server" DataSourceID="vwAdviceSource" DataKeyNames="AutoId"
                ItemPlaceholderID="adviceHolder">
                <LayoutTemplate>
                                <table>
                                    <tr>
                                        <td class="tdlabel" style="width:10%">TransDate
                                            </td>
                                        <td class="tdlabel" style="width:10%">Time In
                                            </td>
                                        <td class="tdlabel" style="width:10%">Time Out
                                            </td>
                                        <td class="tdlabel" style="width:8%">Normal
                                            </td>
                                        <td class="tdlabel" style="width:8%">Overtime
                                            </td>
                                        <td class="tdlabel" style="width:7%">Night
                                            </td>
                                        <td class="tdlabel" style="width:10%">Weekends
                                            </td>
                                        <td class="tdlabel" style="width:8%">Holiday
                                            </td>
                                        <td class="tdlabel" style="width:15%">VesselName
                                            </td>
                                        <td class="tdlabel" style="width:7%">ShipSide
                                            </td>
                                        <td class="tdlabel" style="width:7%">Transport
                                            </td>
                                    </tr>
                                    </table>                    
                    <fieldset class="layoutFieldset" id="FieldSet2">
                        <asp:Panel ID="adviceHolder" runat="server">
                        </asp:Panel>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                                <table>
                                        <tr> 
                                            <%--<td style="width:10%">
                                                <%# Eval("TransDate") %>
                                            </td>--%>
                                            <td style="width:10%">
                                                 <%# DataBinder.Eval(Container.DataItem, "TransDate", "{0:dd-MMM-yyyy}") %>
                                            </td>
                                            <td style="width:10%">
                                                <%# Eval("HrsFrom") %>
                                            </td>
                                            <td style="width:10%">
                                                <%# Eval("HrsTo") %>
                                            </td>
                                            <td style="width:8%">
                                                <%# Eval("Normal") %>
                                            </td>
                                            <td style="width:8%">
                                                <%# Eval("Overtime") %>
                                            </td>
                                            <td style="width:7%">
                                                <%# Eval("Night") %>
                                            </td>
                                            <td style="width:10%">
                                                <%# Eval("Weekends") %>
                                            </td>
                                            <td style="width:8%">
                                                <%# Eval("Holiday") %>
                                            </td>
                                            <td style="width:15%">
                                                <%# Eval("VesselName") %>
                                            </td>
                                            <td style="width:7%">
                                               <%# Eval("OnboardAllowance") %>
                                            </td>
                                            <td style="width:7%">
                                                <%# Eval("Transport") %>
                                            </td>
                                        </tr>
                                    </table>
                </ItemTemplate>
            </telerik:RadListView>
                        <asp:SqlDataSource ID="vwAdviceSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select AutoId, AdviceNo, TransDate, Normal, Overtime, Night, Weekends, Holiday, Remarks, VesselberthID, VesselName, Transport, OnBoardAllowance, HrsFrom, HrsTo FROM vwLabourAdviceDays where AdviceNo = @AdviceNo order by TransDate">
                            <SelectParameters>
                                <asp:ControlParameter Name="AdviceNo" ControlID="txtAdviceNo" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" DefaultValue=" " />
                            </SelectParameters>
                        </asp:SqlDataSource>
                                                 </asp:Panel>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">Collapsible Group Item #2</a>
                                            </h4>
                                        </div>
                                        <div id="collapseTwo" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                            </div>
                                        </div>
                                    </div>--%>
                                </div>
                            </div>
                           
                    </ContentTemplate>
                             <Triggers>
                                 <asp:AsyncPostBackTrigger ControlID="btnFindCostSheet" EventName="Click" />
                                 <asp:AsyncPostBackTrigger ControlID="workersGrid" EventName="ItemCommand" />
                                 <asp:AsyncPostBackTrigger ControlID="btnConfirm" EventName="Click" />
                                 <asp:AsyncPostBackTrigger ControlID="btnPrevious" EventName="Click" />
                                 <asp:AsyncPostBackTrigger ControlID="btnNext" EventName="Click" />
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
                                       <asp:TextBox runat="server" ID="txtSearchValue" Width="100%" MaxLength="50" ClientIDMode="Static"></asp:TextBox>
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
                        <%--<asp:SqlDataSource ID="workerSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [WorkerID], [SName], [OName], [GangName], [SSFNo], [TradegroupID], [TradegroupNAME] ,[TradetypeID], [TradetypeNAME], [NHIS], [flags], [ezwichid] FROM [vwWorkers]">
                        </asp:SqlDataSource>--%>
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
                                         <label>Normal Hrs</label>
                                        <telerik:RadNumericTextBox ID="txtNormalHrs" runat="server" Width="100%" MinValue="0" Value="8" NumberFormat-DecimalDigits="1"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNormalHrs" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="new"></asp:RequiredFieldValidator>
                                    </div>
                                     <div class="col-md-3">
                                         <label>Overtime Hrs</label>
                                        <telerik:RadNumericTextBox ID="txtOvertimeHrs" runat="server" Width="100%"  MinValue="0" Value="4" NumberFormat-DecimalDigits="1"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOvertimeHrs" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="new"></asp:RequiredFieldValidator>
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
                            <div class="form-group">
                                    <div class="row">
                                    <div class="col-md-12">
                                        <asp:CheckBox ID="chkShipSide" runat="server" Text="Ship Side" TextAlign="Left" /> 
                                        <asp:CheckBox ID="chkHoliday" runat="server" Text="Holiday" TextAlign="Left" /> 
                                        <asp:CheckBox ID="chkNight" runat="server" Text="Night" TextAlign="Left" /> 
                                        &nbsp;&nbsp;&nbsp; 

                                        <%--<asp:CheckBox ID="CheckBox1" runat="server" Text="Risk" TextAlign="Left" Enabled="false" /> &nbsp;&nbsp;&nbsp; 
                                        <asp:CheckBox ID="CheckBox2" runat="server" Text="Height" TextAlign="Left" Enabled="false" />--%>
                                    </div>
                                </div>
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
                                         <label>Normal Hrs</label>
                                        <telerik:RadNumericTextBox ID="txtNormalHrs1" runat="server" Width="100%" MinValue="0" NumberFormat-DecimalDigits="1"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNormalHrs1" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                    </div>
                                     <div class="col-md-3">
                                         <label>Overtime Hrs</label>
                                        <telerik:RadNumericTextBox ID="txtOvertimeHrs1" runat="server" Width="100%"  MinValue="0" NumberFormat-DecimalDigits="1"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOvertimeHrs1" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="edit"></asp:RequiredFieldValidator>
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
                            <div class="form-group">
                                    <div class="row">
                                    <div class="col-md-12">
                                        <asp:CheckBox ID="chkShipSide1" runat="server" Text="Ship Side" TextAlign="Left" /> 
                                        <asp:CheckBox ID="chkHoliday1" runat="server" Text="Holiday" TextAlign="Left" /> 
                                        <asp:CheckBox ID="chkNight1" runat="server" Text="Night" TextAlign="Left" /> 
                                        &nbsp;&nbsp;&nbsp; 

                                        <%--<asp:CheckBox ID="CheckBox1" runat="server" Text="Risk" TextAlign="Left" Enabled="false" /> &nbsp;&nbsp;&nbsp; 
                                        <asp:CheckBox ID="CheckBox2" runat="server" Text="Height" TextAlign="Left" Enabled="false" />--%>
                                    </div>
                                </div>
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
                    <h4 class="modal-title">Find Cost Sheet</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>Enter Requisition No</label>
                                       <asp:TextBox runat="server" ID="txtCostSheet" Width="100%" MaxLength="50" ClientIDMode="Static"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCostSheet" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="searchcostsheet"></asp:RequiredFieldValidator>
                             </div>
                            <div>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnFindCostSheet" runat="server" Text="Find" CssClass="btn btn-primary"  OnClick="btnFindCostSheet_Click" ValidationGroup="searchcostsheet" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </asp:Panel>
        </div>
         </div>

     <!--  Advice modal -->
    <div class="modal fade" id="advicemodal">
    <div class="modal-dialog" style="width:90%">
      <asp:UpdatePanel runat="server">
          <ContentTemplate>
               <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Cost Sheet Advice</h4>
                </div>
                        <div class="modal-body">
                             
                       </div>
            </div>
          </ContentTemplate>
      </asp:UpdatePanel>
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
            function showAdviceModal() {
                $('#advicemodal').modal('show');
            }
    </script>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function UpdateVesselItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
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
            function WorkGrdRowDblClick(sender, eventArgs) {
                var editedRow = eventArgs.get_itemIndexHierarchical();
                sender.get_masterTableView().fireCommand("EditWork", editedRow);
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
