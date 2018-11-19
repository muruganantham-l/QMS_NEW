<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StockAnalysisReport.aspx.cs" Inherits="QMSMMD.StockAnalysisReport" %>

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
    <form id="form1" title="SPARE PARTS ANALYSIS REPORT" runat="server">
    <div title= "SPARE PARTS ANALYSIS REPORT" style="border: thin solid #F4F4F4; height: auto; margin-bottom: 253px; background-color: #C0C0C0;">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label13" runat="server" Font-Underline="true" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="SPARE PARTS ANALYSIS REPORT" Width="400px"></asp:Label>
                <br />
                <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label3" runat="server" Text="State : " Font-Names="Calibri" Font-Bold="true" Width="130" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDownState" runat="server" Visible="true" Width="155" Height="25" BackColor="White" DataTextField="ast_lvl_desc" DataValueField="ast_lvl_ast_lvl" AutoPostBack="True" OnSelectedIndexChanged="DropDownState_SelectedIndexChanged"></asp:DropDownList>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label1" runat="server" Text="BE Category:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:DropDownList ID="Category" runat="server" Visible="true" Width="155" Height="25" BackColor="White" DataTextField="ast_grp_category" DataValueField="ast_grp_grp_cd" AutoPostBack="True" OnSelectedIndexChanged="Category_SelectedIndexChanged"></asp:DropDownList>
            <br />    
        <br />   
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
        <asp:Label ID="Label2" runat="server" Text="Period From:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" BackColor="White" Width="150" TextMode="Date"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label5" runat="server" Text="Period To:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" BackColor="White" Width="150" TextMode="Date"></asp:TextBox>
                <br />
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label4" runat="server" Text="Manufacturer:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:DropDownList ID="Manafacturer" runat="server" Visible="true" Width="155" Height="25" BackColor="White" DataTextField="MfgDescription" DataValueField="mfg_mst_mfg_cd" AutoPostBack="True" OnSelectedIndexChanged="Manafacturer_SelectedIndexChanged"></asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 <asp:Label ID="Label6" runat="server" Text="Supplier:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:DropDownList ID="Supplier" runat="server" Visible="true" Width="155" Height="25" BackColor="White" DataTextField="MfgDescription" DataValueField="mfg_mst_mfg_cd" AutoPostBack="True" OnSelectedIndexChanged="Supplier_SelectedIndexChanged"></asp:DropDownList>
         <br />
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
                        <asp:BoundField DataField="STATE NAME" HeaderText="STATE NAME" SortExpression="STATE NAME" ItemStyle-Width="4%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="BE CATEGORY" HeaderText="BE CATEGORY (GENERAL NAME)" SortExpression="BE CATEGORY" ItemStyle-Width="4%" Visible="true" >
<ItemStyle Width="3%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="MANUFACTURER" HeaderText="MANUFACTURER" SortExpression="MANUFACTURER" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="MODEL" HeaderText="MODEL" SortExpression="MODEL" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="STOCK CODE" HeaderText="STOCK CODE" SortExpression="STOCK CODE" ItemStyle-Width="5" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="DESCRIPTION" HeaderText="STOCK DESCRIPTION" SortExpression="DESCRIPTION" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="20%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PART NO" HeaderText="PART NO" SortExpression="PART NO" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="STOCK LOCATION" HeaderText="STOCK LOCATION" SortExpression="STOCK LOCATION" Visible="true" ItemStyle-Width="5%" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="SUPPLIER NAME" HeaderText="SUPPLIER NAME" SortExpression="SUPPLIER NAME"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="TOTAL QTY PURCHASE" HeaderText="TOTAL QTY PURCHASE" SortExpression="TOTAL QTY PURCHASE"  ItemStyle-Width="5%" Visible="true" ReadOnly="false" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="UNIT PRICE" HeaderText="UNIT PRICE(LATEST PURCHASE COST)" SortExpression="UNIT PRICE"  ItemStyle-Width="5%" Visible="true" ReadOnly="false" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="HQ ON HAND QTY" HeaderText="HQ ON HAND QTY" SortExpression="HQ ON HAND QTY"  ItemStyle-Width="10%" Visible="true" >
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
