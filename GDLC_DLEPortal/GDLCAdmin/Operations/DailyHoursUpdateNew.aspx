<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="DailyHoursUpdateNew.aspx.cs" Inherits="GDLC_DLEPortal.GDLCAdmin.Operations.DailyHoursUpdateNew" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/aspControlStyle.css" rel="stylesheet" />
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5> Daily Requisition </h5>
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
                         <asp:UpdatePanel runat="server" UpdateMode="Always" ID="upMain">
                    <ContentTemplate>
                        <div runat="server" id="lblMsg"></div>
                        <div class="row">
                            <div class="col-md-5">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Requisition No</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtAutoNo" runat="server" Width="49%" Enabled="false"></asp:TextBox>
                                        <asp:TextBox ID="txtReqNo" runat="server" Width="49%" ReadOnly="true"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtReqNo" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">DLE Company</label>
                                    <div class="col-sm-8">
                                        <telerik:RadComboBox ID="dlCompany" runat="server" Width="100%" DataSourceID="dleSource" EmptyMessage="Select Company" Filter="Contains"
                                           OnItemDataBound="dlCompany_ItemDataBound"  >
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
                                        <asp:SqlDataSource ID="dleSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlCompany" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Vessel</label>
                                    <div class="col-sm-8">
                                        <telerik:RadComboBox ID="dlVessel" runat="server" Width="100%" DataSourceID="vesselSource" EmptyMessage="Select Vessel" Filter="Contains"
                                          OnItemDataBound="dlVessel_ItemDataBound" >
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
                                        <asp:SqlDataSource ID="vesselSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlVessel" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Reporting Point</label>
                                    <div class="col-sm-8">
                                        <telerik:RadComboBox ID="dlReportingPoint" runat="server" Width="100%" DataSourceID="repPointSource" EmptyMessage="Select Reporting Point" Filter="Contains"
                                           OnItemDataBound="dlReportingPoint_ItemDataBound"  >
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
                                        <telerik:RadComboBox ID="dlLocation" runat="server" Width="100%" DataSourceID="locationSource" EmptyMessage="Select Location" Filter="Contains"
                                          OnItemDataBound="dlLocation_ItemDataBound"   >
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
                                        <asp:SqlDataSource ID="locationSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ></asp:SqlDataSource>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Normal Hours</label>
                                    <div class="col-sm-8">
                                        <telerik:RadTimePicker ID="tpNormalFrom" runat="server" Width="49%" TimePopupButton-Visible="false" DateInput-ReadOnly="true"></telerik:RadTimePicker>
                                        <telerik:RadTimePicker ID="tpNormalTo" runat="server" Width="49%" TimePopupButton-Visible="false" DateInput-ReadOnly="true"></telerik:RadTimePicker>
                                    </div>
                                </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Requisition Date</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker runat="server" ID="dpRegdate" Width="100%" DateInput-ReadOnly="true" DatePopupButton-Visible="false"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpRegdate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <%--<div class="form-group">
                                    <label class="col-sm-4 control-label">Approval Date</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker runat="server" ID="dpApprovalDate" Enabled="false" Width="100%" DateInput-ReadOnly="true" SelectedDate="01/01/2000"></telerik:RadDatePicker>
                                    </div>
                                </div>--%>
                                  <div class="form-group">
                                    <label class="col-sm-4 control-label">Cargo</label>
                                    <div class="col-sm-8">
                                        <telerik:RadComboBox ID="dlCargo" runat="server" Width="100%" DataSourceID="cargoSource" EmptyMessage="Select Cargo" Filter="Contains"
                                           OnItemDataBound="dlCargo_ItemDataBound" >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncolfull">CARGO</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "CargoName")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="cargoCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="cargoSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Gang</label>
                                    <div class="col-sm-8">
                                        <telerik:RadComboBox ID="dlGang" runat="server" Width="100%" DataSourceID="gangSource" EmptyMessage="Select Gang" Filter="Contains"
                                        OnItemDataBound="dlGang_ItemDataBound"  >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncolfull">GANG</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "GangName")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="gangCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="gangSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Job Description</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtJobDescription" runat="server" Width="100%" ReadOnly="true" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Overtime Hours</label>
                                    <div class="col-sm-8">
                                        <telerik:RadTimePicker ID="tpOvertimeFrom" runat="server" Width="49%" TimePopupButton-Visible="false" DateInput-ReadOnly="true"></telerik:RadTimePicker>
                                        <telerik:RadTimePicker ID="tpOvertimeTo" runat="server" Width="49%" TimePopupButton-Visible="false" DateInput-ReadOnly="true"></telerik:RadTimePicker>
                                    </div>
                                </div>
                                </div>
                            </div>
                                        <div class="col-md-2">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <div class="col-sm-12">
                                        <asp:CheckBox ID="chkShipSide" runat="server" Text="Ship Side" TextAlign="Left" Enabled="true" /> <br />
                                        <asp:CheckBox ID="chkHoliday" runat="server" Text="Weekend/Holiday" TextAlign="Left" Enabled="true" /><br />
                                        <asp:CheckBox ID="chkNight" runat="server" Text="Night" TextAlign="Left" Enabled="true" />
                                        &nbsp;&nbsp;&nbsp; 
                                        

                                        <asp:CheckBox ID="chkProcessed" runat="server" Text="Processed" TextAlign="Left" Visible="false" />
                                        <asp:CheckBox ID="chkStored" runat="server" Text="Stored" TextAlign="Left" Visible="false" />
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-7 control-label">Normal Hrs</label>
                                    <div class="col-sm-5">
                                        <telerik:RadNumericTextBox ID="txtNormalHrs" runat="server" Width="100%"  MinValue="0" NumberFormat-DecimalDigits="1" ReadOnly="true"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNormalHrs" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-7 control-label">Overtime Hrs</label>
                                    <div class="col-sm-5">
                                         <telerik:RadNumericTextBox ID="txtOvertimeHrs" runat="server" Width="100%"  MinValue="0" NumberFormat-DecimalDigits="1" ReadOnly="true"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOvertimeHrs" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <div runat="server" id="lblGangs" class="bg-info">Total Members : </div>
                             <telerik:RadGrid Enabled="false" ID="subStaffReqGrid" runat="server" DataSourceID="subStaffReqSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnDataBound="subStaffReqGrid_DataBound">
                            <ClientSettings AllowKeyboardNavigation="true">
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="250px" />
                                <Selecting AllowRowSelect="true" />
                                <KeyboardNavigationSettings AllowActiveRowCycle="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataKeyNames="AutoId" DataSourceID="subStaffReqSource" CommandItemDisplay="Top" CommandItemSettings-AddNewRecordText="Add Worker">
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataField="AutoId" DataType="System.Int32" FilterControlAltText="Filter AutoId column" HeaderText="AutoId" SortExpression="AutoId" UniqueName="AutoId">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="WorkerID" FilterControlAltText="Filter WorkerID column" HeaderText="Worker ID" ReadOnly="True" SortExpression="WorkerID" UniqueName="WorkerID">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="SName" FilterControlAltText="Filter SName column" HeaderText="Surname" SortExpression="SName" UniqueName="SName">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="OName" FilterControlAltText="Filter OName column" HeaderText="Other Names" SortExpression="OName" UniqueName="OName">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="TradetypeNAME" FilterControlAltText="Filter TradetypeNAME column" HeaderText="Category" SortExpression="TradetypeNAME" UniqueName="TradetypeNAME">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="TradegroupNAME" FilterControlAltText="Filter TradegroupNAME column" HeaderText="Group" SortExpression="TradegroupNAME" UniqueName="TradegroupNAME">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="transport" FilterControlAltText="Filter transport column" HeaderText="*" SortExpression="transport" UniqueName="transport" EmptyDataText="" ConvertEmptyStringToNull="false">
                                         <HeaderStyle Width="20px" />
                                         </telerik:GridBoundColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="subStaffReqSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM vwSubStaffReq WHERE (ReqNo = @ReqNo)" DeleteCommand="DELETE FROM tblSubStaffReq WHERE AutoId=@AutoId">
                            <SelectParameters>
                                <asp:ControlParameter Name="ReqNo" ControlID="txtReqNo" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" DefaultValue=" " />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                        </div>
                  
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnComments" Text="Comments" CssClass="btn btn-warning" OnClick="btnComments_Click" style="margin-bottom:0px" />
                            <asp:Button runat="server" ID="btnPrevious" Text="<<" CssClass="btn btn-default" ToolTip="Previous"  OnClick="btnPrevious_Click" />
                            <asp:Button runat="server" ID="btnNext" Text=">>" CssClass="btn btn-default" ToolTip="Next"  OnClick="btnNext_Click" />
                            <asp:CheckBox ID="chkApproved" style="color:red;font-size:medium" runat="server" Text="Approved" TextAlign="Left" Enabled="false" />
                            <label style="color:green">Approval Date</label>
                            <telerik:RadDatePicker runat="server" ID="dpApprovalDate" ClientIDMode="Static" Enabled="true" DateInput-ReadOnly="false" SelectedDate="01/01/2000"></telerik:RadDatePicker>
                            <asp:Button runat="server" ID="btnReturn" Text="Return" CssClass="btn btn-warning" style="margin-bottom:0px" CausesValidation="false" PostBackUrl="~/GDLCAdmin/Operations/DailyStaffReq.aspx" />
                            <a class="btn btn-success" onclick="newModal()" >Find</a>                           
                             <asp:Button runat="server" ID="btnPrint" Text="Print" CssClass="btn btn-info" OnClick="btnPrint_Click" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false"  />
                            <asp:Button runat="server" ID="btnDisapprove" Text="Disapprove" CssClass="btn btn-danger" OnClick="btnDisapprove_Click" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" />
                        </div>   
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>


         <!-- new modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:40%">
        <asp:Panel runat="server" DefaultButton="btnSearch">
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
                                       <asp:TextBox runat="server" ID="txtSearchValue" ClientIDMode="Static" Width="100%" MaxLength="50" ></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtSearchValue" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="search"></asp:RequiredFieldValidator>
                             </div>
                            <div>
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
                function newModal() {
                $('#newmodal').modal('show');
                $('#newmodal').appendTo($("form:first"));
                }
                $('#newmodal').on('shown.bs.modal', function () {                    
                    // jQuery code is in here
                    $('#txtSearchValue').focus();
                });

            function closenewModal() {
                $('#newmodal').modal('hide');
            }
    </script>
</asp:Content>
