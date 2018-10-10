<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="QMSBIL.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="height: 289px" aria-multiline="True" contenteditable="false" draggable="true">
    
        <asp:GridView ID="GridView1" runat="server" Width="438px" AutoGenerateColumns="False" ViewStateMode="Enabled"  DataSourceID="SqlDataSource1" Height="168px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowUpdating="GridView1_RowUpdating">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField HeaderText="Rowid" Visible="true" DataField="Rowid" InsertVisible="False" ReadOnly="True" SortExpression="Rowid"/>
                <asp:BoundField ApplyFormatInEditMode="True" DataField="Statecode" HeaderText="Statecode" SortExpression="Statecode" ReadOnly="True" />
                <asp:BoundField DataField="SatateDesc" HeaderText="SatateDesc" SortExpression="SatateDesc" />
                <asp:BoundField DataField="Createdby" HeaderText="Createdby" SortExpression="Createdby" />
                <asp:BoundField DataField="Createddate" HeaderText="Createddate" SortExpression="Createddate" />
            </Columns>
        </asp:GridView>
    
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:tomms_prodConnectionString %>" SelectCommand="SELECT Rowid, Statecode, SatateDesc, Createdby, Createddate FROM stock_location_mst_report_dummy WITH (nolock)" DeleteCommand="DELETE FROM stock_location_mst_report_dummy WHERE (Rowid = @Rowid)" InsertCommand="INSERT INTO stock_location_mst_report_dummy (Statecode, SatateDesc, Createdby, Createddate) VALUES (@Statecode, @satateDesc, @Createdby, GETDATE())" UpdateCommand="UPDATE stock_location_mst_report_dummy SET SatateDesc = @SatateDesc, Createdby = @Createdby, Createddate = GETDATE() WHERE (Rowid = @Rowid)">
            <DeleteParameters>
                <asp:Parameter Name="Rowid" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Statecode" />
                <asp:Parameter Name="satateDesc" />
                <asp:Parameter Name="Createdby" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="SatateDesc" />
                <asp:Parameter Name="Createdby" />
                <asp:Parameter Name="Rowid" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
