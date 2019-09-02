<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="EditRequestForm.aspx.cs" Inherits="GDLC_DLEPortal.LabourRequest.EditRequestForm" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/aspControlStyle.css" rel="stylesheet" />
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Edit Labour Request Form</h5>
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
                         <asp:UpdatePanel runat="server" ID="upMain" UpdateMode="Conditional" ChildrenAsTriggers="true">
                    <ContentTemplate>

                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnSaveRequest" CssClass="btn btn-success" Text="Update Request" OnClick="btnSaveRequest_Click" />  
                                                <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-danger" Text="Create New" CausesValidation="false" PostBackUrl="~/LabourRequest/NewRequestForm.aspx" /> 
                                                <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-primary" Text="Submit" CausesValidation="false" OnClick="btnSubmit_Click" Enabled="false" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" />
                                                <asp:Button runat="server" ID="btnReturn" CssClass="btn btn-warning" Text="Return" CausesValidation="false" PostBackUrl="~/LabourRequest/RequestForms.aspx" /> 
                                            </div>
                                        </div>
                                    </div>

                        <hr />

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Request No</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtReqNo" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                        <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="txtReqNo" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Request Date</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker runat="server" ID="dpReqdate" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpReqdate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Company</label>
                                    <div class="col-sm-8">
                                        <telerik:RadComboBox ID="dlCompany" runat="server" Width="100%" DataSourceID="dleSource" MaxHeight="300px" EmptyMessage="Select company" DataTextField="DLEcodeCompanyName" DataValueField="DLEcodeCompanyID"></telerik:RadComboBox>
                                        <asp:SqlDataSource ID="dleSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlCompany" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Terminal</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtTerminal" runat="server" Width="100%"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTerminal" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-horizontal">
                                   <div class="form-group">
                                    <label class="col-sm-4 control-label">Vessel</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtVessel" runat="server" Width="100%"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtVessel" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">DOA</label>
                                    <div class="col-sm-8">
                                        <%--<asp:TextBox ID="txtDOA" runat="server" Width="100%"></asp:TextBox>--%>
                                        <telerik:RadDatePicker runat="server" ID="dpDOA" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpDOA" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Activity</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList runat="server" ID="dlActivity" Width="100%" DefaultMessage="Select Activity">
                                            <Items>
                                                <telerik:DropDownListItem Text="Ship Operation" />
                                                <telerik:DropDownListItem Text="Delivers" />
                                                <telerik:DropDownListItem Text="Others" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlActivity" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Work Shift</label>
                                        <div class="col-sm-8">
                                            <telerik:RadDropDownList runat="server" ID="dlWorkShift" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="Day" />
                                                <telerik:DropDownListItem Text="Night" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                            &nbsp;&nbsp;&nbsp; 
                                            <asp:CheckBox ID="chkSubmitted" runat="server" Text="Submitted" TextAlign="Left" Visible="false" />
                                        </div>
                                </div>
                                </div>
                                </div>
                            </div>
                        

                       

                                <div class="row">
                                    <asp:UpdatePanel runat="server" ID="upLabour">
                                        <ContentTemplate>
                                            <div class="row">
                                                 <div class="col-sm-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">Add Labour Category</div>
                            <div class="panel-body">
                                <div class="form-group">
                                       <label>Category</label>
                                       <telerik:RadComboBox ID="dlLabourCategory" runat="server" Width="100%" DataSourceID="categorySource" MaxHeight="200" EmptyMessage="Select Category" DataValueField="Id" DataTextField="LabourCategory" Filter="Contains" AllowCustomText="false" MarkFirstMatch="true" HighlightTemplatedItems="true">
                                       </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="categorySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id, LabourCategory FROM [tblLabourCategory]"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlLabourCategory" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="labour"></asp:RequiredFieldValidator>
                             </div>
                                <div class="form-group">
                                    <label>Number</label>
                                    <telerik:RadNumericTextBox ID="txtNumber" runat="server" Width="100%" MinValue="0" NumberFormat-DecimalDigits="0"></telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNumber" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="labour"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <label>Justification</label>
                                    <asp:TextBox runat="server" ID="txtJustification" Width="100%"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label>Remarks</label>
                                    <asp:TextBox runat="server" ID="txtRemarks" Width="100%" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" ID="btnSaveCategory" Text="Add" CssClass="btn btn-primary" OnClick="btnSaveCategory_Click" ValidationGroup="labour"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-8">
                        <div class="panel panel-default">
                            <div class="panel-heading">Category of Labour</div>
                            <div class="panel-body">
                                <telerik:RadGrid ID="labourCategoryGrid" ShowFooter="true" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="False" AllowPaging="True" AllowSorting="True" CellSpacing="-1" DataSourceID="labourCategorySource" GridLines="Both" OnItemDeleted="labourCategoryGrid_ItemDeleted">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="270px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                 <MasterTableView DataKeyNames="Id" DataSourceID="labourCategorySource" AllowAutomaticDeletes="true">
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="LabourCategory" HeaderText="LabourCategory" SortExpression="LabourCategory" UniqueName="LabourCategory">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Aggregate="Sum" DataField="LabourNo" HeaderText="LabourNo" SortExpression="LabourNo" UniqueName="LabourNo">
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Justification" HeaderText="Justification" SortExpression="Justification" UniqueName="Justification">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" UniqueName="Remarks">
                                         <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="labourCategorySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [tblLabourRequestFormDetails] WHERE [Id] = @Id" SelectCommand="SELECT Id, LabourCategory, LabourNo, Justification, Remarks FROM [vwLabourRequestFormDetails] WHERE RequestNo = @RequestNo">
                            <SelectParameters>
                                <asp:ControlParameter Name="RequestNo" ControlID="txtReqNo" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" DefaultValue=" " />
                                <%--<asp:QueryStringParameter QueryStringField="RequestNo" Name="RequestNo" Type="String" ConvertEmptyStringToNull="false" DefaultValue=" " />--%>
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="Id" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                         </div>
                        </div>
                            </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>     
                </div>
                          

                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
