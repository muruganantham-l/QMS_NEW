<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StatusPengeluarnFin09Entry.aspx.cs" Inherits="AgingReport.StatusPengeluarnFin09Entry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
             <asp:Label ID="Label30" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Enter Status Pengeluaran Fin09 Data" Width="300px" style="text-align: center"></asp:Label>               
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
            &nbsp;
            &nbsp;&nbsp;&nbsp;
              <table style="margin-left:auto; align="center"  margin-right:auto">
                    
                    <tr>
                     <td>

                          <asp:Label ID="Label4" runat="server" Text="State" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                         <asp:DropDownList ID="DropDownState" OnSelectedIndexChanged="DropDownYear_SelectedIndexChanged" runat="server" Visible="true" Width="200" Height="25" BackColor="White" DataTextField="ast_lvl_ast_lvl" DataValueField="RowID" AutoPostBack="True" ></asp:DropDownList>
                     </td>
                     
                    

                 </tr>
                  <tr>
                       <td>
                           <asp:Label ID="Label5" runat="server" Text="Year" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:DropDownList ID="DropDownYear" runat="server" Visible="true" OnSelectedIndexChanged="DropDownYear_SelectedIndexChanged" Width="200" Height="25" BackColor="White" DataTextField="year" DataValueField="year" AutoPostBack="True" ></asp:DropDownList>
                     </td>
                  </tr>
                   <tr>
                       <td>
                           <asp:Label ID="Label2" runat="server" Text="Quarter" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:DropDownList ID="DropDownquarter" runat="server" Visible="true" OnSelectedIndexChanged="DropDownquarter_SelectedIndexChanged" Width="200" Height="25" BackColor="White" DataTextField="quarter_txt" DataValueField="quarter_id" AutoPostBack="True" ></asp:DropDownList>
                     </td>
                  </tr>

                  
<tr>
      
         <td align="left"> <asp:Label ID="Label3" runat="server" Text="Clinic Category  " Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label> </td>
      <td>
 
          <asp:DropDownList ID="DropDownCliniccat"  ToolTip="Type here to search" CssClass="form-control js-example-placeholder-single" runat="server" AutoPostBack="true" BackColor="White" OnSelectedIndexChanged="DropDownCliniccat_SelectedIndexChanged" DataTextField="Cliniccat" DataValueField="RowID" Width="200" Height="25"></asp:DropDownList>
      </td>
      
    
     
       
  
    </tr>
                    <tr>
                     <td>

                          <asp:Label ID="Label1" runat="server" Text="Response Time (09-A)" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                        <asp:TextBox ID="response_time_txt" runat="server" BackColor="White" Width="195"   ></asp:TextBox>
                     </td>
                     
                     

                 </tr>
                  <tr>

                      <td>
                           <asp:Label ID="lab" runat="server" Text="Repair Time (09-B)" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="repair_time_txt" runat="server" BackColor="White" Width="195"   ></asp:TextBox>
                     </td>
                  </tr>
                    <tr>
                     <td>

                          <asp:Label ID="Label6" runat="server" Text="Schedule Maintenance (09-D)" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                        <asp:TextBox ID="schedule_maintenance_txt" runat="server" BackColor="White" Width="195"   ></asp:TextBox>
                     </td>
                    
                   

                 </tr>
                  <tr>
                        <td>
                           <asp:Label ID="Label9" runat="server" Text="Uptime Guarantees (09-C)" Font-Names="Calibri"  Font-Bold="false" Width="190" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="uptime_guarantees_txt" runat="server" BackColor="White" Width="195"   ></asp:TextBox>
                     </td>
                  </tr>
                   <tr>
                     <td></td>
                     <td><asp:Button ID="save_btn" runat="server" Height="33px" Text="Save" Width="134px"  onclick="save_btn_Click"  /> </td>
                     <td></td>
                      
                 </tr>
                    <tr>
                        <td></td>
                     <td align="left" colspan="5"> <asp:Label ID="Label29" runat="server"  Font-Names="Calibri"  Font-Bold="True" Width="875px" Height="25px"></asp:Label> 

                     </td>
                     
                 </tr>
                  </table>

        </div>
    </form>
</body>
</html>
