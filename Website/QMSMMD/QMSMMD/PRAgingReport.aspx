<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PRAgingReport.aspx.cs" Inherits="QMSMMD.PRAgingReport" %>

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
    <form id="form1" title="PR AGING REPORT" runat="server">
    <div title= "PR AGING REPORT" style="border: thin solid #F4F4F4; height: auto; margin-bottom: 253px; background-color: #C0C0C0;" >
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label13" runat="server" Font-Underline="true" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="PR Aging Report" Width="206px"></asp:Label>
                <br />
                <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label3" runat="server" Text="State : " Font-Names="Calibri" Font-Bold="true" Width="130" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDownState" runat="server" Visible="true" Width="155" Height="25" BackColor="White" DataTextField="ast_lvl_desc" DataValueField="ast_lvl_ast_lvl" AutoPostBack="True" OnSelectedIndexChanged="DropDownState_SelectedIndexChanged"></asp:DropDownList>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label1" runat="server" Text="BE Category:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:DropDownList ID="Category" runat="server" Visible="true" Width="155" Height="25" BackColor="White" DataTextField="ast_grp_general_name" DataValueField="ast_grp_grp_cd" AutoPostBack="True" OnSelectedIndexChanged="Category_SelectedIndexChanged"></asp:DropDownList>
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
                <asp:Label ID="Label6" runat="server" Text="Stock No:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox3" runat="server" BackColor="White" Width="155" Height="25" AutoPostBack="true" AutoCompleteType="None" TextMode="Search"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label7" runat="server" Text="BE No:" Font-Names="Calibri" Font-Bold="true" Width="130"> </asp:Label>
                <asp:TextBox ID="TextBox4" runat="server" BackColor="White" Width="155" Height="23" ></asp:TextBox>
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
                        <asp:BoundField DataField="BE NO" HeaderText="BE NO" SortExpression="BE NO" ItemStyle-Width="4%" Visible="true" >
<ItemStyle Width="3%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="BE CATEGORY" HeaderText="BE CATEGORY (GENERAL NAME)" SortExpression="BE CATEGORY" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="MRE NO" HeaderText="MRE NO" SortExpression="MRE NO" ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="MRE DATE" HeaderText="MRE DATE" SortExpression="MRE DATE" ItemStyle-Width="100" Visible="true" >
<ItemStyle Width="100%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PR NO" HeaderText="PR NO" SortExpression="PR NO" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PRE DATE" HeaderText="PRE DATE" SortExpression="PRE DATE" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PRE APPROVED DATE" HeaderText="PRE APPROVED DATE" SortExpression="PRE APPROVED DATE" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PR APPROVED DATE" HeaderText="PR APPROVED DATE (CEO)" SortExpression="PR APPROVED DATE" ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PR CATEGORY" HeaderText="PR CATEGORY" SortExpression="PR CATEGORY" Visible="true" ItemStyle-Width="5%" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="FINANCE CODE" HeaderText="FINANCE CODE" SortExpression="FINANCE CODE" Visible="true" ItemStyle-Width="5%" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="STATUS" HeaderText="PR STATUS" SortExpression="STATUS"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="APPROVAL PROCESS" HeaderText="APPROVAL PROCESS" SortExpression="APPROVAL PROCESS"  ItemStyle-Width="5%" Visible="true" ReadOnly="false" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="WO NO" HeaderText="WO NO" SortExpression="WO NO"  ItemStyle-Width="5%" Visible="true" ReadOnly="false" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="WO DATE" HeaderText="WO DATE" SortExpression="WO DATE"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
						 <asp:BoundField DataField="WO STATUS" HeaderText="WO STATUS" SortExpression="WO STATUS"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="COST CENTER" HeaderText="COST CENTER" SortExpression="COST CENTER"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="MANUFACTURER" HeaderText="MANUFACTURER" SortExpression="MANUFACTURER"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="MODEL" HeaderText="MODEL" SortExpression="MODEL"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="7%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="STOCK NO" HeaderText="STOCK NO" SortExpression="STOCK NO"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="DESCRIPTION" HeaderText="STOCK DESCRIPTION" SortExpression="DESCRIPTION"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="QTY" HeaderText="STOCK QTY" SortExpression="QTY"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="UNIT PRICE" HeaderText="UNIT PRICE" SortExpression="UNIT PRICE"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="SUPPLIER" HeaderText="RECOMMENDED SUPPLIER" SortExpression="SUPPLIER"  ItemStyle-Width="8%" Visible="true" >
<ItemStyle Width="8%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="PO NO" HeaderText="PO NO" SortExpression="PO NO"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="5%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="PO NO DATE" HeaderText="PO DATE" SortExpression="PO NO DATE"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="PO STATUS" HeaderText="PO STATUS" SortExpression="PO STATUS"  ItemStyle-Width="10%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="NO OF DAYS AGING (WO TO MRE)" HeaderText="NO OF DAYS AGING (WO Date TO MRE Date)" SortExpression="NO OF DAYS AGING (WO TO MRE)"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="NO OF DAYS AGING (MRE TO PRE)" HeaderText="NO OF DAYS AGING (MRE Date TO PRE Date)" SortExpression="NO OF DAYS AGING (MRE TO PRE)"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="NO OF DAYS AGING (PRE TO PO)" HeaderText="NO OF DAYS AGING (PRE Date TO PO Date)" SortExpression="NO OF DAYS AGING (PRE TO PO)"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="NO OF DAYS AGING (PRE TO PRE APPROVED)" HeaderText="NO OF DAYS AGING (PRE TO PRE APPROVED)" SortExpression="NO OF DAYS AGING (PRE TO PRE APPROVED)"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="NO OF DAYS AGING (PRE TO PR APPROVED)" HeaderText="NO OF DAYS AGING (PRE TO PR APPROVED)" SortExpression="NO OF DAYS AGING (PRE TO PR APPROVED)"  ItemStyle-Width="5%" Visible="true" >
<ItemStyle Width="10%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="NO OF DAYS AGING (PR APPROVED TO PO DATE)" HeaderText="NO OF DAYS AGING (PR APPROVED TO PO DATE)" SortExpression="NO OF DAYS AGING (PR APPROVED TO PO DATE)"  ItemStyle-Width="5%" Visible="true" >
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
