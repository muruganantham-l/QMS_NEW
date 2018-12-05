﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IndexPage.aspx.cs" Inherits="AgingReport.IndexPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <hgroup class="title" >
                <h2 style="border-left: medium none #008080; border-right: medium none #008080; border-top: medium none #008080; border-bottom: medium solid #008080; font-family: Verdana, Geneva, Tahoma, sans-serif; font-weight: bold; font-size: large; font-style: oblique; font-variant: normal; text-transform: capitalize; color: #008080; text-decoration: blink; height: 70px; width: 100%;" class="auto-style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Quantum Medical Solutions
            <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblWelcomeMessage" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="Black" style="text-align: right"  />
            &nbsp;
            <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/Logout.aspx" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" style="font-weight: 700; text-align: right;">Logout</asp:LinkButton>
             </h2>
         </hgroup>
     <div style="border-style: none none solid none; border-width: medium; border-color: #008080; height: 496px; font-family: Calibri; font-size: medium; text-decoration: blink;" title="LoginDetail" class="auto-style1">
          <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Underline="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Index Page - Application" Width="100%" Height="25px" style="text-align: center"></asp:Label>
            
    <br />
    <br />
   <br />

          <asp:Table ID="Table1" runat="server" Height="322px" Width="796px" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" GridLines="Both" TabIndex="4" HorizontalAlign="Center">
              <asp:TableRow runat="server" TableSection="TableHeader" BackColor="#6699FF" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle">
                  <asp:TableCell runat="server">No</asp:TableCell>
                  <asp:TableCell runat="server">Report Name</asp:TableCell>
                  <asp:TableCell runat="server">Details</asp:TableCell>
                  <asp:TableCell runat="server" BorderColor="Black" BorderStyle="None">Link</asp:TableCell>
              </asp:TableRow>
              <asp:TableRow runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell runat="server">1</asp:TableCell>
                  <asp:TableCell runat="server">Breakdown Aging Report</asp:TableCell>
                  <asp:TableCell runat="server">Generate the Breakdown using the link</asp:TableCell>
                  <asp:TableCell runat="server">
                     <asp:LinkButton runat="server" ID="Link1" PostBackUrl="~/AgingReport.aspx">Link</asp:LinkButton>                 


</asp:TableCell>
              </asp:TableRow>
              <asp:TableRow runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell1" runat="server">2</asp:TableCell>
                  <asp:TableCell ID="TableCell2" runat="server">Dental Accessory Report</asp:TableCell>
                  <asp:TableCell ID="TableCell3" runat="server">Generate the Dental Accessory Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell4" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton1" PostBackUrl="~/AccessoryReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
              <asp:TableRow runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell5" runat="server">3</asp:TableCell>
                  <asp:TableCell ID="TableCell6" runat="server">KPI Report</asp:TableCell>
                  <asp:TableCell ID="TableCell7" runat="server">Generate the KPI Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell8" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton3" PostBackUrl="~/KPIReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
               <asp:TableRow ID="TableRow1" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell9" runat="server">4</asp:TableCell>
                  <asp:TableCell ID="TableCell10" runat="server">PPM Aging report</asp:TableCell>
                  <asp:TableCell ID="TableCell11" runat="server">Generate the PPM Aging Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell12" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton4" PostBackUrl="~/PPMAgingreport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
               <asp:TableRow ID="TableRow2" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell13" runat="server">5</asp:TableCell>
                  <asp:TableCell ID="TableCell14" runat="server">CWO Download Screen</asp:TableCell>
                  <asp:TableCell ID="TableCell15" runat="server">Download the CWO details using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell16" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton5" PostBackUrl="~/CWODownload.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
               <asp:TableRow ID="TableRow3" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell17" runat="server">6</asp:TableCell>
                  <asp:TableCell ID="TableCell18" runat="server">Scorecard Report</asp:TableCell>
                  <asp:TableCell ID="TableCell19" runat="server">Generate the Scorecard using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell20" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton6" PostBackUrl="~/ScorecardReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
               <asp:TableRow ID="TableRow4" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell21" runat="server">7</asp:TableCell>
                  <asp:TableCell ID="TableCell22" runat="server">Penalty Report</asp:TableCell>
                  <asp:TableCell ID="TableCell23" runat="server">Generate the Penalty Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell24" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton7" PostBackUrl="~/PenaltyReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
              <asp:TableRow ID="TableRow6" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell29" runat="server">8</asp:TableCell>
                  <asp:TableCell ID="TableCell30" runat="server">SM - KPI Report </asp:TableCell>
                  <asp:TableCell ID="TableCell31" runat="server">Generate the Schedule Maintanence KPI Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell32" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton9" PostBackUrl="~/SMKPIReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
              <asp:TableRow ID="TableRow5" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell25" runat="server">9</asp:TableCell>
                  <asp:TableCell ID="TableCell26" runat="server">UpTime Report </asp:TableCell>
                  <asp:TableCell ID="TableCell27" runat="server">Generate the UpTime Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell28" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton8" PostBackUrl="~/UpTimeReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
             <asp:TableRow ID="TableRow7" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell33" runat="server">10</asp:TableCell>
                  <asp:TableCell ID="TableCell34" runat="server">Performance Report </asp:TableCell>
                  <asp:TableCell ID="TableCell35" runat="server">Generate the Reports for Performance monitoring using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell36" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton10" PostBackUrl="~/PMCReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow> 
              <asp:TableRow ID="TableRow8" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell37" runat="server">11</asp:TableCell>
                  <asp:TableCell ID="TableCell38" runat="server">Upload PPM Document</asp:TableCell>
                  <asp:TableCell ID="TableCell39" runat="server">Upload PPM Ref.Documents using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell40" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton11" PostBackUrl="~/UploadDoc.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow> 
              <asp:TableRow ID="TableRow9" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell41" runat="server">12</asp:TableCell>
                  <asp:TableCell ID="TableCell42" runat="server">Search PPM Document</asp:TableCell>
                  <asp:TableCell ID="TableCell43" runat="server">Download the PPM Ref.Documents from Server using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell44" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton12" PostBackUrl="~/SearchDoc.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow> 
          </asp:Table>
          <br />

    </div>
    </form>
</body>
</html>
