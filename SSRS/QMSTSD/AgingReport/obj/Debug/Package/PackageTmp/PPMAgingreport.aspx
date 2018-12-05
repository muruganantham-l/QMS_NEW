<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PPMAgingreport.aspx.cs" Inherits="AgingReport.PPMAgingreport" %>

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
    <form id="form1" title="PPM Aging Report" runat="server">
        <hgroup class="title" >
                <h2 style="border-left: medium none #008080; border-right: medium none #008080; border-top: medium none #008080; border-bottom: medium solid #008080; font-family: Verdana, Geneva, Tahoma, sans-serif; font-weight: bold; font-size: large; font-style: oblique; font-variant: normal; text-transform: capitalize; color: #008080; text-decoration: blink; height: 70px; width: 100%;" class="auto-style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Quantum Medical Solutions
            <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="Black" style="text-align: right"  />
            &nbsp;
            <asp:LinkButton ID="LinkButton4" runat="server" PostBackUrl="~/IndexPage.aspx" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" style="font-weight: 700; text-align: right;">Index Page</asp:LinkButton>
              &nbsp;<asp:LinkButton ID="LinkButton3" runat="server" PostBackUrl="~/Logout.aspx" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" style="font-weight: 700; text-align: right;">Logout</asp:LinkButton>
             </h2>
         </hgroup>
        <div title="PPM Aging Report" style="height: 733px">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="PPM Aging Report" Width="206px" style="text-align: center"></asp:Label>
                
            <br />
                <br />
            <asp:Label ID="Label3" runat="server" Text="State : " Font-Bold="true" Width="150" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDownState" runat="server" Visible="true" Width="200" Height="25" BackColor="White" DataTextField="ast_lvl_ast_lvl" DataValueField="RowID" AutoPostBack="True" OnSelectedIndexChanged="DropDownState_SelectedIndexChanged"></asp:DropDownList>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label4" runat="server" Text="Ownership : " Font-Bold="true" Width="150" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDownOwner" runat="server" Visible="true" AutoPostBack="true" BackColor="White" DataTextField="ownership" DataValueField="RowID" Width="200" Height="25"></asp:DropDownList>
            <br />
            <asp:Label ID="Label1" runat="server" Text="District : " Font-Bold="true" Width="150" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDownDistrict" runat="server" Visible="true" AutoPostBack="true" BackColor="White" DataTextField="ast_loc_ast_loc" DataValueField="RowID" Width="200" Height="25" OnSelectedIndexChanged="DropDownDistrict_SelectedIndexChanged"></asp:DropDownList>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label11" runat="server" Text="Circle : " Font-Bold="true" Width="150" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDowncircle" runat="server" Visible="true" AutoPostBack="true" BackColor="White" DataTextField="ast_loc_circle" DataValueField="RowID" Width="200" Height="25"></asp:DropDownList>
            <br />
            <asp:Label ID="Label12" runat="server" Text="Clinic Category: " Font-Bold="true" Width="150" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDownCliniccat" runat="server" AutoPostBack="true" BackColor="White" DataTextField="Cliniccat" DataValueField="RowID" Width="200" Height="25"></asp:DropDownList>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label2" runat="server" Text="BE Category: " Font-Bold="true" Width="150" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDownBECate" runat="server" AutoPostBack="true" BackColor="White" DataTextField="ast_grp_category" DataValueField="ast_grp_grp_cd" Width="200" Height="25"></asp:DropDownList>
            <br />
            <asp:Label ID="Label6" runat="server" Text="Period From:" Font-Bold="true" Width="150"> </asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" BackColor="White" Width="195" TextMode="Date"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label7" runat="server" Text="Period To:"  Font-Bold="true" Width="150"> </asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" BackColor="White" Width="195" TextMode="Date"></asp:TextBox>
            <br />
            <asp:Label ID="Label5" runat="server" Text="PWO Status: " Font-Bold="true" Width="150" Height="25"> </asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" BackColor="White" DataTextField="wrk_sts_desc" DataValueField="wrk_sts_status" Width="200" Height="25"></asp:DropDownList>
             <br />
                <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="Button1" runat="server" Height="33px" Text="Search" Width="134px" OnClick="Button1_Click" />  
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                <asp:Button ID="Button2" runat="server" Height="33px" Text="Generate as Excel" Width="134px" OnClick="Button2_Click" />
                <br />
                <br />
                <asp:GridView ID="GridView1" runat="server" HeaderStyle-BackColor="#3AC0F2" BorderColor="SeaGreen" ShowHeaderWhenEmpty="true" EmptyDataText = "No Records Found" AutoGenerateColumns="False" Width="1016px" PageSize="100" CellPadding="4" ForeColor="#333333" AllowPaging="true" ShowHeader="true" Visible="true" OnPageIndexChanging="GridView1_PageIndexChanging" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <HeaderStyle BackColor="SeaGreen" Font-Bold="true" Font-Italic="true" />
                    <Columns>
                        <asp:BoundField DataField="No" HeaderText="No" Visible="true"/>
                        <asp:BoundField DataField="WO Number" HeaderText="WO Number" SortExpression="WO Number" Visible="true"/>
                        <asp:BoundField DataField="WO DateTime" HeaderText="WO DateTime" SortExpression="WO DateTime" Visible="true"/>
                        <asp:BoundField DataField="BE Number" HeaderText="BE Number" SortExpression="BE Number" Visible="true"/>
                        <asp:BoundField DataField="BE Category" HeaderText="BE Category" SortExpression="BE Category" Visible="true"/>
                        <asp:BoundField DataField="Manufacturer" HeaderText="Manufacturer" SortExpression="Manufacturer" Visible="true"/>
                        <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" Visible="true"/>
                        <asp:BoundField DataField="Serial No" HeaderText="Serial No" SortExpression="Serial No" Visible="true"/>
                        <asp:BoundField DataField="WO Status" HeaderText="WO Status" SortExpression="WO Status" Visible="true"/>
                        <asp:BoundField DataField="Due Date" HeaderText="Due Date" SortExpression="Due Date" Visible="true"/>
                        <asp:BoundField DataField="Completion Date" HeaderText="Completion Date" SortExpression="Completion Date" Visible="true"/>
                        <asp:BoundField DataField="Assign To" HeaderText="Assign To" SortExpression="Assign To" Visible="true"/>
                        <asp:BoundField DataField="Action Taken" HeaderText="Action Taken" SortExpression="Action Taken" Visible="true"/>
                        <asp:BoundField DataField="Zone" HeaderText="Zone" SortExpression="Zone" Visible="true"/>
                        <asp:BoundField DataField="Circle" HeaderText="Circle" SortExpression="Circle" Visible="true"/>
                        <asp:BoundField DataField="District" HeaderText="District" SortExpression="District" Visible="true"/>
                        <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" Visible="true"/>
                        <asp:BoundField DataField="Clinic Code" HeaderText="Clinic Code" SortExpression="Clinic Code" Visible="true"/>
                        <asp:BoundField DataField="Clinic Name" HeaderText="Clinic Name" SortExpression="Clinic Name" Visible="true"/>
                        <asp:BoundField DataField="Clinic Type" HeaderText="Clinic Type" SortExpression="Clinic Type" Visible="true"/>
                        <asp:BoundField DataField="Clinic Category" HeaderText="Clinic Category" SortExpression="Clinic Category" Visible="true"/>
                        <asp:BoundField DataField="Ownership" HeaderText="Ownership" SortExpression="Ownership" Visible="true"/>
                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" Visible="true"/>
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
