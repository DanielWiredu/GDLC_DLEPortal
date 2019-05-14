<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vwWeeklyCostSheet.aspx.cs" Inherits="GDLC_DLEPortal.Reports.Weekly.General.vwWeeklyCostSheet" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="WeeklyCostSheetReport" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="false" BestFitPage="False" Width="100%" Height="750px"  OnLoad="WeeklyCostSheetReport_Load" />
    </div>
    </form>
</body>
</html>
