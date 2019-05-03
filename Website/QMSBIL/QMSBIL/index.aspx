<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="QMSBIL.index" %>

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
                  <asp:TableCell runat="server">Billing Report</asp:TableCell>
                  <asp:TableCell runat="server">Generate the Billing Report using the link</asp:TableCell>
                  <asp:TableCell runat="server">
                     <asp:LinkButton runat="server" ID="Link1" PostBackUrl="~/BillingReport.aspx">Link</asp:LinkButton>                 


</asp:TableCell>
              </asp:TableRow>

                <asp:TableRow ID="TableRow1"   runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell9" runat="server">2</asp:TableCell>
                  <asp:TableCell ID="TableCell10" runat="server">BVUpload</asp:TableCell>
                  <asp:TableCell ID="TableCell11" runat="server">Upload BV using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell12" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton4" PostBackUrl="~/BVUpload.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
              <asp:TableRow runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell5" runat="server">3</asp:TableCell>
                  <asp:TableCell ID="TableCell6" runat="server">Installment Batch Report</asp:TableCell>
                  <asp:TableCell ID="TableCell7" runat="server">Generate the Installment Batch Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell8" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton3" PostBackUrl="~/InstallmentBatchReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 

              </asp:TableRow>

               <asp:TableRow ID="TableRow6" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell29" runat="server">4</asp:TableCell>
                  <asp:TableCell ID="TableCell30" runat="server">NBE Installment Report</asp:TableCell>
                  <asp:TableCell ID="TableCell31" runat="server">Generate the NBE Installment Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell32" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton9" PostBackUrl="~/NBEInstallmentReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>

               <asp:TableRow ID="TableRow2" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell1" runat="server">5</asp:TableCell>
                  <asp:TableCell ID="TableCell2" runat="server">NBE BILL Entry</asp:TableCell>
                  <asp:TableCell ID="TableCell3" runat="server">Enter BILL For NBE Assets using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell4" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton1" PostBackUrl="http://intranet.qms.com.my:85/QMSMST/Login">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
 

              
 
              
              
              
              
          </asp:Table>
          <br />

    </div>
    </form>
</body>
</html>
