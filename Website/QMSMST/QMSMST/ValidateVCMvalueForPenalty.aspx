<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ValidateVCMvalueForPenalty.aspx.cs" Inherits="ValidateVCMvalueForPenalty" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    
    <table>
        <tr>
            <td></td>
            <td></td>
            <td > 
                 
                 <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Validate VCM Value for Penalty" Width="265px" style="text-align: center"></asp:Label>               
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
                      <ej:DropDownList WatermarkText ="Validated" ID="validate_flagDropDownList" Width="300"   runat="server" >
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
             
            <td >
              
                <asp:Label   Width=75 runat="server"></asp:Label>  
                
            </td>
            <td>
                <ej:ComboBox Width="300" Placeholder="State"  OnValueSelect="State_combobox_ValueSelect"     ID="State_combobox" runat="server" DataTextField="ast_lvl_ast_lvl" DataValueField="ast_lvl_ast_lvl" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None"  Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" ></ej:ComboBox>
             
            </td>
             
            <td>
                <asp:Label runat="server"    Width=75 ></asp:Label>
            </td>

              <td>
                <ej:ComboBox Width="300" Placeholder="District"  ID="District_combobox" runat="server" DataTextField="ast_loc_ast_loc" DataValueField="RowID" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None"  Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" ></ej:ComboBox>
             
            </td>
             
            
        </tr>
        <tr>
            <td>
                <asp:Label   Width=75 runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>    <ej:ComboBox Width="300" Placeholder="Year"  ID="Year_ComboBox" runat="server" DataTextField="year_id" DataValueField="year_txt" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None"  Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" ></ej:ComboBox>              </td>
            <td> <asp:Label   Width=75 runat="server"></asp:Label></td>
             <td>    <ej:ComboBox Width="300" Placeholder="Quarter"  ID="Quarter_ComboBox" runat="server" DataTextField="quarter_txt" DataValueField="quarter_id" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None"  Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" ></ej:ComboBox>              </td>
          <td> <asp:Label   Width=75 runat="server"></asp:Label></td>
             <td>

        
                 
                <%--<asp:Button ID="search_btn" runat="server" OnClick="search_btn_Click" Text="Search"  />--%>
             
                       <ej:Button ID="Button1" runat="server" Type="Button"   Text="Search" OnClick="Button1_Click"></ej:Button>
            </td>
        </tr>
    </table>
    
    <ej:Grid ID="SQLDataGrid" ShowColumnChooser="true"  enableColumnScrolling="true"  AllowFiltering="true"  AllowScrolling="True" AllowGrouping="true" AllowResizing="true" AllowSelection="true"
    
        runat="server" AllowPaging="True" AllowSorting="True"  OnServerEditRow="SQLDataGrid_ServerEditRow"   OnServerCommandButtonClick="SQLDataGrid_ServerCommandButtonClick" >
          <%-- Selectiontype="Multiple"--%>  
<%--        OnServerAddRow="SQLDataGrid_ServerAddRow"
       OnServerEditRow="SQLDataGrid_ServerEditRow" OnServerDeleteRow="SQLDataGrid_ServerDeleteRow"> --%>
         <FilterSettings FilterType="Excel" ShowPredicate="true" />
         <%-- <EditSettings AllowEditing="true" AllowAdding="true" AllowDeleting="true" EditMode="ExternalForm" FormPosition="TopRight"></EditSettings>
           <ToolbarSettings ShowToolbar="true" ToolbarItems="add,edit,delete,update,cancel"></ToolbarSettings>--%>
         <EditSettings EditMode="Dialog" AllowEditing="true" AllowAdding="false" AllowDeleting="false"  ShowConfirmDialog="true"></EditSettings>
           <ToolbarSettings ShowToolbar="true" ToolbarItems="add,edit,delete,update,cancel"></ToolbarSettings>
            <Columns>

                <ej:Column Field="row_no" HeaderText="row_no" IsPrimaryKey="True"   TextAlign="Right" Width="1"  Visible="false"/>
                <ej:Column Field="s_no" HeaderText="No"   Width="50" AllowEditing="false" />  
                <ej:Column Field="clinic_category" HeaderText="Clinic Category"    Width="150" AllowEditing="false" />  
                <ej:Column Field="response_time_penalty" HeaderText="Response Time Penalty" Width="150" />
                <ej:Column Field="repair_time_penalty" HeaderText="Repair Time Penalty"  Width="150" />
                <ej:Column Field="Preventive_Maintenance_Penalty " HeaderText="Preventive Maintenance Penalty " Width="150"/>
                 
                       
                        <ej:Column Field="Total_Penalty" HeaderText="Total Penalty" Width="150"/>
                            
               
    <ej:Column Field="validated_by" Visible="false" HeaderText="validated by" Width="150" AllowEditing="false"/>
        <ej:Column Field="validated_date" Visible="false" Format="{0:dd/MM/yyyy}" HeaderText="validated date" Width="150" AllowEditing="false"/>
            <ej:Column Field="created_by" Visible="false" HeaderText="created by" Width="150" AllowEditing="false"/>
                <ej:Column Field="created_date" Visible="false" Format="{0:dd/MM/yyyy}" HeaderText="created date" Width="150" AllowEditing="false"/>
                    <ej:Column Field="modified_by" Visible="false"  HeaderText="modified by" Width="150" AllowEditing="false"/>
                        <ej:Column Field="modified_date" Visible="false" Format="{0:dd/MM/yyyy}" HeaderText="modified date" Width="150" AllowEditing="false"/>
                <ej:Column HeaderText="Validate" TextAlign="Left" Width="160">                    
                    <Command>
                        
                        <ej:Commands Type="edit">
                            <ButtonOptions Size="Mini" Text="Validate" ></ButtonOptions>
                        </ej:Commands>
                         
                    </Command>
                </ej:Column>       
                 
            </Columns>
<%--            <EditSettings AllowEditing="True" AllowAdding="True" AllowDeleting="True"></EditSettings>
            <ToolbarSettings ShowToolbar="True" ToolbarItems="add,edit,delete,update,cancel"></ToolbarSettings>--%>
        </ej:Grid>    
</asp:Content>

