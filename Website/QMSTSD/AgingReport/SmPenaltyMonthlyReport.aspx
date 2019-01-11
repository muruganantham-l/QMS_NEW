<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmPenaltyMonthlyReport.aspx.cs" Inherits="AgingReport.SmPenaltyMonthlyReport" %>
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
        <div>

            
               <table style="margin-left:auto; margin-right:auto">

                   <tr>
                       <td align="center" colspan="6">
                             <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="SM Penalty Monthly Report" Width="302px" style="text-align: center"></asp:Label>
                      

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
      <td align="left">
         
          <asp:Label ID="Label10" runat="server" Text="State: " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label>
      </td>
      <td>
         <asp:DropDownList ID="DropDownState" ToolTip="Type here to search" CssClass="form-control js-example-placeholder-single"  runat="server" Visible="true" Width="200" Height="25" BackColor="White" DataTextField="ast_lvl_ast_lvl" DataValueField="RowID" AutoPostBack="True" OnSelectedIndexChanged="DropDownState_SelectedIndexChanged"></asp:DropDownList>
          

      </td>
         <td>
            <asp:Label runat="server" Width="100"></asp:Label>
        </td>
      <td align="left"> <asp:Label ID="Label2" runat="server" Text="District : " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label> </td>
      <td>
            <asp:DropDownList ID="DropDownDistrict"  ToolTip="Type here to search" CssClass="form-control js-example-placeholder-single" runat="server" Visible="true" AutoPostBack="true" BackColor="White" DataTextField="ast_loc_ast_loc" DataValueField="RowID" Width="200" Height="25" OnSelectedIndexChanged="DropDownDistrict_SelectedIndexChanged"></asp:DropDownList>

      </td>
    
    
  
    </tr>
   
    

                  
   

