<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DownloadMasters.aspx.cs" Inherits="AgingReport.DownloadMasters" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

               <table>
        <tr>
            <td>
                <asp:Label Text="State" runat="server"></asp:Label>
            </td>
            <td>
                <asp:DropDownList Width="300"  ID="State_combobox" runat="server" DataTextField="ast_lvl_ast_lvl" DataValueField="ast_lvl_ast_lvl" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None"  Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" ></asp:DropDownList>
             
            </td>
            <td>
                <asp:Label runat="server" Width=100 ></asp:Label>
            </td>
            <td>
                <asp:Button ID="search_btn" runat="server" OnClick="search_btn_Click" Text="Search"  />
            </td>
        </tr>
    </table>
            <asp:Button ID="ExportExcel" runat="server" Text="Export Excel" onclick="ExportExcel_Click"/>
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
 <asp:BoundField   DataField="ast_det_varchar19" HeaderText="Meter Reading"  />
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

           
        </div>
    </form>
</body>
</html>
