<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="GDLC_DLEPortal.Dashboard" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Dashboard (Current Month)</h5>
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
                        <div class="row" >
           <%-- <div class="col-lg-3">
                <div class="widget style1 blue-bg">
                        <div class="row">
                            <div class="col-xs-4 text-center">
                                <i class="fa fa-trophy fa-5x"></i>
                            </div>
                            <div class="col-xs-8 text-right">
                                <span> Today income </span>
                                <h2 class="font-bold">$ 4,232</h2>
                            </div>
                        </div>
                </div>
            </div>--%>
            <div class="col-lg-3">
                <div class="widget style1 navy-bg">
                    <div class="row">
                        <%--<div class="col-xs-4">
                            <i class="fa fa-cloud fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span> Daily Cost Sheets - All </span>
                            <a style="color:white" href="#">
                                    <h2 class="font-bold" runat="server" id="lblDailyAll"> 642</h2>
                                    </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="widget style1 lazur-bg">
                    <div class="row">
                        <%--<div class="col-xs-4">
                            <i class="fa fa-envelope-o fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span> Daily Cost Sheets - Approved </span>
                            <a style="color:white" href="#">
                                <h2 class="font-bold" runat="server" id="lblDailyApproved">5 </h2>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
                          
            <div class="col-lg-3">
                <div class="widget style1 yellow-bg">
                    <div class="row">
                       <%-- <div class="col-xs-4">
                            <i class="fa fa-music fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span>Daily Cost Sheets - Unapproved</span>
                            <a style="color:white" href="#">
                                <h2 class="font-bold" runat="server" id="lblDailyUnapproved"> 23 </h2>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="widget style1 red-bg">
                    <div class="row">
                       <%-- <div class="col-xs-4">
                            <i class="fa fa-music fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span> System Users </span>
                            <a style="color:white" href="#">
                                <h2 class="font-bold" runat="server" id="lblUsers">12  </h2>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

                        <div class="row">
                    <div class="col-md-12">
                   <telerik:RadHtmlChart runat="server" Width="100%" Height="500px" ID="chtDailyCostSheetByVessel" Skin="Silk" DataSourceID="dailyByVesselSource">
            <PlotArea>
                <Series>
                    <telerik:ColumnSeries Name="Cost Sheets" DataFieldY="COSTSHEETS">
                        <TooltipsAppearance Color="White"  />
                    </telerik:ColumnSeries>
                </Series>
                <XAxis DataLabelsField="VESSELNAME" Visible="true">
                    <LabelsAppearance RotationAngle="60"> </LabelsAppearance>
                    <TitleAppearance Text="Category" Visible="false"></TitleAppearance>
                </XAxis>
                <YAxis >
                    <LabelsAppearance></LabelsAppearance>
                    <TitleAppearance Text="Cost Sheets" Visible="false"> </TitleAppearance>
                </YAxis>
            </PlotArea>
            <Legend >
                <Appearance Visible="false" > </Appearance>
            </Legend>
            <ChartTitle Text="Daily Cost By Vessel">
            </ChartTitle>
        </telerik:RadHtmlChart>

         <asp:SqlDataSource ID="dailyByVesselSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="spGetDLEDailyByVesselDash" SelectCommandType="StoredProcedure">
             <SelectParameters>
                 <asp:CookieParameter Name="accountType" CookieName="accounttype" Type="String" />
                 <asp:CookieParameter Name="DLEcodeCompanyID" CookieName="dlecompanyId" Type="Int32" />
              </SelectParameters>
         </asp:SqlDataSource>
                    
                </div>

                    <%--<telerik:RadButton ID="btnExport" Text="Export to PDF" runat="server" OnClientClicked="exportRadHtmlChart" UseSubmitBehavior="false" AutoPostBack="false"></telerik:RadButton>--%>
                    <%--<telerik:RadClientExportManager ID="RadClientExportManager1" runat="server"></telerik:RadClientExportManager>--%>

                    

                    <%--<div class="col-md-6">
                                 <telerik:RadHtmlChart ID="chtCallByCallType" runat="server" Width="100%" Height="500px" DataSourceID="callTypeSource">
                                    <ChartTitle Text="Calls by Call Type">
                                        <Appearance Visible="True" >
                                        </Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance Visible="True" Position="Bottom">
                                        </Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Series>
                                            <telerik:PieSeries Name="CALLTYPE" StartAngle="90" DataFieldY="TOTALCALLS" NameField="CALLTYPE" >
                                                <LabelsAppearance DataField="CALLTYPE" Position="OutsideEnd" Visible="true"></LabelsAppearance>
                                            </telerik:PieSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
             
                                <asp:SqlDataSource ID="callTypeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CALLTYPE, count(CallId) as TOTALCALLS from tblCallLog where CAST(calldate as date) = CAST(getdate() as DATE) group by CALLTYPE"></asp:SqlDataSource>
                            </div>--%>
                </div>
                    </div>
                </div>
        </div>
</asp:Content>
