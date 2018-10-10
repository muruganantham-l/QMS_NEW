<%@ Page Language="C#" AutoEventWireup="true" CodeFile="loginPage.aspx.cs" Inherits="loginPage" %>
<%@ Import Namespace="System.Web.Optimization"  %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
	<%:Styles.Render("~/Content/bootstrap.min.css") %>
     <%:Styles.Render("~/Content/Site.css") %>
     <%:Styles.Render("~/Content/ej/web/ej.widgets.core.material.min.css") %>
     <%:Styles.Render("~/Content/ej/web/material/ej.theme.min.css") %>
    <%: Scripts.Render("~/Scripts/jquery-3.3.1.min.js")%>
    <%: Scripts.Render("~/Scripts/bootstrap.min.js")%>
    <%: Scripts.Render("~/Scripts/jsrender.min.js")%>
    <%: Scripts.Render("~/Scripts/ej/ej.web.all.min.js")%>
    <%: Scripts.Render("~/Scripts/ej/ej.webform.min.js")%>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="font-family: Calibri; text-align: center; vertical-align: middle;">
         <hgroup class="title" >
                <h2 style="border-left: medium none #008080; border-right: medium none #008080; border-top: medium none #008080; border-bottom: medium solid #008080; font-family: Verdana, Geneva, Tahoma, sans-serif; font-weight: bold; font-size: large; font-style: oblique; font-variant: normal; text-transform: capitalize; color: #008080; text-decoration: blink; height: 70px; width: 100%;" class="auto-style1">Quantum Medical Solutions</h2>
        </hgroup>
     <div style="border-style: none none solid none; border-width: medium; border-color: #008080; height: 496px; font-family: Calibri; font-size: medium; text-decoration: blink;" title="LoginDetail" class="auto-style1">
          <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Underline="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Login Page - Application" Width="100%" Height="25px" style="text-align: center"></asp:Label>
            
    <br />
    <br />
   <br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label14" runat="server" Font-Bold="True" Font-Underline="False" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Username * :" Width="106px" Height="25px"></asp:Label>
    &nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:TextBox ID="txtUserName" runat="server" Font-Names="Calibri" Width="200px" Height="21px"/>
<asp:RequiredFieldValidator ID="rfvUser" ErrorMessage="Please enter Username" ControlToValidate="txtUserName" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="Red" />
<br />
<br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Underline="False" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Password* :" Width="95px" Height="25px"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
<asp:TextBox ID="txtPWD" runat="server" TextMode="Password" Width="200px" Height="21px"/>
<asp:RequiredFieldValidator ID="rfvPWD" runat="server" ControlToValidate="txtPWD" ErrorMessage="Please enter Password" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="Red"/>
        <br />
        <br />
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnSubmit" runat="server" Font-Size="Medium" Text="Login" Width="150" Font-Names="Calibri" onclick="btnSubmit_Click1" style="font-weight: 700" />
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            Note : if you don&#39;t have an account, Please Contact Administrator.<asp:HyperLink ID="HyperLink1" runat="server" ForeColor="#009933" NavigateUrl="mailto:mis@qms.com.my">Admin Contact</asp:HyperLink>
        </div>
    </form>
</body>
</html>
