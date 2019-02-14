<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StockTakereport.aspx.cs" Inherits="QMSMMD.StockTakereport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 751px;
            margin-right: 0px;
        }
    </style>
</head>
<body>
    <form id="form1" title="Stock Take Report" runat="server">
    <div title= "Stock Take Report" style="height: 733px" >
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label13" runat="server" Font-Underline="true" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Stock Take Report" Width="206px"></asp:Label>
                <br />
                <br />
            <asp:Label ID="Label3" runat="server" Text="State : " Font-Names="Calibri" Font-Bold="true" Width="130" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDownState" runat="server" Visible="true" Width="155" Height="25" BackColor="White" DataTextField="SatateDesc" DataValueField="Statecode" AutoPostBack="True" OnSelectedIndexChanged="DropDownState_SelectedIndexChanged"></asp:DropDownList>
        <br />    
        <br />       
        <asp:Label ID="Label2" runat="server" Text="Start Date:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" BackColor="White" Width="150" TextMode="Date"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label5" runat="server" Text="End Date:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" BackColor="White" Width="150" TextMode="Date"></asp:TextBox>
                <br />
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button1" runat="server" Height="33px" Text="Search" Width="134px" OnClick="Button1_Click" />  
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button2" runat="server" Height="33px" Text="Generate as Excel" Width="134px" OnClick="Button2_Click" />
                <br />
                <br />
                <asp:GridView ID="GridView1" runat="server" HeaderStyle-BackColor="#3AC0F2" BorderColor="#DEDFDE" ShowHeaderWhenEmpty="True" EmptyDataText = "No Records Found" AutoGenerateColumns="False" Width="2000px" PageSize="100" CellPadding="4" ForeColor="Black" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" GridLines="Vertical" BackColor="White" BorderStyle="None" BorderWidth="1px">
                    <AlternatingRowStyle BackColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="true" />
                    <Columns>
                        <asp:BoundField DataField="NUM" HeaderText="Num" SortExpression="NUM" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="STATE NAME" HeaderText="STATE NAME" SortExpression="STATE NAME" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="STORE LOC" HeaderText="STORE LOC" SortExpression="STORE LOC" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="ITEM CODE" HeaderText="ITEM CODE" SortExpression="ITEM CODE" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="ITEM DESC" HeaderText="ITEM DESC" SortExpression="ITEM DESC" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="ITEM Extended Description" HeaderText="ITEM Extended Description" SortExpression="ITEM Extended Description" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="UOM" HeaderText="UOM" SortExpression="UOM" Visible="true" ItemStyle-Width="5%" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Unit Price" HeaderText="Unit Price (RM)" SortExpression="Unit Price"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Open Bal Qty" HeaderText="Open Bal Qty" SortExpression="Open Bal Qty"  ItemStyle-Width="5%" Visible="true" ReadOnly="false" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Open Bal Value" HeaderText="Open Bal Value (RM)" SortExpression="Open Bal Value"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="GRN Qty" HeaderText="GRN Qty" SortExpression="GRN Qty"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="GRN Value" HeaderText="GRN Value (RM)" SortExpression="GRN Value"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="ISU Qty" HeaderText="ISU Qty" SortExpression="ISU Qty"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="ISU Value" HeaderText="ISU Value (RM)" SortExpression="ISU Value"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="TRF Qty" HeaderText="TRF Qty" SortExpression="TRF Qty"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="TRF Value" HeaderText="TRF Value (RM)" SortExpression="TRF Value"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="RET Qty" HeaderText="RET Qty" SortExpression="RET Qty"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="RET Value" HeaderText="RET Value (RM)" SortExpression="RET Value"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="RTS Qty" HeaderText="RTS Qty" SortExpression="RTS Qty"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="RTS Value" HeaderText="RTS Value (RM)" SortExpression="RTS Value"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="ADJ Qty" HeaderText="ADJ Qty" SortExpression="ADJ Qty"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="ADJ Value" HeaderText="ADJ Value" SortExpression="ADJ Value"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Closing Bal Qty" HeaderText="Closing Bal Qty" SortExpression="Closing Bal Qty"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Closing Bal Value" HeaderText="Closing Bal Value (RM)" SortExpression="Closing Bal Value"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="CAMMS Qty" HeaderText="CAMMS Qty" SortExpression="CAMMS Qty"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="CAMMS Value" HeaderText="CAMMS Value" SortExpression="CAMMS Value"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="CAMMS ITL Qty" HeaderText="CAMMS ITL Qty" SortExpression="CAMMS ITL Qty"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PO Out (Due In Qty)" HeaderText="PO Out (Due In Qty)" SortExpression="PO Out (Due In Qty)"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
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
