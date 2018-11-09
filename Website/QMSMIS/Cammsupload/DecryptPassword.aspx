<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DecryptPassword.aspx.cs" Inherits="Cammsupload.DecryptPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
     <div title="BE - Supporting Doc Upload" style="height: 335px">
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Ramco Password Encryption and Decryption" Width="414px" Height="32px" style="text-align: center; text-decoration: underline"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <br />
                <br />
        <br />
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label2" runat="server" Text="Input Text :*" Font-Bold="True" Width="182px" Height="25px" Font-Names="Calibri"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:Textbox ID="txtInput" runat="server" Text="Nikit@321" Font-Bold="true" Width="180" Height="25" Font-Names="Calibri" style="margin-left: 0px"> </asp:Textbox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="Label11" runat="server" Text="Output Text :*" Font-Bold="true" Width="182px" Height="25px" Font-Names="Calibri" style="margin-left: 0px"> </asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
        <asp:Textbox ID="txtOutput" runat="server" Text="" Font-Bold="true" Width="180" Height="25" Font-Names="Calibri"> </asp:Textbox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <br />
        <br />
         <asp:RadioButtonList ID="optEncrypt" runat="server" Width="545px" RepeatDirection="Horizontal" Height="23px" style="text-align: center">
             <asp:ListItem>Encrypt</asp:ListItem>
             <asp:ListItem>Decrypt</asp:ListItem>
         </asp:RadioButtonList>
         <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="Label4" runat="server" Text="Upload Status :" Font-Bold="true" Width="182px" Height="25px" Font-Names="Calibri"> </asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label1" runat="server" Font-Names="Calibri"  Text="Label" Visible="false"></asp:Label>
        <br />
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnExecute" runat="server" Font-Names="Calibri" Font-Size="Medium" OnClick="btnExecute_Click" Text="View" Width="150px" />
         &nbsp;&nbsp;&nbsp;&nbsp;
        <br />
          </div>
    </form>
</body>
</html>
