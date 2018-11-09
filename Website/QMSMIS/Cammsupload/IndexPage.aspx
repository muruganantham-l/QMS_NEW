<%@ Page Title="Index Page" Language="C#" AutoEventWireup="true" CodeBehind="IndexPage.aspx.cs" Inherits="Cammsupload.IndexPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="utf-8" />
    <title><%: Page.Title %> - MIS Application</title>
  
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
        

    <style type="text/css">
        html {
    background-color: #e2e2e2;
    margin: 0;
    padding: 0;
}
        body {
    background-color: #fff;
    border-top: solid 10px #000;
    color: #333;
    font-size: .85em;
    font-family: "Segoe UI", Verdana, Helvetica, Sans-Serif;
    margin: 0;
    padding: 0;
}
        .auto-style1 {
            text-align:left;
        }
         #menu_hr
     {
         background:#000880;
         width:100%;
         margin:auto auto auto auto;
     }
     #menu_hr ul
     {
         width:auto;
         padding:1px;
     }
     #menu_hr ul li
     {
         list-style-type:none;
         display:inline-block;
         padding-right:2em;
         padding-left:2em;
     }
     #menu_hr ul li a
     {
         background:#000880;
         text-decoration:none;
         color:#ffffff;        
         padding:10px 15px 10px 15px;
         overflow:auto;
     }
     #menu_hr ul li a:hover
     {
         background:#000880;
         padding:10px 15px 10px 15px;
         text-decoration:none;
         color:#ffffff; 
         overflow:auto;        
          
     }
    </style>
        
</head>
<body>
    <form id="form1" runat="server" style="border: medium solid #008080; height:auto">
         <hgroup class="title" >
                <h2 style="border-left: medium none #008080; border-right: medium none #008080; border-top: medium none #008080; border-bottom: medium solid #008080; font-family: Verdana, Geneva, Tahoma, sans-serif; font-weight: bold; font-size: large; font-style: oblique; font-variant: normal; text-transform: capitalize; color: #008080; text-decoration: blink; height: 70px; width: 100%;" class="auto-style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Quantum Medical Solutions
            <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblWelcomeMessage" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="Black" style="text-align: right"  />
            &nbsp;
            <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/Logout.aspx" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" style="font-weight: 700; text-align: right;">Logout</asp:LinkButton>
             </h2>
         </hgroup>
     <div style="border-style: none none solid none; border-width: medium; border-color: #008080; height: 496px; font-family: Calibri; font-size: medium; text-decoration: blink;" title="LoginDetail" class="auto-style1">
          <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Underline="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Index Page - Application" Width="100%" Height="25px" BackColor="#0099FF" style="text-align: center"></asp:Label>
     <br />
           <br />
            <br />     
             <asp:Table ID="Table1" runat="server" Height="322px" Width="796px" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" GridLines="Both" TabIndex="4" HorizontalAlign="Center">
              <asp:TableRow ID="TableRow1" runat="server" TableSection="TableHeader" BackColor="#6699FF" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle">
                  <asp:TableCell ID="TableCell1" runat="server">No</asp:TableCell>
                  <asp:TableCell ID="TableCell2" runat="server">Screen Name</asp:TableCell>
                  <asp:TableCell ID="TableCell3" runat="server">Details</asp:TableCell>
                  <asp:TableCell ID="TableCell4" runat="server" BorderColor="Black" BorderStyle="None">Link</asp:TableCell>
              </asp:TableRow>
              <asp:TableRow ID="TableRow2" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell5" runat="server">1</asp:TableCell>
                  <asp:TableCell ID="TableCell6" runat="server">Status Change Screen</asp:TableCell>
                  <asp:TableCell ID="TableCell7" runat="server">Update BE Status Changes in CAMMS</asp:TableCell>
                  <asp:TableCell ID="TableCell8" runat="server">
                     <asp:LinkButton runat="server" ID="Link1" PostBackUrl="~/StatusChange.aspx">Link</asp:LinkButton>                 
</asp:TableCell>
              </asp:TableRow>
              <asp:TableRow ID="TableRow3" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell9" runat="server">2</asp:TableCell>
                  <asp:TableCell ID="TableCell10" runat="server">Document Upload (1-1)</asp:TableCell>
                  <asp:TableCell ID="TableCell11" runat="server">Upload Document in CAMMS Based on Filename (1 File for 1 BE)</asp:TableCell>
                  <asp:TableCell ID="TableCell12" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton1" PostBackUrl="~/Docupload.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
              <asp:TableRow ID="TableRow4" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell13" runat="server">3</asp:TableCell>
                  <asp:TableCell ID="TableCell14" runat="server">Document Upload (1-Many)</asp:TableCell>
                  <asp:TableCell ID="TableCell15" runat="server">Upload Document in CAMMS Based on Filename (1 File for Many BE)</asp:TableCell>
                  <asp:TableCell ID="TableCell16" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton3" PostBackUrl="~/MultipleDocUpload.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>
               <asp:TableRow ID="TableRow5" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell17" runat="server">4</asp:TableCell>
                  <asp:TableCell ID="TableCell18" runat="server">Exclusion Process report</asp:TableCell>
                  <asp:TableCell ID="TableCell19" runat="server">Generate the Exclusion Process Report using the link</asp:TableCell>
                  <asp:TableCell ID="TableCell20" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton4" PostBackUrl="~/ExcluProcessReport.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>    
                  <asp:TableRow ID="TableRow6" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell21" runat="server">5</asp:TableCell>
                  <asp:TableCell ID="TableCell22" runat="server">Intranet User Creation</asp:TableCell>
                  <asp:TableCell ID="TableCell23" runat="server">Providing User Access for Intranet</asp:TableCell>
                  <asp:TableCell ID="TableCell24" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton5" PostBackUrl="~/UserCreation.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>   
                 <asp:TableRow ID="TableRow7" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell25" runat="server">6</asp:TableCell>
                  <asp:TableCell ID="TableCell26" runat="server">Update WO Details</asp:TableCell>
                  <asp:TableCell ID="TableCell27" runat="server">Updating the WO Details</asp:TableCell>
                  <asp:TableCell ID="TableCell28" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton6" PostBackUrl="~/UpdateWO.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>   
                 <asp:TableRow ID="TableRow8" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                  <asp:TableCell ID="TableCell29" runat="server">7</asp:TableCell>
                  <asp:TableCell ID="TableCell30" runat="server">Include the Holiday For KPI Calculation</asp:TableCell>
                  <asp:TableCell ID="TableCell31" runat="server">Include Holidays for KPI Calculation</asp:TableCell>
                  <asp:TableCell ID="TableCell32" runat="server">
                     <asp:LinkButton runat="server" ID="LinkButton7" PostBackUrl="~/KPIHoliday.aspx">Link</asp:LinkButton>
</asp:TableCell> 
              </asp:TableRow>        
          </asp:Table>
          <br />
            
     </div>
         <footer>
            <div class="float-left">
                <p>&copy; <%: DateTime.Now.Year %> - Mr.Aravinth Kannan</p>
            </div>
    </footer>
    </form>
</body>
</html>
