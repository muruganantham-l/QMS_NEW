<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StatusPengeluarnFin09Print.aspx.cs" Inherits="AgingReport.StatusPengeluarnFin09Print" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" />
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".js-example-placeholder-single").select2({
                placeholder: "Select",
                allowClear: true
            });
        });
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <hgroup class="title" >
                <h2 style="border-left: medium none #008080; border-right: medium none #008080; border-top: medium none #008080; border-bottom: medium solid #008080; font-family: Verdana, Geneva, Tahoma, sans-serif; font-weight: bold; font-size: large; font-style: oblique; font-variant: normal; text-transform: capitalize; color: #008080; text-decoration: blink; height: 70px; width: 100%;" class="auto-style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Quantum Medical Solutions
            <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="Black" style="text-align: right"  />
            &nbsp;
            <asp:LinkButton ID="LinkButton4" runat="server" PostBackUrl="~/IndexPage.aspx" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" style="font-weight: 700; text-align: right;">Index Page</asp:LinkButton>
              &nbsp;<asp:LinkButton ID="LinkButton3" runat="server" PostBackUrl="~/Logout.aspx" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" style="font-weight: 700; text-align: right;">Logout</asp:LinkButton>
             </h2>
         </hgroup>
        <div style="height: 255px">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Label ID="Label30" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Print Fin09 Reports" Width="300px" style="text-align: center"></asp:Label>               
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
            &nbsp;
            &nbsp;&nbsp;&nbsp;
               <table style="margin-left:auto; align="center"  margin-right:auto">
                    
                    <tr>
                     <td>

                          <asp:Label ID="Label4" runat="server" Text="Year From" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                      <td> 
                            <asp:DropDownList ID="dropdownyearfrom" runat="server" Visible="true"  Width="200" Height="25" BackColor="White" DataTextField="year" DataValueField="year" AutoPostBack="True" ></asp:DropDownList>
                      </td>
                         <td>

                          <asp:Label ID="Label2" runat="server"   Font-Names="Calibri"  Font-Bold="false" Width="100" Height="25"> </asp:Label>
                     </td>

                         <td>

                          <asp:Label ID="Label1" runat="server" Text="Year To" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                      <td> 
                            <asp:DropDownList ID="dropdownyearto" runat="server" Visible="true"  Width="200" Height="25" BackColor="White" DataTextField="year" DataValueField="year" AutoPostBack="True" ></asp:DropDownList>
                      </td>
                          
                             <td  > 
                            <asp:Label ID="Label11" runat="server" Text="Report Name: " Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label> 

                       </td>
      <td>
           
            <asp:DropDownList ID="DropDownReportname" ToolTip="Type here to search" CssClass="form-control js-example-placeholder-single"  runat="server" Visible="true" Width="200" Height="25" BackColor="White" DataTextField="ast_det_modelno" DataValueField="ast_det_modelno" AutoPostBack="True"   ></asp:DropDownList>
      </td>
                        </tr>
                                        <tr>
                     <td></td>
                       <td></td>
                     <td><asp:Button ID="print" runat="server" Height="33px" Text="Print" Width="134px"  onclick="print_Click"  /> </td>
                     <td></td>
                       <td></td>
                      
                 </tr>
                     <tr>
                       <td>
                           <asp:Label ID="lblError" runat="server"  ForeColor="Red"   Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label> 
                       </td>
                 </tr>
                  </table>

        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <table style="margin-left:auto; margin-right:auto">
              <tr>
 <td align="center" colspan="6">   

  <rsweb:ReportViewer ID="MyReportViewer" runat="server" Width="700" Height="1000" PageCountMode="Actual" ShowRefreshButton="False" ShowFindControls="False" ShowPrintButton="true" ShowParameterPrompts="false" ShowPromptAreaButton="false">
            </rsweb:ReportViewer> 
 </td>
              </tr>
            </table>
    </form>
</body>
</html>
