<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="IndexPage.aspx.cs" Inherits="IndexPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <ej:Menu ID="MenuControl" Width="70" runat="server" Orientation="Horizontal" >

    <Items>

        <ej:MenuItem Id="Home" Text="Home">

            

            <Items>

                <ej:MenuItem Text="Download Masters">

                    <Items>

                        <ej:MenuItem Text="Asset Register" Url="~/DownloadMasters"></ej:MenuItem>

                    </Items>

                    <Items>

                        <ej:MenuItem Text="Work Request"></ej:MenuItem>

                    </Items>
                      <Items>

                        <ej:MenuItem Text="Work Order"></ej:MenuItem>

                    </Items>

                </ej:MenuItem>

            </Items>



        </ej:MenuItem>



         </Items>

        

</ej:Menu>
</asp:Content>

