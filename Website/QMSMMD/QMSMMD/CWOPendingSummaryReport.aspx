<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CWOPendingSummaryReport.aspx.cs" Inherits="QMSMMD.CWOPendingSummaryReport" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         
        <marquee  >Please click numbers to get details of Work orders , PO and PR Details in the report</marquee>
    <div style="height: auto;">
        <asp:Button ID="report_btn" runat="server" OnClick="report_btn_Click" Text="View Report" />
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <rsweb:ReportViewer ID="MyReportViewer" runat="server" PageCountMode="Actual" Width="2000" Height="1000" ShowRefreshButton="False" ShowFindControls="False" ShowPrintButton="true" ShowParameterPrompts="false" ShowPromptAreaButton="false" >
        </rsweb:ReportViewer>
    </div>
         
    </form>
</body>
</html>
