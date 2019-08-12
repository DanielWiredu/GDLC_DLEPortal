<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Requests.aspx.cs" Inherits="GDLC_DLEPortal.LabourRequest.Requests" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Labour Request</h5>
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
                                        <div class="col-sm-4 pull-right">
                                            <asp:TextBox runat="server" ID="txtSearchReq" Width="100%" placeholder="Request No..." AutoPostBack="true" OnTextChanged="txtSearchReq_TextChanged"></asp:TextBox>                                        
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add New" CausesValidation="false" UseSubmitBehavior="false" OnClientClick="newModal();"/>
                                            </div>
                                        </div>
                                    </div>
                        
                             <telerik:RadGrid ID="RequestGrid" runat="server" DataSourceID="RequestSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemCommand="RequestGrid_ItemCommand" OnDeleteCommand="RequestGrid_DeleteCommand" >
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                 <MasterTableView DataKeyNames="RequestNo" DataSourceID="RequestSource">
                                     <Columns>
                                         <telerik:GridBoundColumn DataField="RequestNo" FilterControlAltText="Filter RequestNo column" HeaderText="RequestNo" SortExpression="RequestNo" UniqueName="RequestNo">
                                         <HeaderStyle Width="70px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Request" FilterControlAltText="Filter Request column" HeaderText="Request Description" SortExpression="Request" UniqueName="Request">
                                         <HeaderStyle Width="300px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="DLECompanyId" DataType="System.Int32" SortExpression="DLECompanyId" UniqueName="DLECompanyId" Display="false"> </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="DLEcodeCompanyName" FilterControlAltText="Filter DLEcodeCompanyName column" HeaderText="Company Name" SortExpression="DLEcodeCompanyName" UniqueName="DLEcodeCompanyName">
                                         <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="CreatedBy" FilterControlAltText="Filter CreatedBy column" HeaderText="CreatedBy" SortExpression="CreatedBy" UniqueName="CreatedBy">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="DateCreated" DataType="System.DateTime" FilterControlAltText="Filter DateCreated column" HeaderText="DateCreated" SortExpression="DateCreated" UniqueName="DateCreated">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridCheckBoxColumn DataField="Submitted" AllowFiltering="true" DataType="System.Boolean" FilterControlAltText="Filter Submitted column" HeaderText="S" SortExpression="Submitted" UniqueName="Submitted" StringTrueValue="1" StringFalseValue="0" >
                                         <HeaderStyle Width="30px" />
                                         </telerik:GridCheckBoxColumn>
                                         <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>
                                         <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Delete" ButtonCssClass="btn-danger" Text="Delete" Exportable="false" ConfirmText="Delete Record?">
                                        <HeaderStyle Width="60px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="RequestSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP (100) RequestNo, Request, DLECompanyId, DLEcodeCompanyName, Submitted, CreatedBy, DateCreated FROM vwLabourRequest WHERE DLECompanyId IN (SELECT * FROM dbo.DLEIdToTable(@DLECompanyId)) AND (RequestNo LIKE '%' + @RequestNo + '%') ORDER BY RequestNo DESC">
                            <SelectParameters>
                                <asp:CookieParameter Name="DLECompanyId" CookieName="dlecompanyId" Type="String" />
                                <asp:ControlParameter Name="RequestNo" ControlID="txtSearchReq" Type="String" PropertyName="Text" DefaultValue="0" ConvertEmptyStringToNull="false" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>

    <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server" ID="upComment">
            <ContentTemplate>
                  <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"> Request</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Request No</label>
                                <asp:TextBox runat="server" ID="txtRequestNo" Width="100%" Enabled="false"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRequestNo" Display="Dynamic" ForeColor="Red" ErrorMessage="Required Field" SetFocusOnError="true" ValidationGroup="newsubmit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label> Company</label>
                                <telerik:RadComboBox ID="dlCompany" runat="server" Width="100%" DataSourceID="dleSource" MaxHeight="300px" EmptyMessage="Select company" DataTextField="DLEcodeCompanyName" DataValueField="DLEcodeCompanyID"></telerik:RadComboBox>
                                <asp:SqlDataSource ID="dleSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="dlCompany" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="newrequest"></asp:RequiredFieldValidator>
                         </div>
                         <div class="form-group">
                               <label>Request</label>
                               <asp:TextBox ID="txtRequest" runat="server" Width="100%" TextMode="MultiLine" Rows="10" ></asp:TextBox>
                              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRequest" Display="Dynamic" ForeColor="Red" ErrorMessage="Required Field" SetFocusOnError="true" ValidationGroup="newrequest"></asp:RequiredFieldValidator>
                           </div>
                       </div>
                <div class="modal-footer">
                     <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" ValidationGroup="newrequest" OnClick="btnSave_Click" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" />
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-info" ValidationGroup="newsubmit" OnClick="btnSubmit_Click" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" Enabled="false" />
                </div>

            </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        </div>
    </div>

     <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                  <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"> Request</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Request No</label>
                                <asp:TextBox runat="server" ID="txtRequestNo1" Width="100%" Enabled="false"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRequestNo1" Display="Dynamic" ForeColor="Red" ErrorMessage="Required Field" SetFocusOnError="true" ValidationGroup="editsubmit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label> Company</label>
                                <telerik:RadComboBox ID="dlCompany1" runat="server" Width="100%" DataSourceID="dleSource" MaxHeight="300px" EmptyMessage="Select company" DataTextField="DLEcodeCompanyName" DataValueField="DLEcodeCompanyID"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="dlCompany1" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="editrequest"></asp:RequiredFieldValidator>
                         </div>
                         <div class="form-group">
                               <label>Request</label>
                               <asp:TextBox ID="txtRequest1" runat="server" Width="100%" TextMode="MultiLine" Rows="10" ></asp:TextBox>
                              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRequest1" Display="Dynamic" ForeColor="Red" ErrorMessage="Required Field" SetFocusOnError="true" ValidationGroup="editrequest"></asp:RequiredFieldValidator>
                           </div>
                       </div>
                <div class="modal-footer">
                     <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" ValidationGroup="editrequest" OnClick="btnUpdate_Click" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" />
                    <asp:Button ID="btnSubmit1" runat="server" Text="Submit" CssClass="btn btn-info" ValidationGroup="editsubmit" OnClick="btnSubmit1_Click" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" Enabled="false" />
                </div>

            </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        </div>
    </div>
    <script type="text/javascript">
        function newModal() {
            $('#newmodal').modal('show');
            $('#newmodal').appendTo($("form:first"));
        }
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
    </script>
</asp:Content>
