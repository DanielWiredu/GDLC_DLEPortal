<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vwDailyCostSheet.aspx.cs" Inherits="GDLC_DLEPortal.GDLCAdmin.Reports.Daily.General.vwDailyCostSheet" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="DailyCostSheetReport" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="false" OnLoad="DailyCostSheetReport_Load" BestFitPage="False" Width="100%" Height="750px" />
    </div>
    </form>
</body>
</html>
