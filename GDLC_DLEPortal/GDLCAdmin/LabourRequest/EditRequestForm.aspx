<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="EditRequestForm.aspx.cs" Inherits="GDLC_DLEPortal.GDLCAdmin.LabourRequest.EditRequestForm" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/aspControlStyle.css" rel="stylesheet" />
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>View Labour Request Form</h5>
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
                         <asp:UpdatePanel runat="server" ID="upMain" UpdateMode="Conditional" ChildrenAsTriggers="true">
                    <ContentTemplate>

                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnReturn" CssClass="btn btn-warning" Text="Return" CausesValidation="false" PostBackUrl="~/GDLCAdmin/LabourRequest/RequestForms.aspx" /> 
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
                                        <asp:TextBox runat="server" ID="txtCompany" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Terminal</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtTerminal" runat="server" Width="100%"></asp:TextBox>
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
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">DOA</label>
                                    <div class="col-sm-8">
                                        <%--<asp:TextBox ID="txtDOA" runat="server" Width="100%"></asp:TextBox>--%>
                                        <telerik:RadDatePicker runat="server" ID="dpDOA" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
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
                                                 
                    <div class="col-sm-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">Category of Labour</div>
                            <div class="panel-body">
                                <telerik:RadGrid ID="labourCategoryGrid" ShowFooter="true" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="False" AllowPaging="True" AllowSorting="True" CellSpacing="-1" DataSourceID="labourCategorySource" GridLines="Both">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="270px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                 <MasterTableView DataKeyNames="Id" DataSourceID="labourCategorySource" AllowAutomaticDeletes="true">
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" HeaderText="SupervisorId" ReadOnly="True" SortExpression="Id" UniqueName="Id">
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
                                     </Columns>
                                 </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="labourCategorySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id, LabourCategory, LabourNo, Justification, Remarks FROM [vwLabourRequestFormDetails] WHERE RequestNo = @RequestNo">
                            <SelectParameters>
                                <asp:ControlParameter Name="RequestNo" ControlID="txtReqNo" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" DefaultValue=" " />
                            </SelectParameters>
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
