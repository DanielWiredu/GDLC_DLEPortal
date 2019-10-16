<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="EditAdvice.aspx.cs" Inherits="GDLC_DLEPortal.GDLCAdmin.Operations.EditAdvice" %>

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
                        <h5>View Advice</h5>
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
                             <telerik:RadGrid Enabled="false" ID="subStaffReqGrid" runat="server" DataSourceID="subStaffReqSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnDataBound="subStaffReqGrid_DataBound">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="250px" />
                                <Selecting AllowRowSelect="true" />
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
                            <asp:Button runat="server" ID="btnPrevious" Text="<<" CssClass="btn btn-default" ToolTip="Previous" OnClick="btnPrevious_Click" />
                            <asp:Button runat="server" ID="btnNext" Text=">>" CssClass="btn btn-default" ToolTip="Next" OnClick="btnNext_Click" />
                            <asp:CheckBox ID="chkProcessed" style="color:red;font-size:medium;margin-right:10px" runat="server" Text="Processed" TextAlign="Left" Enabled="false" />
                            <asp:Button runat="server" ID="btnReturn" Text="Return" CssClass="btn btn-warning" CausesValidation="false" PostBackUrl="~/GDLCAdmin/Operations/Advice.aspx" style="margin-bottom:0px" />
                            <asp:Button runat="server" ID="btnFind" Text="Find" CssClass="btn btn-success" OnClientClick="newCostSheetModal()" CausesValidation="false" />
                        </div>   
                    </ContentTemplate>
                             <Triggers>
                                 <asp:AsyncPostBackTrigger ControlID="btnFindCostSheet" EventName="Click" />
                             </Triggers>
                </asp:UpdatePanel>
                    </div>
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
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
