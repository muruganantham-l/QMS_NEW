<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InstallmentBatchReport.aspx.cs" Inherits="QMSMMD.InstallmentBatchReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <div title= "Installment Batch Report" style="height: 733px" >
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label13" runat="server" Font-Underline="true" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Installment Batch Report" Width="206px"></asp:Label>
                <br />
                <br />
               
        <asp:Label ID="Label2" runat="server" Text="Start Date:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" BackColor="White" Width="150" TextMode="Date"></asp:TextBox>
       
                <br />
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button1" runat="server" Height="33px" Text="Search" Width="134px" OnClick="Button1_Click" />  
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button2" runat="server" Height="33px" Text="Generate as Excel" Width="134px" OnClick="Button2_Click" />
                <br />
                <br />
                <asp:GridView ID="GridView1" runat="server" HeaderStyle-BackColor="#3AC0F2" BorderColor="#DEDFDE" ShowHeaderWhenEmpty="True" EmptyDataText = "No Records Found" AutoGenerateColumns="False" Width="2000px" PageSize="100" CellPadding="4" ForeColor="Black" AllowPaging="True"   GridLines="Vertical" BackColor="White" BorderStyle="None" BorderWidth="1px">
                    <AlternatingRowStyle BackColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="true" />
                    <Columns>
                        <asp:BoundField DataField="sno" HeaderText="No" SortExpression="sno" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="batch_no" HeaderText="Batch No" SortExpression="batch_no" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="clinic_category" HeaderText="Clinic Category" SortExpression="clinic_category" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="installment_start_date" HeaderText="Installment Start Date" SortExpression="installment_start_date" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="installment_end_date" HeaderText="Installment End Date" SortExpression="installment_end_date" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="tot_install_period" HeaderText="Total Installment Period (Month)" SortExpression="tot_install_period" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="install_complete" HeaderText="Installment Complete (Month)" SortExpression="install_complete" Visible="true" ItemStyle-Width="5%" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="install_pend" HeaderText="Installment Pendingv(Month)" SortExpression="install_pend"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        
                    </Columns>
                    <EmptyDataTemplate>           No Data Available!       </EmptyDataTemplate>
                    <FooterStyle BackColor="#CCCC99" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#F7F7DE" />
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#FBFBF2" />
                    <SortedAscendingHeaderStyle BackColor="#848384" />
                    <SortedDescendingCellStyle BackColor="#EAEAD3" />
                    <SortedDescendingHeaderStyle BackColor="#575357" />
                </asp:GridView>
    </div>
    </form>
</body>
</html>
