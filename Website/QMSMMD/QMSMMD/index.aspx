<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="QMSMMD.index" %>

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
           
             </h2>
         </hgroup>
          <div style="border-style: none none solid none; border-width: medium; border-color: #008080; height: 700px; font-family: Calibri; font-size: medium; text-decoration: blink;" title="LoginDetail" class="auto-style1">
          <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Underline="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Index Page - Application" Width="100%" Height="25px" style="text-align: center"></asp:Label>
            
    <br />
    <br />
   <br />

          <asp:Table ID="Table1" runat="server" Height="322px" Width="796px" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" GridLines="Both" TabIndex="4" HorizontalAlign="Center">
              <asp:TableRow runat="server" TableSection="TableHeader" BackColor="#6699FF" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle">
                  <asp:TableCell runat="server">No</asp:TableCell>
                  <asp:TableCell runat="server">Report Name</asp:TableCell>
                  <asp:TableCell runat="server">Details</asp:TableCell>
                  <asp:TableCell runat="server" BorderColor="Black" BorderStyle="None" Width="100">Link</asp:TableCell>
              </asp:TableRow>
              <asp:TableRow runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell runat="server">1</asp:TableCell>
                  <asp:TableCell runat="server">CWO Pending Summary Report</asp:TableCell>
                  <asp:TableCell runat="server">Generate the CWO Pending Summary Report using the link</asp:TableCell>
                  <asp:TableCell runat="server">
                     <asp:LinkButton runat="server" ID="Link1" PostBackUrl="~/CWOPendingSummaryReport.aspx">Link</asp:LinkButton>                 


</asp:TableCell>
              </asp:TableRow>

                <asp:TableRow ID="TableRow1"   runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell9" runat="server">2</asp:TableCell>
                  <asp:TableCell ID="TableCell10" runat="server">GRN report</asp:TableCell>
                  <asp:TableCell ID="TableCell11" runat="server">Generate the GRN Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell12" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton4" PostBackUrl="~/GRNReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
              <asp:TableRow runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell5" runat="server">3</asp:TableCell>
                  <asp:TableCell ID="TableCell6" runat="server">PO Aging Report</asp:TableCell>
                  <asp:TableCell ID="TableCell7" runat="server">Generate the PO Aging Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell8" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton3" PostBackUrl="~/POAgingReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 

              </asp:TableRow>

               <asp:TableRow ID="TableRow6" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell29" runat="server">4</asp:TableCell>
                  <asp:TableCell ID="TableCell30" runat="server">PR Aging Report </asp:TableCell>
                  <asp:TableCell ID="TableCell31" runat="server">Generate the PR Aging Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell32" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton9" PostBackUrl="~/PRAgingReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>

               <asp:TableRow ID="TableRow4"  runat="server"   BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell21" runat="server">5</asp:TableCell>
                  <asp:TableCell ID="TableCell22" runat="server">Stock Analysis Report</asp:TableCell>
                  <asp:TableCell ID="TableCell23" runat="server">Generate the Stock Analysis Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell24" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton7" PostBackUrl="~/StockAnalysisReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>

                <asp:TableRow ID="TableRow14"   runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell61" runat="server">6</asp:TableCell>
                  <asp:TableCell ID="TableCell62" runat="server">Stock Movement Report</asp:TableCell>
                  <asp:TableCell ID="TableCell63" runat="server">Download the Stock Movement Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell64" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton17" PostBackUrl="~/StockMovementReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow> 

               <asp:TableRow ID="TableRow5" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell25" runat="server">7</asp:TableCell>
                  <asp:TableCell ID="TableCell26" runat="server">Stock Take Report </asp:TableCell>
                  <asp:TableCell ID="TableCell27" runat="server">Generate the Stock Take Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell28" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton8" PostBackUrl="~/StockTakereport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>

              <asp:TableRow runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell1" runat="server">8</asp:TableCell>
                  <asp:TableCell ID="TableCell2" runat="server">Transaction Report</asp:TableCell>
                  <asp:TableCell ID="TableCell3" runat="server">Generate the TransactionReport using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell4" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton1" PostBackUrl="~/TransactionReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
              
              
              
              
          </asp:Table>
          <br />

    </div>
    </form>
</body>
</html>
