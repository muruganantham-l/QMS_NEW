<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="QMSMMD.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #Select1 {
            width: 162px;
        }
        #Button2 {
            width: 205px;
        }
    </style>
</head>
<body style="height: 415px">
    <form id="form1" runat="server">
    <div style="height: 375px">
        

        <br />
        <asp:FileUpload ID="FileUpload1" runat="server" Height="23px" Width="232px" />
        <br />
        <br />
        <asp:FileUpload ID="FileUpload2" runat="server" Height="23px" Width="235px" AllowMultiple="true" style="margin-right: 0px"  />
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        

        <asp:Button ID="Button1" runat="server" Text="Button" Width="117px" OnClick="Button1_Click" />
    
        <br />
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    
        <asp:Button ID="imagebutton" runat="server" Text="show Image" OnClick="imagebutton_Click"/>

        <br />
        <br />
                  <asp:Image ID="Image1" runat="server" Height="145px" Width="806px" ImageUrl='<%#"attachment:Image/jpg;base64,"+ Convert.ToBase64String((byte[])Eval("Imagedata")) %>'/>

    </div>
    </form>
</body>
</html>
