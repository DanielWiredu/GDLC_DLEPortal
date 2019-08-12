<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="Invoices.aspx.cs" Inherits="GDLC_DLEPortal.GDLCAdmin.Downloads.Invoices" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/telerikCombo.css" rel="stylesheet" />
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>GDLC Invoices</h5>
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

                        <div class="row">
                                        <div class="col-sm-4 pull-right" >
                                            <asp:TextBox runat="server" ID="txtSearchStaffReq" Width="100%" placeholder="File Name..." OnTextChanged="txtSearchStaffReq_TextChanged" AutoPostBack="true"></asp:TextBox>                                        
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <%--<asp:Button runat="server" ID="btnUpload" CssClass="btn btn-primary" Text="Upload" CausesValidation="false" OnClientClick="showuploadModal();"/>--%>
                                                <a class="btn btn-primary" onclick="showuploadModal();">Upload</a>
                                            </div>
                                        </div>
                                    </div>

                        <hr />
                             <telerik:RadGrid ID="invoiceGrid" runat="server" DataSourceID="invoiceSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemCommand="invoiceGrid_ItemCommand" >
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                 <MasterTableView DataKeyNames="Id" DataSourceID="invoiceSource">
                                     <Columns>
                                         <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" SortExpression="Id" UniqueName="Id">
                                         <HeaderStyle Width="60px" />
                                         </telerik:GridBoundColumn>
                                         <%--<telerik:GridBoundColumn DataField="DLEcodeCompanyName" FilterControlAltText="Filter DLEcodeCompanyName column" HeaderText="DLE Company" SortExpression="DLEcodeCompanyName" UniqueName="DLEcodeCompanyName">
                                         <HeaderStyle Width="180px" />
                                         </telerik:GridBoundColumn>--%>
                                         <telerik:GridBoundColumn DataField="FileName" FilterControlAltText="Filter FileName column" HeaderText="FileName" SortExpression="FileName" UniqueName="FileName">
                                         <HeaderStyle Width="380px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="FileType" FilterControlAltText="Filter FileType column" HeaderText="FileType" SortExpression="FileType" UniqueName="FileType">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="FilePath" FilterControlAltText="Filter FilePath column" HeaderText="FilePath" SortExpression="FilePath" UniqueName="FilePath">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="DateFrom" DataType="System.DateTime" FilterControlAltText="Filter DateFrom column" HeaderText="DateFrom" SortExpression="DateFrom" UniqueName="DateFrom" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="110px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridDateTimeColumn DataField="DateTo" DataType="System.DateTime" FilterControlAltText="Filter DateTo column" HeaderText="DateTo" SortExpression="DateTo" UniqueName="DateTo" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="110px" />
                                         </telerik:GridDateTimeColumn>
                                        <%-- <telerik:GridBoundColumn DataField="ReportType" FilterControlAltText="Filter ReportType column" HeaderText="ReportType" SortExpression="ReportType" UniqueName="ReportType">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>--%>
                                         <telerik:GridDateTimeColumn DataField="CreatedDate" DataType="System.DateTime" FilterControlAltText="Filter CreatedDate column" HeaderText="CreatedDate" SortExpression="CreatedDate" UniqueName="CreatedDate">
                                         <HeaderStyle Width="145px" />
                                         </telerik:GridDateTimeColumn>
                                        <telerik:GridButtonColumn CommandName="Download" Text="Download" UniqueName="Download">
                                        <ItemStyle  ForeColor="Blue" Font-Underline="true" Font-Bold="true"/>
                                         <HeaderStyle Width="70px" />
                                        </telerik:GridButtonColumn>
                                        <telerik:GridButtonColumn CommandName="Delete" Text="Delete" ConfirmText="Delete Document?" UniqueName="Delete">
                                        <ItemStyle  ForeColor="Red" Font-Underline="true" Font-Bold="true"/>
                                         <HeaderStyle Width="60px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="invoiceSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP (50) Id, DLEcodeCompanyName, FileName, FileType, FilePath, DateFrom, DateTo, ReportType, CreatedDate FROM vwFileUploads WHERE (FileName LIKE '%' + @FileName + '%') ORDER BY Id DESC">
                            <SelectParameters>
                                <asp:ControlParameter Name="FileName" ControlID="txtSearchStaffReq" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                   
                    </div>
                </div>
        </div>

            <!-- upload modal -->
    <div class="modal fade" id="uploadmodal">

    <div class="modal-dialog" style="width:50%">
        <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="upUpload">
                           <ProgressTemplate>
                            <div class="divWaiting">            
	                            <asp:Label ID="lblWait" runat="server" Text="Processing... " />
	                              <asp:Image ID="imgWait" runat="server" ImageAlign="Top" ImageUrl="/Content/img/loader.gif" />
                                </div>
                             </ProgressTemplate>
                       </asp:UpdateProgress>
      <asp:UpdatePanel runat="server" ID="upUpload" UpdateMode="Conditional">
          <ContentTemplate>
               <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Upload Document</h4>
                </div>
                        <div class="modal-body">
                         <div class="form-group">
                             <label>File</label>
                             <asp:FileUpload ID="FileUpload1" runat="server" />
                        </div>
                        <div class="form-group">
                                    <label>DLE Company</label>
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
                                        <asp:SqlDataSource ID="dleSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (30) DLEcodeCompanyID,DLEcodeCompanyName FROM [tblDLECompany] ORDER BY DLEcodeCompanyName"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlCompany" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                    <label>Report Type</label>
                                    <telerik:RadDropDownList runat="server" ID="dlReportType" Width="100%" DefaultMessage="Select Report Type" DropDownHeight="150px">
                                        <Items >
                                            <telerik:DropDownListItem Text="Daily Processed" />
                                            <telerik:DropDownListItem Text="Daily Invoice" />
                                            <telerik:DropDownListItem Text="Weekly Processed" />
                                            <telerik:DropDownListItem Text="Weekly Invoice" />
                                            <telerik:DropDownListItem Text="Monthly Processed" />
                                            <telerik:DropDownListItem Text="Monthly Invoice" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dlReportType" Display="Dynamic" ErrorMessage="Select Report Type" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                    <label">Start Date</label>
                                        <telerik:RadDatePicker runat="server" ID="dpDateFrom" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpDateFrom" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                    <label">End Date</label>
                                        <telerik:RadDatePicker runat="server" ID="dpDateTo" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpDateTo" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Return</button>
                   <asp:Button runat="server" ID="btnSaveFile" Text="Save" CssClass="btn btn-primary" OnClick="btnSaveFile_Click" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" />
                </div>
            </div>
          </ContentTemplate>
               <Triggers>
                     <asp:PostBackTrigger ControlID="btnSaveFile" />
                 </Triggers>
      </asp:UpdatePanel>
        </div>
    </div>

    <script type="text/javascript">
        function showuploadModal() {
            $('#uploadmodal').modal('show');
            $('#uploadmodal').appendTo($("form:first"));
        }
        function closeuploadModal() {
            $('#uploadmodal').modal('hide');
        }
    </script>
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function UpdateCompanyItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
