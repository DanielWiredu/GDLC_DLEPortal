<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ReqComments.aspx.cs" Inherits="GDLC_DLEPortal.Operations.ReqComments" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Comments / Remarks </h5>
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
                                            
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAddComment" CssClass="btn btn-success" Text="Add New" OnClientClick="newModal();" />
                                                <asp:Button runat="server" ID="btnReturn" CssClass="btn btn-warning" Text="Return" OnClick="btnReturn_Click" />
                                            </div>
                                        </div>
                                    </div>
                        <asp:HiddenField runat="server" ID="hfReqNo" />
                             <telerik:RadGrid ID="commentGrid" runat="server" DataSourceID="commentSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemDeleted="commentGrid_ItemDeleted" >
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                 <MasterTableView DataKeyNames="Id" DataSourceID="commentSource" AllowAutomaticDeletes="true">
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" SortExpression="Id" UniqueName="Id">
                                         <HeaderStyle Width="70px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="ReqNo" FilterControlAltText="Filter ReqNo column" HeaderText="Req No" ReadOnly="True" SortExpression="ReqNo" UniqueName="ReqNo">
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Comment" FilterControlAltText="Filter Comment column" HeaderText="Comment" SortExpression="Comment" UniqueName="Comment">
                                         <HeaderStyle Width="300px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="DateCreated" DataType="System.DateTime" FilterControlAltText="Filter DateCreated column" HeaderText="DateCreated" SortExpression="DateCreated" UniqueName="DateCreated">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <%--<telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>--%>
                                         <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Delete" ButtonCssClass="btn-danger" Text="Delete" Exportable="false" ConfirmText="Delete Record?">
                                        <HeaderStyle Width="60px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="commentSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id, ReqNo, Comment, DateCreated FROM tblReqComments WHERE ReqNo = @ReqNo ORDER BY Id DESC" DeleteCommand="DELETE FROM tblReqComments WHERE Id = @Id">
                            <SelectParameters>
                                <%--<asp:CookieParameter Name="DLEcodeCompanyID" CookieName="dlecompanyId" Type="Int32" />--%>
                                <asp:QueryStringParameter Name="ReqNo" QueryStringField="reqno" Type="String" ConvertEmptyStringToNull="false" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="Id" Type="Int32" />
                            </DeleteParameters>
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
                    <h4 class="modal-title"> Comment</h4>
                </div>
                        <div class="modal-body">
                         <div class="form-group">
                               <label>Comment</label>
                               <asp:TextBox ID="txtComment" runat="server" Width="100%" TextMode="MultiLine" Rows="5" ></asp:TextBox>
                              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtComment" Display="Dynamic" ForeColor="Red" ErrorMessage="Required Field" SetFocusOnError="true" ValidationGroup="comment"></asp:RequiredFieldValidator>
                           </div>
                       </div>
                <div class="modal-footer">
                     <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveComment" runat="server" Text="Save Comment" CssClass="btn btn-primary" ValidationGroup="comment" OnClick="btnSaveComment_Click" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" />
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
    </script>
</asp:Content>
