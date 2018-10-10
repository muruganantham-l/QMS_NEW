<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DownloadWorkRequest.aspx.cs" Inherits="DownloadWorkRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    
      <table>
        <tr>
            <td></td>
            <td></td>
            <td > 
                 
                 <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Download Work Request" Width="265px" style="text-align: center"></asp:Label>               
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
             
                       <ej:Button ID="Button1" runat="server" Type="Button"   Text="Search"  OnClick="Button1_Click" ></ej:Button>
            </td>
        </tr>
    </table>

      <ej:Grid ID="FlatGrid"  showColumnChooser="true"  AllowFiltering="true" AllowGrouping="true" AllowResizing="true" AllowSelection="true" Selectiontype="Multiple" runat="server" enableColumnScrolling="true" AllowSorting="true" OnServerWordExporting="FlatGrid_ServerWordExporting" OnServerPdfExporting="FlatGrid_ServerPdfExporting" OnServerExcelExporting="FlatGrid_ServerExcelExporting" AllowPaging="true" AllowScrolling="True">
        <FilterSettings FilterType="Excel" ShowPredicate="true" />
        <ToolbarSettings ShowToolbar="true" ToolbarItems="excelExport,wordExport,pdfExport"></ToolbarSettings>
         <ClientSideEvents DataBound="dataBound"></ClientSideEvents>
        <Columns>
              <ej:Column Field="wkr_mst_wr_no"                  	HeaderText="WR Number"	                    Width="150" TextAlign="Left" />

             <ej:Column Field="wkr_mst_org_date"                  	HeaderText="WR Date Time"	                    Width="150" TextAlign="Left" />
             <ej:Column Field="wkr_mst_assetno"                  	HeaderText="BE Number"	                    Width="150" TextAlign="Left" />
             <ej:Column Field="wkr_mst_location"                  	HeaderText="State"	                    Width="150" TextAlign="Left" />
             <ej:Column Field="wkr_mst_assetlocn"                  	HeaderText="District"	                    Width="150" TextAlign="Left" />
             <ej:Column Field="wkr_mst_create_by"                  	HeaderText="Created By"	                    Width="150" TextAlign="Left" />
             <ej:Column Field="wkr_det_cus_code"                  	HeaderText="Clinic Code"	                    Width="150" TextAlign="Left" />
             <ej:Column Field="wkr_det_note1"                  	    HeaderText="Clinic Name"	                    Width="150" TextAlign="Left" />

              </Columns>
           </ej:Grid>
     <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  >
        <Columns>
          <asp:BoundField DataField="wkr_mst_wr_no"                                           	HeaderText="WR Number"	/>
<asp:BoundField DataField="wkr_mst_org_date"                                         	HeaderText="WR Date Time"		/>
<asp:BoundField DataField="wkr_mst_assetno"                                       		HeaderText="BE Number"	  />
<asp:BoundField DataField="wkr_mst_location"                                          	HeaderText="State"	 />
<asp:BoundField DataField="wkr_mst_assetlocn"                                          		HeaderText="District"		/>
<asp:BoundField DataField="wkr_mst_create_by"                                           		HeaderText="Created By"	/>
<asp:BoundField DataField="wkr_det_cus_code"                                        	HeaderText="Clinic Code"		/>
<asp:BoundField DataField="wkr_det_note1"                                        	 HeaderText="Clinic Name"	/>

        </Columns>
      </asp:GridView>
</asp:Content>