<tr>
      
         <td align="left"> <asp:Label ID="Label1" runat="server" Text="Clinic Category : " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label> </td>
      <td>
 
          <asp:DropDownList ID="DropDownCliniccat"  ToolTip="Type here to search" CssClass="form-control js-example-placeholder-single" runat="server" AutoPostBack="true" BackColor="White" OnSelectedIndexChanged="DropDownCliniccat_SelectedIndexChanged" DataTextField="Cliniccat" DataValueField="RowID" Width="200" Height="25"></asp:DropDownList>
      </td>
     <td>
            <asp:Label runat="server" Width="100"></asp:Label>
        </td>
    
       <td align="left"> <asp:Label ID="Label3" runat="server" Text="Clinic Name : " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label></td>
     <td><asp:DropDownList ID="DropDownclinicname" ToolTip="Type here to search" CssClass="form-control js-example-placeholder-single" OnSelectedIndexChanged="DropDownclinicname_SelectedIndexChanged" runat="server" Visible="true" Width="200" Height="25" BackColor="White" DataTextField="clinic_name" DataValueField="clinic_code" AutoPostBack="True" ></asp:DropDownList></td>
      
       
  
    </tr>
            <tr>
          <td align="left"> <asp:Label ID="Label6" runat="server" Text="Clinic Code : " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label> </td>
      <td>
 
          <asp:TextBox Enabled="false" ID="clinic_code_txt" runat="server" Width="200" Height="25" BackColor="White"></asp:TextBox>
      </td>
     <td>
            <asp:Label runat="server" Width="100"></asp:Label>
        </td>
        <td align="left"> <asp:Label ID="Label5" runat="server" Text="Report Year : " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label> </td>
      <td>
           <asp:DropDownList ID="DropDownListReportYear" ToolTip="Type here to search" CssClass="form-control js-example-placeholder-single"   runat="server" Visible="true" Width="200" Height="25" BackColor="White" DataTextField="year" DataValueField="year" AutoPostBack="True" ></asp:DropDownList></td>
      

      </td>
    </tr>  
                   
                     <tr>
          <td align="left"> <asp:Label ID="Label7" runat="server" Text="Report Month : " Font-Names="Calibri"  Font-Bold="true" Width="150" Height="25"> </asp:Label> </td>
      <td>
 
           <asp:DropDownList ID="DropDownListReportMonth" ToolTip="Type here to search" CssClass="form-control js-example-placeholder-single"   runat="server" Visible="true" Width="200" Height="25" BackColor="White" DataTextField="MonthName" DataValueField="MonthNumber" AutoPostBack="True" ></asp:DropDownList></td>
      

      </td>
     <td>
            <asp:Label runat="server" Width="100"></asp:Label>
        </td>
       
    </tr>      


    <tr>
   
      <td align="center" colspan="6">   <asp:Button ID="print_btn" runat="server" Height="33px" Text="View Report" Width="134px"  OnClick="print_btn_Click"  /> </td>
         <td>
            <asp:Label runat="server" Width="100"></asp:Label>
        </td>
        
      <td align="center" colspan="6">   <asp:Button ID="print_excel" runat="server" Height="33px" Text="Generate Excel" Width="134px"  OnClick="print_excel_Click"  /> </td>
    </tr>
  </table>
        </div>
         <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <table style="margin-left:auto; margin-right:auto">
              <tr>
 <td align="center" colspan="6">   

  <rsweb:ReportViewer ID="MyReportViewer" runat="server" Width="1000" Height="1000" PageCountMode="Actual" ShowRefreshButton="False" ShowFindControls="False" ShowPrintButton="true" ShowParameterPrompts="false" ShowPromptAreaButton="false">
            </rsweb:ReportViewer> 
 </td>
              </tr>
            </table>
        <div>
           
                <asp:GridView ID="GridView1" runat="server" HeaderStyle-BackColor="#3AC0F2" BorderColor="SeaGreen" ShowHeaderWhenEmpty="true" EmptyDataText = "No Records Found" AutoGenerateColumns="False" Width="1016px" PageSize="100" CellPadding="4" ForeColor="#333333" AllowPaging="true" ShowHeader="true" Visible="true" GridLines="Both">
                    <AlternatingRowStyle BackColor="White" />
                    <HeaderStyle BackColor="SeaGreen" Font-Bold="true" Font-Italic="true" />
                    <Columns>
                        <asp:BoundField DataField="month_year" HeaderText="Report Month Year" Visible="true"/>
                       
                        <asp:BoundField DataField="state" HeaderText="State" SortExpression="state" Visible="true"/>
                        <asp:BoundField DataField="district" HeaderText="District" SortExpression="District" Visible="true"/>
                         <asp:BoundField DataField="clinic_code" HeaderText="clinic code" SortExpression="clinic_code" Visible="true"/>
                         <asp:BoundField DataField="clinic_name" HeaderText="Clinic Name"   Visible="true"/>
                        <asp:BoundField DataField="clinic_category" HeaderText="Clinic Category"   Visible="true"/>
                         
                        <asp:BoundField DataField="be_number" HeaderText="Be Number" SortExpression="Model" Visible="true"/>
                        <asp:BoundField DataField="be_category" HeaderText="Be Category" SortExpression="Problem Reported" Visible="true"/>
                        <asp:BoundField DataField="be_group" HeaderText="Be group" SortExpression="Action Taken" Visible="true"/>
                        <asp:BoundField DataField="equipment_cost" HeaderText="equipment cost" SortExpression="MR Number" Visible="true"/>
                        <asp:BoundField DataField="sm_type" HeaderText="sm type" SortExpression="MR Date" Visible="true"/>
                        <asp:BoundField DataField="wo_number" HeaderText="wo number" SortExpression="PR Number" Visible="true"/>
                        <asp:BoundField DataField="wo_start_datetime" HeaderText="wo start datetime" SortExpression="PR Date" Visible="true"/>
                        <asp:BoundField DataField="wo_cmpl_datetime" HeaderText="wo cmpl datetime" SortExpression="PR Status" Visible="true"/>
                        <asp:BoundField DataField="sm_penalty_rate_month" HeaderText="sm penalty rate month" SortExpression="Item Required" Visible="true"/>
                        <asp:BoundField DataField="vcm_proposed_amount" HeaderText="vcm proposed amount" SortExpression="PO Number" Visible="true"/>
                        <asp:BoundField DataField="disputed" HeaderText="disputed" SortExpression="PO Date" Visible="true"/>
                        <asp:BoundField DataField="vcm_agreed_amount" HeaderText="vcm agreed amount" SortExpression="State" Visible="true"/>
                        <asp:BoundField DataField="status" HeaderText="status" SortExpression="District" Visible="true"/>
                        <asp:BoundField DataField="remarks" HeaderText="remarks" SortExpression="Clinic Name" Visible="true"/>
                       
                         
                    </Columns>
                    <EmptyDataTemplate>           No Data Available!       </EmptyDataTemplate>
                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" />
                    <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
           </div>
    </form>

   
</body>
</html>
