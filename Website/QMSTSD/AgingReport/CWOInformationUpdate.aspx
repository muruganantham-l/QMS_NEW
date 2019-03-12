<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CWOInformationUpdate.aspx.cs" Inherits="AgingReport.CWOInformationUpdate" %>

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
        <div title="CWO Information Update"  style="height: 255px">

             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label30" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="CWO Information Update" Width="265px" style="text-align: center"></asp:Label>               
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
            &nbsp;
            &nbsp;&nbsp;&nbsp;
             <table style="margin-left:auto; margin-right:auto">


                 <tr  >
                        <td  > <asp:Label ID="Label3" runat="server" Text="CWO Number  " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label></td>
     <td  >

         <asp:Panel runat="server" DefaultButton="wo_num_enter_key">
   <asp:TextBox ID="wo_number_txt" runat="server" BackColor="White" Width="195" Enabled="true" placeholder="Insert here" ></asp:TextBox>

    <asp:Button ID="wo_num_enter_key" runat="server" OnClick="wo_num_enter_key_Click" Style="display: none" />
</asp:Panel>
          
     </td> 

                 </tr>
                 <tr>
                     <td></td>
                     <td></td>
                     <td   >
                         <asp:Label ID="Label1" runat="server" ForeColor="#FF3399" Text="CWO Verification Information" Font-Names="Calibri"  Font-Bold="True" Width="200px" Height="25px"></asp:Label>

                     </td>
                     <td></td>
                     <td></td>
                 </tr>

                 <tr>
                     <td>

                          <asp:Label ID="Label4" runat="server" Text="State" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="state" runat="server" BackColor="White" Width="195" Enabled="False"  ></asp:TextBox>
                     </td>
                     <td>
                          <asp:Label ID="Label2" runat="server"  Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>

                     </td>
                     <td>
                           <asp:Label ID="Label5" runat="server" Text="Clinic Name" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="clinicname" runat="server" BackColor="White" Width="195" Enabled="False"  ></asp:TextBox>
                     </td>

                 </tr>

                   <tr>
                     <td>

                          <asp:Label ID="Label6" runat="server" Text="District" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="district" runat="server" BackColor="White" Width="195" Enabled="False"  ></asp:TextBox>
                     </td>
                     <td>
                          <asp:Label ID="Label7" runat="server"  Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label>

                     </td>
                     <td>
                           <asp:Label ID="Label9" runat="server" Text="Clinic Code" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="cliniccode" runat="server" BackColor="White" Width="195" Enabled="False"  ></asp:TextBox>
                     </td>

                 </tr>

                   <tr>
                     <td>

                          <asp:Label ID="Label10" runat="server" Text="Circle" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="circle" runat="server" BackColor="White" Width="195" Enabled="False"  ></asp:TextBox>
                     </td>
                     <td>
                          <asp:Label ID="Label11" runat="server"  Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label>

                     </td>
                     <td>
                           <asp:Label ID="Label12" runat="server" Text="Clinic Category" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="clinic_category" runat="server" BackColor="White" Width="195" Enabled="False"  ></asp:TextBox>
                     </td>

                 </tr>

                    <tr>
                     <td>

                          <asp:Label ID="Label13" runat="server" Text="BE category" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="be_category" runat="server" BackColor="White" Width="195" Enabled="False"  ></asp:TextBox>
                     </td>
                     <td>
                          <asp:Label ID="Label14" runat="server"  Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label>

                     </td>
                     <td>
                           <asp:Label ID="Label15" runat="server" Text="WO Date" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="wo_date" runat="server" BackColor="White" Width="195" Enabled="False"  ></asp:TextBox>
                     </td>

                 </tr>

                  <tr>
                     <td>

                          <asp:Label ID="Label16" runat="server" Text="BE Number" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="be_number" runat="server" BackColor="White" Width="195" Enabled="False"  ></asp:TextBox>
                     </td>
                     <td>
                          <asp:Label ID="Label17" runat="server"  Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label>

                     </td>
                     <td>
                           <asp:Label ID="Label18" runat="server" Text="WO Status" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="wo_status" runat="server" BackColor="White" Width="195" Enabled="False"  ></asp:TextBox>
                     </td>

                 </tr>

                   <tr>
                       <td></td>
                     <td></td>
                     <td>
                         <asp:Label ID="Label19" runat="server" ForeColor="#ff3399" Text="CWO Editable Changes" Font-Names="Calibri"  Font-Bold="true" Width="200" Height="25"> </asp:Label>

                     </td>
                       <td></td>
                     <td></td>
                 </tr>
                   <tr>
                     <td>

                          <asp:Label ID="Label20" runat="server" Text="Acknowledge Date && Time" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="ack_date" runat="server" BackColor="White" Width="195" Enabled="true" TextMode="DateTimeLocal" ></asp:TextBox>
                     </td>
                     <td>
                          <asp:Label ID="Label21" runat="server"  Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label>

                     </td>
                     <td>
                           <asp:Label ID="Label22" runat="server" Text="Response Date && Time" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="response_date" runat="server" BackColor="White" Width="195" Enabled="true" TextMode="DateTimeLocal" ></asp:TextBox>
                     </td>

                 </tr>

                  <tr>
                     <td>

                          <asp:Label ID="Label23" runat="server" Text="Completion Date && Time" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="cmpl_date" runat="server" BackColor="White" Width="195" Enabled="true"  TextMode="DateTimeLocal" ></asp:TextBox>
                     </td>
                     <td>
                          <asp:Label ID="Label24" runat="server"  Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>

                     </td>
                     <td>
                           <asp:Label ID="Label25" runat="server" Text="Service Report" Font-Names="Calibri"  Font-Bold="false" Width="150" Height="25"> </asp:Label>
                     </td>
                     <td>
                          <asp:TextBox ID="BELocation" runat="server" BackColor="White" Width="195" Enabled="true"  ></asp:TextBox>
                     </td>

                 </tr>

               

                 <tr>
                     <td></td>
                     <td><asp:Button ID="save_btn" runat="server" Height="33px" Text="Save" Width="134px"  onclick="save_btn_Click"  /> </td>
                     <td></td>
                     <td> </td>
                     <td><asp:Button ID="reset_btn" runat="server" Height="33px" Text="Reset" Width="134px"   onclick="reset_btn_Click"  /></td>
                 </tr>

                 <tr>
                     <td align="left" colspan="5"> <asp:Label ID="Label29" runat="server"  Font-Names="Calibri"  Font-Bold="True" Width="875px" Height="25px"></asp:Label> 

                     </td>
                      
                 </tr>

             </table>
        </div>
    </form>
</body>
</html>
