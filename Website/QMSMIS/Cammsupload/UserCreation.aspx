<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserCreation.aspx.cs" Inherits="Cammsupload.UserCreation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title id="Title1" title="User Creation" runat="server"></title>
    <style type="text/css">
        #form1 {
            height: 751px;
            margin-right: 0px;
        }
      h4 { 
        display: block;
        font-size: 1.17em;
        margin-top: 1em;
        margin-bottom: 1em;
        margin-left: 0;
        margin-right: 0;
        font-weight: bold;
        font-family:Calibri;
    }
        .panelClass {background-color: lime; width: 300px;}
    </style>
</head>
<body>
    <form id="form1" title="Exclusion Process Report"  runat="server" style="border: medium solid #008080; height:auto">
    <hgroup class="title" >
                <h2 style="border-left: medium none #008080; border-right: medium none #008080; border-top: medium none #008080; border-bottom: medium solid #008080; font-family: Verdana, Geneva, Tahoma, sans-serif; font-weight: bold; font-size: large; font-style: oblique; font-variant: normal; text-transform: capitalize; color: #008080; text-decoration: blink; height: 70px; width: 100%;" class="auto-style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Quantum Medical Solutions
            <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="Black" style="text-align: right"  />
            &nbsp;
            <asp:LinkButton ID="LinkButton4" runat="server" PostBackUrl="~/IndexPage.aspx" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" style="font-weight: 700; text-align: right;" CausesValidation="False">Index Page</asp:LinkButton>
              &nbsp;<asp:LinkButton ID="LinkButton3" runat="server" PostBackUrl="~/Logout.aspx" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" style="font-weight: 700; text-align: right;" CausesValidation="False">Logout</asp:LinkButton>
             </h2>
         </hgroup>
         <div style="border-left: medium none #008080; border-right: medium none #008080; border-top: medium none #008080; border-bottom: medium solid #008080; height: 458px; font-family: Calibri; font-size: medium; text-decoration: blink;" title="User Creation" class="auto-style1">
               <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="User Creation" Width="100%" Height="25px" BackColor="#0099FF" style="text-align: center" ></asp:Label>               
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
            <br />
            <br /> 
            <br /> 
                        &nbsp; 
                        <asp:Label ID="Label6" runat="server" Text="User Name:*" Font-Bold="True" Width="200px" Height="25px" Font-Names="Calibri" style="margin-left: 0px" ></asp:Label>
                        <asp:TextBox ID="TextBox1" runat="server" Width="200px" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUser" ErrorMessage="Please enter Username" ControlToValidate="TextBox1" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="Red" />
                       <br />
                       <br />
                        &nbsp;
                        <asp:Label ID="Label3" runat="server" Text="Email:*" Font-Bold="True" Width="200px" Height="25px" Font-Names="Calibri" style="margin-left: 0px" ></asp:Label>
                        <asp:TextBox ID="TextBox3" runat="server" TextMode="Email" Width="300px"  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox3" ErrorMessage="Please enter Email" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="Red"/>
                        <br />
                       <br />
                       &nbsp;
                       <asp:Label ID="Label5" runat="server" Text="Department :*" Font-Bold="True" Width="200px" Height="25px" Font-Names="Calibri"></asp:Label>
                       <asp:DropDownList ID="DropDownList1" runat="server" Font-Names="Calibri" Visible="true" Width="200px" Height="25px" Font-Size="Medium" BackColor="White" DataTextField="Department" DataValueField="RowID" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>
                       <br />
                       <br />
                       &nbsp;
                       <asp:Label ID="Label7" runat="server" Text="State :*" Font-Bold="True" Width="200px" Height="25px" Font-Names="Calibri"></asp:Label>
                       <asp:DropDownList ID="DropDownList2" runat="server" Font-Names="Calibri" Visible="true" Width="200px" Height="25px" Font-Size="Medium" BackColor="White" DataTextField="ast_lvl_ast_lvl" DataValueField="RowID" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>
                       <br />
                       <br />
                        &nbsp;
                        <asp:Label ID="Label2" runat="server" Text="Password:*" Font-Bold="True" Width="200px" Height="25px" Font-Names="Calibri" style="margin-left: 0px" ></asp:Label>
                        <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" Width="200px" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPWD" runat="server" ControlToValidate="TextBox2" ErrorMessage="Please enter Password" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="Red"/>
                        <br />
                       <br />
                       
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button runat="server" ID="Button1" Height="33px" Font-Names="Calibri" Width="134px" Text="Create User" OnClick="Button1_Click" />
                       &nbsp;&nbsp;
                        <asp:Button runat="server" ID="Button2" Height="33px" Font-Names="Calibri" Visible="true" Width="134px" Text="Clear" OnClick="Button2_Click" CausesValidation="False" />
                        <br />  
                   &nbsp;  
                   <asp:Label ID="Label1" runat="server" Visible="false" Text="" Font-Bold="True" Width="162px" Height="25px" Font-Names="Calibri"></asp:Label>                 
           
    </div>
         <footer>
            <div class="float-left">
                <p>&copy; <%: DateTime.Now.Year %> - Mr.Aravinth Kannan</p>
            </div>
    </footer>
    </form>
</body>
</html>
