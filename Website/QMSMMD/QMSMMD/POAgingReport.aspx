<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="POAgingReport.aspx.cs" Inherits="QMSMMD.POAgingReport" %>

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
    <form id="form1" title="PO AGING REPORT" runat="server">
    <div title= "PO AGING REPORT" style="height: 733px" >
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label13" runat="server" Font-Underline="true" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="PO Aging Report" Width="206px"></asp:Label>
                <br />
                <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label3" runat="server" Text="State : " Font-Names="Calibri" Font-Bold="true" Width="130" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDownState" runat="server" Visible="true" Width="155" Height="25" BackColor="White" DataTextField="SatateDesc" DataValueField="Statecode" AutoPostBack="True" OnSelectedIndexChanged="DropDownState_SelectedIndexChanged"></asp:DropDownList>
        <br />    
        <br />   
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
        <asp:Label ID="Label2" runat="server" Text="From Date:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" BackColor="White" Width="150" TextMode="Date"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label5" runat="server" Text="To Date:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" BackColor="White" Width="150" TextMode="Date"></asp:TextBox>
                <br />
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label1" runat="server" Text="PO Status:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" Visible="true" Width="155" Height="25" BackColor="White" DataTextField="puo_sts_description" DataValueField="puo_sts_status" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label4" runat="server" Text="Supplier Name:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:DropDownList ID="DropDownList2" runat="server" Visible="true" Width="155" Height="25" BackColor="White" DataTextField="sup_mst_desc" DataValueField="sup_mst_supplier_cd" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"></asp:DropDownList>
        <br />
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label6" runat="server" Text="Delivery From:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox3" runat="server" BackColor="White" Width="150" TextMode="Date"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label7" runat="server" Text="Delivery To:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox4" runat="server" BackColor="White" Width="150" TextMode="Date"></asp:TextBox>
                <br />
            <br />
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button1" runat="server" Height="33px" Text="Search" Width="134px" OnClick="Button1_Click" />  
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button2" runat="server" Height="33px" Text="Generate as Excel" Width="134px" OnClick="Button2_Click" />
                <br />
                <br />
        <asp:GridView ID="GridView1" runat="server" HeaderStyle-BackColor="#3AC0F2" BorderColor="#DEDFDE" ShowHeaderWhenEmpty="True" EmptyDataText = "No Records Found" AutoGenerateColumns="False" Width="2000px" PageSize="100" CellPadding="4" ForeColor="Black" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" GridLines="Vertical" BackColor="White" BorderStyle="None" BorderWidth="1px">
                    <AlternatingRowStyle BackColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="true" />
                    <Columns>
                        <asp:BoundField DataField="PO No." HeaderText="PO No." SortExpression="PO No." ItemStyle-Width="4%" Visible="true" >
<ItemStyle Width="4%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PO Date" HeaderText="PO Date" SortExpression="PO Date" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="State Name" HeaderText="State Name" SortExpression="State Name" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Type Of Service" HeaderText="Type Of Service" SortExpression="Type Of Service" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Supplier Name" HeaderText="Supplier Name" SortExpression="Supplier Name" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PO Status" HeaderText="PO Status" SortExpression="PO Status" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Delivery Date" HeaderText="Delivery Date" SortExpression="Delivery Date" Visible="true" ItemStyle-Width="5%" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Payment Terms" HeaderText="Payment Terms" SortExpression="Payment Terms"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Currency Code" HeaderText="Currency Code" SortExpression="Currency Code"  ItemStyle-Width="5%" Visible="true" ReadOnly="false" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Exchange Value" HeaderText="Exchange Value" SortExpression="Exchange Value"  ItemStyle-Width="5%" Visible="true" ReadOnly="false" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Total Cost" HeaderText="Total Cost" SortExpression="Total Cost"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Total Cost in (RM)" HeaderText="Total Cost in (RM)" SortExpression="Total Cost in (RM)"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="PR No" HeaderText="PR No" SortExpression="PR No"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="Close Date" HeaderText="Close Date" SortExpression="Close Date"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="Created By" HeaderText="Created By" SortExpression="Created By"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="No of Days Aging(PO Date to Close Date)" HeaderText="No of Days Aging(PO Date to Close Date)" SortExpression="No of Days Aging(PO Date to Close Date)"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="No of Days Aging(PO Date to Delivery Date)" HeaderText="No of Days Aging(PO Date to Delivery Date)" SortExpression="No of Days Aging(PO Date to Delivery Date)"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>

<asp:BoundField DataField="PO Line" HeaderText="PO Line" SortExpression="PO Line"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>

<asp:BoundField DataField="Item Category" HeaderText="Item Category" SortExpression="Item Category"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="Stock No" HeaderText="Stock No" SortExpression="Stock No"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="Order UOM" HeaderText="Order UOM" SortExpression="Order UOM"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Item Cost" HeaderText="Item Cost" SortExpression="Item Cost"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Suggest Quantity" HeaderText="Suggest Quantity" SortExpression="Suggest Quantity"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
 <asp:BoundField DataField="Order Qty" HeaderText="Order Qty" SortExpression="Order Qty"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>


 <asp:BoundField DataField="Received Qty" HeaderText="Received Qty" SortExpression="Received Qty"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
 <asp:BoundField DataField="RTS Qty" HeaderText="RTS Qty" SortExpression="RTS Qty"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="Matched Qty" HeaderText="Matched Qty" SortExpression="Matched Qty"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="Retail Price" HeaderText="Retail Price" SortExpression="Retail Price"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="Discount %" HeaderText="Discount %" SortExpression="Discount %"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="Discount Amount" HeaderText="Discount Amount" SortExpression="Discount Amount"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                <asp:BoundField DataField="Net Price" HeaderText="Net Price" SortExpression="Net Price"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>

<asp:BoundField DataField="Extended Price" HeaderText="Extended Price" SortExpression="Extended Price"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Line Currency Code" HeaderText="Line Currency Code" SortExpression="Line Currency Code"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Currency Rate" HeaderText="Currency Rate" SortExpression="Currency Rate"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Stock Location" HeaderText="Stock Location" SortExpression="Stock Location"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Tax Code" HeaderText="Tax Code" SortExpression="Tax Code"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Tax Rate" HeaderText="Tax Rate" SortExpression="Tax Rate"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Tax Value" HeaderText="Tax Value" SortExpression="Tax Value"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Charge Cost Center" HeaderText="Charge Cost Center" SortExpression="Charge Cost Center"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Charge Account" HeaderText="Charge Account" SortExpression="Charge Account"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="SLA Date" HeaderText="SLA Date" SortExpression="SLA Date"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Require Date" HeaderText="Require Date" SortExpression="Require Date"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Extended Description" HeaderText="Extended Description" SortExpression="Extended Description"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="WO No" HeaderText="WO No" SortExpression="WO No"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="PR No" HeaderText="PR No" SortExpression="PR No"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="PR Line" HeaderText="PR Line" SortExpression="PR Line"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="MR No" HeaderText="MR No" SortExpression="MR No"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Contract ID" HeaderText="Contract ID" SortExpression="Contract ID"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Contract Line" HeaderText="Contract Line" SortExpression="Contract Line"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Contract Reference" HeaderText="Contract Reference" SortExpression="Contract Reference"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
</asp:BoundField>
                        <asp:BoundField DataField="Last Received Date" HeaderText="Last Received Date" SortExpression="Last Received Date"  ItemStyle-Width="5%" Visible="true" >
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
