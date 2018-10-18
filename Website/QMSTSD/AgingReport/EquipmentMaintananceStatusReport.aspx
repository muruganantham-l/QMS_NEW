<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentMaintananceStatusReport.aspx.cs" Inherits="AgingReport.EquipmentMaintananceStatusReport" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
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
            <div title="Equipment Maintenance Status Report"  style="height: 255px">
       

               <table style="margin-left:auto; margin-right:auto">

                   <tr>
                       <td align="center" colspan="6">
                             <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Equipment Maintenance Status Report" Width="302px" style="text-align: center"></asp:Label>
                      

                   </tr>
                   <tr>
                       <td>
                           
                       </td>
                   </tr>
                   <tr><td></td>

                   </tr>
                   <tr>

                       <td></td>
                   </tr>
                   <tr><td></td>

                   </tr>
    <tr>
        
      <td align="left"> <asp:Label ID="Label3" runat="server" Text="Batch : " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label></td>
     <td><asp:DropDownList ID="DropDownbatch" OnSelectedIndexChanged="DropDownbatch_SelectedIndexChanged" runat="server" Visible="true" Width="200" Height="25" BackColor="White" DataTextField="display" DataValueField="ast_det_varchar21" AutoPostBack="True" ></asp:DropDownList></td>
    </tr>
    <tr>
      <td align="left"> <asp:Label ID="Label1" runat="server" Text="BE Category: " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label> </td>
      <td><asp:DropDownList ID="DropDownBECategory"  runat="server" Visible="true" Width="200" Height="25" BackColor="White" DataTextField="ast_mst_asset_longdesc" DataValueField="ast_mst_asset_longdesc" AutoPostBack="True" OnSelectedIndexChanged="DropDownBECategory_SelectedIndexChanged" ></asp:DropDownList></td>
    </tr>
 <tr>
      <td align="left"> <asp:Label ID="Label2" runat="server" Text="Supplier Name: " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label> </td>
      <td><asp:DropDownList ID="DropDownSuppliername" runat="server" Visible="true" Width="200" Height="25" BackColor="White" DataTextField="ast_det_varchar16" DataValueField="ast_det_varchar16" AutoPostBack="True" OnSelectedIndexChanged="DropDownSuppliername_SelectedIndexChanged1"  ></asp:DropDownList></td>
    </tr>
                   <tr>
      <td align="left">
         
          <asp:Label ID="Label10" runat="server" Text="Manufacturer: " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label>
      </td>
      <td>
           <asp:DropDownList ID="DropDownManufacture" OnSelectedIndexChanged="DropDownManufacture_SelectedIndexChanged" runat="server" Visible="true" Width="200" Height="25" BackColor="White" DataTextField="ast_det_mfg_cd" DataValueField="ast_det_mfg_cd" AutoPostBack="True"    ></asp:DropDownList>
          

      </td>
                       <td></td>
    <td></td> 
                       <td align="left"> 
                            <asp:Label ID="Label7" runat="server" Text="Model: " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label> 

                       </td>
      <td>
           
            <asp:DropDownList ID="DropDownmodel" runat="server" Visible="true" Width="200" Height="25" BackColor="White" DataTextField="ast_det_modelno" DataValueField="ast_det_modelno" AutoPostBack="True" OnSelectedIndexChanged="DropDownmodel_SelectedIndexChanged"  ></asp:DropDownList>
      </td>
    </tr>

<tr>
      <td align="left"> <asp:Label ID="Label5" runat="server" Text="Warrenty Start: " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label> </td>
      <td>
          <%--<asp:TextBox ID="warenty_start_txt" runat="server" BackColor="White" Width="195" TextMode="Date"></asp:TextBox>--%>
          <asp:TextBox ID="warenty_start_txt" runat="server" BackColor="White" Width="195" Enabled="False"  ></asp:TextBox>

      </td>
    <td></td>
    <td></td>
     <td align="left"> <asp:Label ID="Label6" runat="server" Text="Warrenty End: " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label> </td>
      <td>
          <%--<asp:TextBox ID="warenty_end_txt" runat="server" BackColor="White" Width="195" TextMode="Date"></asp:TextBox>--%>
           <asp:TextBox ID="warenty_end_txt" runat="server" BackColor="White" Width="195" Enabled="False"  ></asp:TextBox>


      </td>
    </tr>
                   <tr>
                       <td>
                           <asp:Label ID="lblError" runat="server"  ForeColor="Red"   Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label> 
                       </td>
                 </tr>
    <tr>
       <td align="center" colspan="6">   <asp:Button ID="generate_btn" runat="server" Height="33px" Text="Generate Report" Width="134px"  OnClick="generate_btn_Click"  /> </td>
      <td align="center" colspan="6">   <asp:Button ID="print_btn" runat="server" Height="33px" Text="View Report" Width="134px"  OnClick="print_btn_Click"  /> </td>
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
