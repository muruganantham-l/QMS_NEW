<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GRNReport.aspx.cs" Inherits="QMSMMD.GRNReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <style type="text/css">
        #form1 {
            height: auto;
            margin-right: 0px;
        }
    </style>
</head>
<body>
    <form id="form1" title="GRN REPORT" runat="server">
    <div title= "GRN REPORT" style="border: thin solid #F4F4F4; height: auto; margin-bottom: 253px;" >
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label13" runat="server" Font-Underline="true" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="GRN Report" Width="206px"></asp:Label>
                <br />
                <br />
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label3" runat="server" Text="State : " Font-Names="Calibri" Font-Bold="true" Width="130" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDownState" runat="server" Visible="true" Width="155" Height="25" BackColor="White" DataTextField="SatateDesc" DataValueField="Statecode" AutoPostBack="True" OnSelectedIndexChanged="DropDownState_SelectedIndexChanged"></asp:DropDownList>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label1" runat="server" Text="Stock Location : " Font-Names="Calibri" Font-Bold="true" Width="130" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server" Visible="true" Width="155" Height="25" BackColor="White" DataTextField="Stocklocation" DataValueField="Stocklocation" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>
          <br />   
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
        <asp:Label ID="Label2" runat="server" Text="Period From:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" BackColor="White" Width="150" TextMode="Date"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label5" runat="server" Text="Period To:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" BackColor="White" Width="150" TextMode="Date"></asp:TextBox>
                
        <br />
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Search" runat="server" Height="33px" Text="Search" Width="134px" OnClick="Search_Click" />  
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Generate" runat="server" Height="33px" Text="Generate as Excel" Width="134px" OnClick="Generate_Click" />
                <br />
                <br />
        <asp:GridView ID="GridView1" runat="server" HeaderStyle-BackColor="#3AC0F2" BorderColor="#DEDFDE" ShowHeaderWhenEmpty="True" EmptyDataText = "No Records Found" AutoGenerateColumns="False" Width="1800px" PageSize="100" CellPadding="4" ForeColor="Black" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" GridLines="Vertical" BackColor="White" BorderStyle="None" BorderWidth="1px">
                    <AlternatingRowStyle BackColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="true" />
                    <Columns>
                        <asp:BoundField DataField="NUM" HeaderText="NUM" SortExpression="NUM" ItemStyle-Width="4%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="STATE NAME" HeaderText="STATE NAME" SortExpression="STATE NAME" ItemStyle-Width="4%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="EMPLOYEE ID" HeaderText="STATE RECEIVE PHYSICAL PART (EMPLOYEE ID)" SortExpression="EMPLOYEE ID" ItemStyle-Width="4%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>                        
                        <asp:BoundField DataField="STOCK LOCATION" HeaderText="STOCK LOCATION" SortExpression="STOCK LOCATION" ItemStyle-Width="4%" Visible="true" >
<ItemStyle Width="3%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="COST CENTER" HeaderText="COST CENTER" SortExpression="COST CENTER" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="RECEIVE DATE" HeaderText="RECEIVE DATE (CHOP RECEIVE - REMARKS)" SortExpression="RECEIVE DATE" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="GRN DATE" HeaderText="GRN DATE (SYSTEM DATE)" SortExpression="GRN DATE" ItemStyle-Width="100" Visible="true" >
<ItemStyle Width="100%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="AGING RECEIVE DATE TO GRN" HeaderText="NO OF DAYS AGING (RECEIVE DATE TO GRN IN CAMMS)" SortExpression="AGING RECEIVE DATE TO GRN" ItemStyle-Width="5%" Visible="true">
                            <ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="SOURCE" HeaderText="PO NO / MISCELLENIOUS (SOURCE)" SortExpression="SOURCE" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="STOCK NUM" HeaderText="STOCK NUM" SortExpression="STOCK NUM" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="STOCK DESCR" HeaderText="STOCK DESCR" SortExpression="STOCK DESCR" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PART NUM" HeaderText="PART NUM" SortExpression="PART NUM" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="UOM" HeaderText="UOM" SortExpression="UOM" Visible="true" ItemStyle-Width="5%" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PO QTY" HeaderText="PO QTY" SortExpression="PO QTY" Visible="true" ItemStyle-Width="5%" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="RECEIVE QTY" HeaderText="RECEIVE QTY" SortExpression="RECEIVE QTY"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="BALANCE QTY" HeaderText="BALANCE QTY" SortExpression="BALANCE QTY"  ItemStyle-Width="5%" Visible="true" ReadOnly="false" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="ITEM COST (RM)" HeaderText="ITEM COST (RM)" SortExpression="ITEM COST (RM)"  ItemStyle-Width="5%" Visible="true" ReadOnly="false" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="TOTAL COST (RM)" HeaderText="TOTAL COST (RM)" SortExpression="TOTAL COST (RM)"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="GRN NUM" HeaderText="GRN NUM" SortExpression="GRN NUM"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="SUPPLIER DO NUM" HeaderText="SUPPLIER DO NUM" SortExpression="SUPPLIER DO NUM"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="SUPPLIER  INVOICE NUM" HeaderText="SUPPLIER INVOICE NUM" SortExpression="SUPPLIER  INVOICE NUM"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="7%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="WO NUM" HeaderText="WO NUM" SortExpression="WO NUM"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="MR NUM" HeaderText="MR# NUM" SortExpression="MR NUM"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PR NUM" HeaderText="PR NUM" SortExpression="PR NUM"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="SUPPLIER NAME" HeaderText="SUPPLIER NAME" SortExpression="SUPPLIER NAME"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="GRN BY" HeaderText="GRN BY (NAME)" SortExpression="GRN BY"  ItemStyle-Width="8%" Visible="true" >
<ItemStyle Width="8%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="DELIVERY STATUS" HeaderText="DELIVERY STATUS (REMARKS)" SortExpression="DELIVERY STATUS"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="PARTS DELIVERED BY" HeaderText="PARTS DELIVERED BY (REMARKS)" SortExpression="PARTS DELIVERED BY"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="INVOICE NUM" HeaderText="INVOICE NUM" SortExpression="INVOICE NUM"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="PO INVOICE CLOSE DATE" HeaderText="PO# INVOICE CLOSE DATE" SortExpression="PO INVOICE CLOSE DATE"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="INVOICE STATUS" HeaderText="INVOICE STATUS" SortExpression="INVOICE STATUS"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="INVOICE UPDATE BY" HeaderText="INVOICE UPDATE BY (NAME)" SortExpression="INVOICE UPDATE BY"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="RTS QTY" HeaderText="RTS QTY" SortExpression="RTS QTY"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="RTS VALUE (RM)" HeaderText="RTS VALUE (RM)" SortExpression="RTS VALUE (RM)"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PO CREDIT TERM" HeaderText="PO# CREDIT TERM" SortExpression="PO CREDIT TERM"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PO STATUS" HeaderText="PO# STATUS" SortExpression="PO STATUS"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PO TYPE" HeaderText="PO# TYPE" SortExpression="PO TYPE"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        </Columns>
                    <EmptyDataTemplate>           No Data Available!       </EmptyDataTemplate>
                    <FooterStyle BackColor="#CCCC99" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#F7F7DE" VerticalAlign="Middle" HorizontalAlign="Center" />
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
