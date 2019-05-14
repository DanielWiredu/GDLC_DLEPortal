<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="NewUser.aspx.cs" Inherits="GDLC_DLEPortal.GDLCAdmin.Security.NewUser" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/telerikCombo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>New User</h5>
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
                         <asp:UpdatePanel runat="server" >
                    <ContentTemplate>
                            <div>
                  <div class="form-group">
                 <div class="row">
                     <div class="col-md-3">
                         <label>Username</label>
                         <asp:TextBox ID="txtUsername" runat="server" Width="100%" MaxLength="30"></asp:TextBox>
                          <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtUsername" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                     </div>
                     <div class="col-md-3">
                         <label>Password</label>
                         <asp:TextBox ID="txtPassword" runat="server" Width="100%" TextMode="Password"></asp:TextBox>
                         <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                     </div>
                     <div class="col-md-6">
                         <label>Fullname</label>
                         <asp:TextBox ID="txtFullname" runat="server" Width="100%"></asp:TextBox>
                         <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtFullname" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                     </div>
                 </div>
             </div>
                      <div class="form-group">
                 <div class="row">
                         <div class="col-md-3">
                         <label>Gender</label>
                         <telerik:RadDropDownList ID="dlGender" runat="server" Width="100%">
                             <Items>
                                 <telerik:DropDownListItem Text="Male" />
                                 <telerik:DropDownListItem Text="Female"  />
                             </Items>
                         </telerik:RadDropDownList>
                     </div>
                    <div class="col-md-3">
                         <label>Mobile No.</label>
                         <asp:TextBox ID="txtMobile" runat="server" Width="100%"></asp:TextBox>
                        <asp:RegularExpressionValidator Runat="server" ControlToValidate="txtMobile" Display="Dynamic" ErrorMessage="Please enter numbers only." ForeColor="Red" SetFocusOnError="true" ValidationExpression="(^([0-9]*|\d*\d{1}?\d*)$)"></asp:RegularExpressionValidator>
                     </div>
                     <div class="col-md-3">
                         <label>User Key</label>
                         <asp:TextBox ID="txtUserkey" runat="server" Width="100%" MaxLength="2" Text="PT" ReadOnly="true"></asp:TextBox>
                         <%--<asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtUserkey" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
                     </div>
                       <div class="col-md-3">
                         <label>Active</label>
                         <asp:CheckBox runat="server" ID="chkActive" Width="100%" />
                     </div>
                           
                 </div>
             </div>
                     <div class="form-group">
                         <div class="row">
                               <div class="col-md-6">
                         <label>Email</label>
                         <asp:TextBox ID="txtEmail" runat="server" Width="100%" TextMode="Email"></asp:TextBox>
                     </div>
                      <div class="col-md-6">
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
                                        <asp:SqlDataSource ID="dleSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (30) DLEcodeCompanyID,DLEcodeCompanyName FROM [tblDLECompany] WHERE Active = 1"></asp:SqlDataSource>
<%--                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlCompany" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                         </div>
                         </div>
                     </div>
                     <div class="form-group">
                         <div class="row">
                              <div class="col-md-6">
                         <label>Account Type</label>
                           <telerik:RadDropDownList ID="dlAccoutType" runat="server" Width="100%">
                             <Items>
                                 <telerik:DropDownListItem Text="Employer" />
                                 <telerik:DropDownListItem Text="GDLC" />
                             </Items>
                         </telerik:RadDropDownList>
                            </div>
                         <div class="col-md-6">
                         <label>User Role</label>
                         <telerik:RadComboBox ID="dlRoles" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" runat="server" Width="100%" DataSourceID="roleSource" DataTextField="Userrole" DataValueField="Userrole" Filter="None" MarkFirstMatch="false" Text="Select Roles"></telerik:RadComboBox>
                          <asp:SqlDataSource ID="roleSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Userrole from tblUserRoles"></asp:SqlDataSource>  
                          <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlRoles" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                     </div>
                         </div>
                     </div>

                     <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-warning" Text="Return" CausesValidation="false" PostBackUrl="~/GDLCAdmin/Security/Users.aspx" style="margin-bottom:0px"/>              
                    <asp:Button ID="btnSave" CssClass="btn btn-primary" runat="server" Text="Save" OnClick="btnSave_Click" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" />         
                </div>
                            </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>

        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function UpdateCompanyItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
