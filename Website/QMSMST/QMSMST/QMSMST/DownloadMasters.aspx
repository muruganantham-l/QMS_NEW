<%@ Page Title="Download Asset Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DownloadMasters.aspx.cs" Inherits="DownloadMasters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
      
    <table>
        <tr>
            <td></td>
            <td></td>
            <td > 
                 
                 <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Download Asset Register" Width="265px" style="text-align: center"></asp:Label>               
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
                 <div style="margin-left: 100px;">
                <%--<asp:Button ID="search_btn" runat="server" OnClick="search_btn_Click" Text="Search"  />--%>
                <ej:Button ID="Button1" runat="server" Type="Button" ClientSideOnClick="getData" Text="Search" OnClick="search_btn_Click"></ej:Button>
                     </div>
            </td>
        </tr>
    </table>
    
      <div id="gridParent" >
    <ej:Grid ID="FlatGrid"  showColumnChooser="true"  AllowFiltering="true" AllowGrouping="true" AllowResizing="true" AllowSelection="true" Selectiontype="Multiple" runat="server" enableColumnScrolling="true" AllowSorting="true" OnServerWordExporting="FlatGrid_ServerWordExporting" OnServerPdfExporting="FlatGrid_ServerPdfExporting" OnServerExcelExporting="FlatGrid_ServerExcelExporting" AllowPaging="true" AllowScrolling="True">
        <FilterSettings FilterType="Menu" ShowPredicate="true" />
        <ToolbarSettings ShowToolbar="true" ToolbarItems="excelExport,wordExport,pdfExport"></ToolbarSettings>
         <ClientSideEvents DataBound="dataBound"></ClientSideEvents>
        <Columns>

            <ej:Column Field="ast_mst_asset_no" HeaderText="BE Number" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_asset_type" HeaderText="BE Group" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_asset_grpcode" HeaderText="BE Code" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_asset_code" HeaderText="Clinic Category" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_assigned_to" HeaderText="Assigned To" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_asset_shortdesc" HeaderText="BE General Name" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_asset_longdesc" HeaderText="BE Category" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_perm_id" HeaderText="Zone" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_cost_center" HeaderText="Cost Center" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_cus_code" HeaderText="Clinic Code" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_asset_locn" HeaderText="District" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_safety_rqmts" HeaderText="Variation Order" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_work_area" HeaderText="Circle" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_cri_factor" HeaderText="BE Critical Factor" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_datetime8" HeaderText="Installation Date" Format="{0:dd/MM/yyyy}" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_datetime9" HeaderText="CPC Date" Format="{0:dd/MM/yyyy}" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_datetime10" HeaderText="DLP Expiry Date" Format="{0:dd/MM/yyyy}" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_datetime5" HeaderText="PO Date" Format="{0:dd/MM/yyyy}" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_datetime6" HeaderText="T&C Date" Format="{0:dd/MM/yyyy}" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_datetime7" HeaderText="Acceptance Date" Format="{0:dd/MM/yyyy}" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_datetime2" HeaderText="Warranty End" Format="{0:dd/MM/yyyy}" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_datetime3" HeaderText="Rental Start" Format="{0:dd/MM/yyyy}" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_warranty_date" HeaderText="Warranty Expiry" Format="{0:dd/MM/yyyy}" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_datetime1" HeaderText="Warranty Start" Format="{0:dd/MM/yyyy}" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_wrk_grp" HeaderText="Work Group" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_create_by" HeaderText="Created By" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_create_date" HeaderText="Created Date" Format="{0:dd/MM/yyyy}" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_numeric2" HeaderText="Main.Rate(%)" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar1" HeaderText="Clinic Type" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_asset_status" HeaderText="BE Conditional Status" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_ast_lvl" HeaderText="State" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_parent_flag" HeaderText="Parent Flag" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_numeric8" HeaderText="Monthly Rev." Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_numeric9" HeaderText="Rental Per Month" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_numeric1" HeaderText="Maintenance Rev Year" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_note3" HeaderText="UDF Note3" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar30" HeaderText="UDF Text30" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_note1" HeaderText="Clinic Name" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_note2" HeaderText="Clinic Address" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar21" HeaderText="Batch Number" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar22" HeaderText="Ramco Flag" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar18" HeaderText="Software Rev No" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar19" HeaderText="BE Location" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar20" HeaderText="Purchase Order No" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar15" HeaderText="Ownership" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_asset_cost" HeaderText="Purchase Cost" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_mfg_cd" HeaderText="Manufacturer" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_modelno" HeaderText="Model Number" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar2" HeaderText="Serial Number" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar16" HeaderText="Supplier Name" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar17" HeaderText="Supplier Contact No 1" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar12" HeaderText="BE Classification" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar13" HeaderText="KEW PA Reg No" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar14" HeaderText="SPA Reg No" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar9" HeaderText="Region" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar10" HeaderText="SM Type" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar11" HeaderText="PPM Freq" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar6" HeaderText="Clinic Contact No 1" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar7" HeaderText="Clinic Contact No 2" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar8" HeaderText="Clinic Fax No" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_varchar5" HeaderText="DRN Number" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_taxable" HeaderText="Taxable" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_l_account" HeaderText="Labor Account" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_m_account" HeaderText="Material Account" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_mst_print_count" HeaderText="Barcode Print Count" Width="150" TextAlign="Left" />
            <ej:Column Field="ast_det_datetime4" HeaderText="Rental End" Format="{0:dd/MM/yyyy}" Width="150" TextAlign="Left" />

        </Columns>

    </ej:Grid>
     </div>
     <%--<ej:WaitingPopup ID="target" runat="server" Target="#targetelement" ShowOnInit="false"   Text="Loading... Please wait..."></ej:WaitingPopup>--%>
    <script type="text/javascript">
        $(function () {
            $("#<%=FlatGrid.ClientID%>").hide();
            $("#test").ejWaitingPopup("hide");
        });


       setTimeout(function () {
            $.ajax({
                url: "/DownloadMasters.aspx/search_btn_Click",
                type: "POST",
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#<%=FlatGrid.ClientID%>").show();
                }
            });
        }, 700)
                       
        
        //click event of button
        function getData(e) {
            var element = $("#<%=FlatGrid.ClientID%>");
            if (element.ejWaitingPopup("model.showOnInit"))
                element.ejWaitingPopup("hide");
            else
            element.ejWaitingPopup("show");
            
        }

    </script>
    <style>
        .e-waitpopup-pane{
            background-color: transparent !important;
            left: 600px;
            top: 200px;
        }
    </style>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  >
        <Columns>
           <asp:BoundField   DataField="ast_mst_asset_no" HeaderText="BE Number"  />
 <asp:BoundField   DataField="ast_mst_asset_type" HeaderText="BE Group"  />
 <asp:BoundField   DataField="ast_mst_asset_grpcode" HeaderText="BE Code"  />
 <asp:BoundField   DataField="ast_mst_asset_code" HeaderText="Clinic Category"  />
 <asp:BoundField   DataField="ast_mst_assigned_to" HeaderText="Assigned To"  />
 <asp:BoundField   DataField="ast_mst_asset_shortdesc" HeaderText="BE General Name"  />
 <asp:BoundField   DataField="ast_mst_asset_longdesc" HeaderText="BE Category"  />
 <asp:BoundField   DataField="ast_mst_perm_id" HeaderText="Zone"  />
 <asp:BoundField   DataField="ast_mst_cost_center" HeaderText="Cost Center"  />
 <asp:BoundField   DataField="ast_det_cus_code" HeaderText="Clinic Code"  />
 <asp:BoundField   DataField="ast_mst_asset_locn" HeaderText="District"  />
 <asp:BoundField   DataField="ast_mst_safety_rqmts" HeaderText="Variation Order"  />
 <asp:BoundField   DataField="ast_mst_work_area" HeaderText="Circle"  />
 <asp:BoundField   DataField="ast_mst_cri_factor" HeaderText="BE Critical Factor"  />
 <asp:BoundField   DataField="ast_det_datetime8" HeaderText="Installation Date"   />
 <asp:BoundField   DataField="ast_det_datetime9" HeaderText="CPC Date"   />
 <asp:BoundField   DataField="ast_det_datetime10" HeaderText="DLP Expiry Date"   />
 <asp:BoundField   DataField="ast_det_datetime5" HeaderText="PO Date"   />
 <asp:BoundField   DataField="ast_det_datetime6" HeaderText="T&C Date"   />
 <asp:BoundField   DataField="ast_det_datetime7" HeaderText="Acceptance Date"   />
 <asp:BoundField   DataField="ast_det_datetime2" HeaderText="Warranty End"    />
 <asp:BoundField   DataField="ast_det_datetime3" HeaderText="Rental Start"    />
 <asp:BoundField   DataField="ast_det_warranty_date" HeaderText="Warranty Expiry"   />
 <asp:BoundField   DataField="ast_det_datetime1" HeaderText="Warranty Start"   />
 <asp:BoundField   DataField="ast_mst_wrk_grp" HeaderText="Work Group"  />
 <asp:BoundField   DataField="ast_mst_create_by" HeaderText="Created By"  />
 <asp:BoundField   DataField="ast_mst_create_date" HeaderText="Created Date"   />
 <asp:BoundField   DataField="ast_det_numeric2" HeaderText="Main.Rate(%)"  />
 <asp:BoundField   DataField="ast_det_varchar1" HeaderText="Clinic Type"  />
 <asp:BoundField   DataField="ast_mst_asset_status" HeaderText="BE Conditional Status"  />
 <asp:BoundField   DataField="ast_mst_ast_lvl" HeaderText="State"  />
 <asp:BoundField   DataField="ast_mst_parent_flag" HeaderText="Parent Flag"  />
 <asp:BoundField   DataField="ast_det_numeric8" HeaderText="Monthly Rev."  />
 <asp:BoundField   DataField="ast_det_numeric9" HeaderText="Rental Per Month"  />
 <asp:BoundField   DataField="ast_det_numeric1" HeaderText="Maintenance Rev Year"  />
 <asp:BoundField   DataField="ast_det_note3" HeaderText="UDF Note3"  />
 <asp:BoundField   DataField="ast_det_varchar30" HeaderText="UDF Text30"  />
 <asp:BoundField   DataField="ast_det_note1" HeaderText="Clinic Name"  />
 <asp:BoundField   DataField="ast_det_note2" HeaderText="Clinic Address"  />
 <asp:BoundField   DataField="ast_det_varchar21" HeaderText="Batch Number"  />
 <asp:BoundField   DataField="ast_det_varchar22" HeaderText="Ramco Flag"  />
 <asp:BoundField   DataField="ast_det_varchar18" HeaderText="Software Rev No"  />
 <asp:BoundField   DataField="ast_det_varchar19" HeaderText="BE Location"  />
 <asp:BoundField   DataField="ast_det_varchar20" HeaderText="Purchase Order No"  />
 <asp:BoundField   DataField="ast_det_varchar15" HeaderText="Ownership"  />
 <asp:BoundField   DataField="ast_det_asset_cost" HeaderText="Purchase Cost"  />
 <asp:BoundField   DataField="ast_det_mfg_cd" HeaderText="Manufacturer"  />
 <asp:BoundField   DataField="ast_det_modelno" HeaderText="Model Number"  />
 <asp:BoundField   DataField="ast_det_varchar2" HeaderText="Serial Number"  />
 <asp:BoundField   DataField="ast_det_varchar16" HeaderText="Supplier Name"  />
 <asp:BoundField   DataField="ast_det_varchar17" HeaderText="Supplier Contact No 1"  />
 <asp:BoundField   DataField="ast_det_varchar12" HeaderText="BE Classification"  />
 <asp:BoundField   DataField="ast_det_varchar13" HeaderText="KEW PA Reg No"  />
 <asp:BoundField   DataField="ast_det_varchar14" HeaderText="SPA Reg No"  />
 <asp:BoundField   DataField="ast_det_varchar9" HeaderText="Region"  />
 <asp:BoundField   DataField="ast_det_varchar10" HeaderText="SM Type"  />
 <asp:BoundField   DataField="ast_det_varchar11" HeaderText="PPM Freq"  />
 <asp:BoundField   DataField="ast_det_varchar6" HeaderText="Clinic Contact No 1"  />
 <asp:BoundField   DataField="ast_det_varchar7" HeaderText="Clinic Contact No 2"  />
 <asp:BoundField   DataField="ast_det_varchar8" HeaderText="Clinic Fax No"  />
 <asp:BoundField   DataField="ast_det_varchar5" HeaderText="DRN Number"  />
 <asp:BoundField   DataField="ast_det_taxable" HeaderText="Taxable"  />
 <asp:BoundField   DataField="ast_det_l_account" HeaderText="Labor Account"  />
 <asp:BoundField   DataField="ast_det_m_account" HeaderText="Material Account"  />
 <asp:BoundField   DataField="ast_mst_print_count" HeaderText="Barcode Print Count"  />
 <asp:BoundField   DataField="ast_det_datetime4" HeaderText="Rental End"    />
        </Columns>   
    </asp:GridView>



</asp:Content>

