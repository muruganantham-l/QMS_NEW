<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WODashBoard.aspx.cs" Inherits="AgingReport.WODashBoard" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard - WO Pending</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="height: auto">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <rsweb:ReportViewer ID="MyReportViewer" runat="server" Width="1800" Height="1000">
        </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
