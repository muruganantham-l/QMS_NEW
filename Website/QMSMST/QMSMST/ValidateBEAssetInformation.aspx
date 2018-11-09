<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ValidateBEAssetInformation.aspx.cs" Inherits="ValidateBEAssetInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">



    
    <table>
        <tr>
            <td></td>
            <td></td>
            <td > 
                 
                 <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Validate BE Asset Information" Width="265px" style="text-align: center"></asp:Label>               
            </td>
            <td>
                <br />
            </td>

        </tr>
        <tr>
            <td>
                <label ></label>
            </td>
        </tr>
        <tr>
             <td>
                        <asp:Label Text="Validated" Width=100 runat="server"></asp:Label> 
                
                    </td>
                    <td>
                       <ej:DropDownList ID="validate_flagDropDownList" runat="server" >
            <Items>
                <ej:DropDownListItem ID="DropDownListItem1" runat="server" Text="--Select--" Value="0">
                </ej:DropDownListItem>
                <ej:DropDownListItem ID="DropDownListItem2" runat="server" Text="Yes" Value="Y">
                </ej:DropDownListItem>
                <ej:DropDownListItem ID="DropDownListItem3" runat="server" Text="No" Value="N">
                </ej:DropDownListItem>
                 
            </Items>
        </ej:DropDownList>
                         
                    </td>
               <td>
              
                <asp:Label   Width=100 runat="server"></asp:Label>
            </td>
            <td>
              
                <asp:Label Text="State" Width=100 runat="server"></asp:Label>
            </td>
            <td>
                <ej:ComboBox Width="300"  ID="State_combobox" runat="server" DataTextField="ast_lvl_ast_lvl" DataValueField="ast_lvl_ast_lvl" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None"  Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" ></ej:ComboBox>
             
            </td>
            <td>
                <asp:Label runat="server" Width=100 ></asp:Label>
            </td>
            <td>

        
                 
                <%--<asp:Button ID="search_btn" runat="server" OnClick="search_btn_Click" Text="Search"  />--%>
             
                       <ej:Button ID="Button1" runat="server" Type="Button"   Text="Search" OnClick="Button1_Click"></ej:Button>
            </td>
        </tr>
    </table>


    <ej:Grid ID="SQLDataGrid" ShowColumnChooser="true"  enableColumnScrolling="true"  AllowFiltering="true"  AllowScrolling="True" AllowGrouping="true" AllowResizing="true" AllowSelection="true"
    
        runat="server" AllowPaging="True" AllowSorting="True"  OnServerEditRow="SQLDataGrid_ServerEditRow"  >
          <%-- Selectiontype="Multiple"--%>  
<%--        OnServerAddRow="SQLDataGrid_ServerAddRow"
       OnServerEditRow="SQLDataGrid_ServerEditRow" OnServerDeleteRow="SQLDataGrid_ServerDeleteRow"> --%>
         <FilterSettings FilterType="Excel" ShowPredicate="true" />
         <%-- <EditSettings AllowEditing="true" AllowAdding="true" AllowDeleting="true" EditMode="ExternalForm" FormPosition="TopRight"></EditSettings>
           <ToolbarSettings ShowToolbar="true" ToolbarItems="add,edit,delete,update,cancel"></ToolbarSettings>--%>
         <EditSettings EditMode="Dialog" AllowEditing="true" AllowAdding="false" AllowDeleting="false"  ShowConfirmDialog="true"></EditSettings>
           <ToolbarSettings ShowToolbar="true" ToolbarItems="add,edit,delete,update,cancel"></ToolbarSettings>
            <Columns>

                <ej:Column Field="row_no" HeaderText="row_no" IsPrimaryKey="True"   TextAlign="Right" Width="75"  Visible="true"/>
                <ej:Column Field="be_number" HeaderText="BE Number"   Width="150" AllowEditing="false" />  
                <ej:Column Field="be_category" HeaderText="BE Category"    Width="150" AllowEditing="false" />  
                <ej:Column Field="Manufacture" HeaderText="Manufacture" Width="150" />
                <ej:Column Field="Model" HeaderText="Model"  Width="150" />
                <ej:Column Field="SerialNumber" HeaderText="Serial Number" Width="150"/>
                 
                       
                        <ej:Column Field="BELocation" HeaderText="BE Location" Width="150"/>
                            <ej:Column Field="KEWPA_Number" HeaderText="KEWPA Number" Width="150"/>
<ej:Column Field="JKKP_Certificate_Number" HeaderText="JKKP Certificate Number"  Width="150"/>
               
    <ej:Column Field="validated_by" Visible="false" HeaderText="validated by" Width="150" AllowEditing="false"/>
        <ej:Column Field="validated_date" Visible="false" Format="{0:dd/MM/yyyy}" HeaderText="validated date" Width="150" AllowEditing="false"/>
            <ej:Column Field="created_by" Visible="false" HeaderText="created by" Width="150" AllowEditing="false"/>
                <ej:Column Field="created_date" Visible="false" Format="{0:dd/MM/yyyy}" HeaderText="created date" Width="150" AllowEditing="false"/>
                    <ej:Column Field="modified_by" Visible="false"  HeaderText="modified by" Width="150" AllowEditing="false"/>
                        <ej:Column Field="modified_date" Visible="false" Format="{0:dd/MM/yyyy}" HeaderText="modified date" Width="150" AllowEditing="false"/>

                 
            </Columns>
<%--            <EditSettings AllowEditing="True" AllowAdding="True" AllowDeleting="True"></EditSettings>
            <ToolbarSettings ShowToolbar="True" ToolbarItems="add,edit,delete,update,cancel"></ToolbarSettings>--%>
        </ej:Grid>            
     

</asp:Content>

