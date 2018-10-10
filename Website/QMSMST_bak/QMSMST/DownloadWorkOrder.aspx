<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DownloadWorkOrder.aspx.cs" Inherits="DownloadWorkOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    

      <table>
        <tr>
            <td></td>
            <td></td>
            <td > 
                 
                 <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="Download Work Order" Width="265px" style="text-align: center"></asp:Label>               
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
              <ej:Column Field="wko_mst_wo_no"                  	HeaderText="WO Number"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_assetno"                    	HeaderText="BE Number"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_parent_wo"                  	HeaderText="Parent WO"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_pm_grp"                     	HeaderText="PM Group"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_status"                     	HeaderText="WO Status"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_descs"                      	HeaderText="Problem Reported"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_org_date"                   	HeaderText="WO Date & Time"	   Format="{0:dd/MM/yyyy HH:mm:ss}"                 Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_due_date"                   	HeaderText="Due Date"	    Format="{0:dd/MM/yyyy}"                Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_chg_costcenter"             	HeaderText="Charge Cost Center"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_cmpl_date"                  	HeaderText="Competion Date & Time"	Format="{0:dd/MM/yyyy HH:mm:ss}"                      Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_clo_date"                   	HeaderText="Close Date & Time"	Format="{0:dd/MM/yyyy HH:mm:ss}"                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_assign_to"                  	HeaderText="Assign To"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_planner"                    	HeaderText="Planner"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_flt_code"                   	HeaderText="Problem Code"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_cause_code"                 	HeaderText="Cause Code"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_act_code"                   	HeaderText="Action Code"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_originator"                 	HeaderText="Requester Name"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_phone"                      	HeaderText="Requester Contact No"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_project_id"                 	HeaderText="Project ID"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_work_area"                  	HeaderText="Circle"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_asset_location"             	HeaderText="District"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_asset_level"                	HeaderText="WO State"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_asset_group_code"           	HeaderText="BE Code"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_orig_priority"              	HeaderText="Original Priority"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_plan_priority"              	HeaderText="Plan Priority"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_temp_asset"                 	HeaderText="Loaner Equipment"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_wr_no"                      	HeaderText="WR Number"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_perm_id"                    	HeaderText="Zone"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_work_type"                  	HeaderText="WO Conditional Status"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_work_grp"                   	HeaderText="Work Group"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_sc_date"                    	HeaderText="Status Change Date"	  Format="{0:dd/MM/yyyy}"                  Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_sched_date"                 	HeaderText="Acknowledge Date & Time"	Format="{0:dd/MM/yyyy HH:mm:ss}"                     Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_contract_no"                	HeaderText="Contract No"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_delay_cd"                   	HeaderText="Delay Code"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_customer_cd"                	HeaderText="Clinic Code"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_supv_id"                    	HeaderText="Supervisor ID"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_est_con_cost"               	HeaderText="Estimated Contract Cost"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_con_cost"                   	HeaderText="Contract Cost"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_est_mtl_cost"               	HeaderText="Estimated Material Cost"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_mtl_cost"                   	HeaderText="Material Cost"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_est_lab_cost"               	HeaderText="Estimated Labor Cost"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_lab_cost"                   	HeaderText="Labor Cost"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_varchar1"                   	HeaderText="Clinic Type"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_varchar2"                   	HeaderText="Clinic Category"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_varchar3"                   	HeaderText="Clinic Address"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_varchar4"                   	HeaderText="Clinic Zone"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_varchar5"                   	HeaderText="Manufacturer"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_varchar6"                   	HeaderText="Model"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_varchar7"                   	HeaderText="Serial No"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_varchar8"                   	HeaderText="Ownership"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_varchar9"                   	HeaderText="Clinic Contact"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_numeric1"                   	HeaderText="VCM Proposed Amount"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_numeric3"                   	HeaderText="VCM Agreed Amount"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_datetime1"                  	HeaderText="PPM Reschedule Date"	Format="{0:dd/MM/yyyy}"                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_datetime4"                  	HeaderText="Rejected Date"	    Format="{0:dd/MM/yyyy}"                Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_exc_date"                   	HeaderText="Response Date & Time" Format="{0:dd/MM/yyyy HH:mm:ss}"                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_det_note1"                      	HeaderText="Clinic Name"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_create_by"                  	HeaderText="Created by"	                    Width="150" TextAlign="Left" />
<ej:Column Field="wko_mst_create_date"                	HeaderText="Created Date & Time"	Format="{0:dd/MM/yyyy HH:mm:ss}"                   Width="150" TextAlign="Left" />

            </Columns>
           </ej:Grid>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  >
        <Columns>
          <asp:BoundField DataField="wko_mst_wo_no"                                           	HeaderText="WO Number"	/>
<asp:BoundField DataField="wko_mst_assetno"                                         	HeaderText="BE Number"	/>
<asp:BoundField DataField="wko_det_parent_wo"                                       	HeaderText="Parent WO"	/>
<asp:BoundField DataField="wko_det_pm_grp"                                          	HeaderText="PM Group"	/>
<asp:BoundField DataField="wko_mst_status"                                          	HeaderText="WO Status"	/>
<asp:BoundField DataField="wko_mst_descs"                                           	HeaderText="Problem Reported"	/>
<asp:BoundField DataField="wko_mst_org_date"                                        	HeaderText="WO Date & Time"	/>
<asp:BoundField DataField="wko_mst_due_date"                                        	HeaderText="Due Date"	/>
<asp:BoundField DataField="wko_mst_chg_costcenter"                                  	HeaderText="Charge Cost Center"	/>
<asp:BoundField DataField="wko_det_cmpl_date"                                       	HeaderText="Competion Date & Time"	/>
<asp:BoundField DataField="wko_det_clo_date"                                        	HeaderText="Close Date & Time"	/>
<asp:BoundField DataField="wko_det_assign_to"                                       	HeaderText="Assign To"	/>
<asp:BoundField DataField="wko_det_planner"                                         	HeaderText="Planner"	/>
<asp:BoundField DataField="wko_mst_flt_code"                                        	HeaderText="Problem Code"	/>
<asp:BoundField DataField="wko_det_cause_code"                                      	HeaderText="Cause Code"	/>
<asp:BoundField DataField="wko_det_act_code"                                        	HeaderText="Action Code"	/>
<asp:BoundField DataField="wko_mst_originator"                                      	HeaderText="Requester Name"	/>
<asp:BoundField DataField="wko_mst_phone"                                           	HeaderText="Requester Contact No"	/>
<asp:BoundField DataField="wko_mst_project_id"                                      	HeaderText="Project ID"	/>
<asp:BoundField DataField="wko_mst_work_area"                                       	HeaderText="Circle"	/>
<asp:BoundField DataField="wko_mst_asset_location"                                  	HeaderText="District"	/>
<asp:BoundField DataField="wko_mst_asset_level"                                     	HeaderText="WO State"	/>
<asp:BoundField DataField="wko_mst_asset_group_code"                                	HeaderText="BE Code"	/>
<asp:BoundField DataField="wko_mst_orig_priority"                                   	HeaderText="Original Priority"	/>
<asp:BoundField DataField="wko_mst_plan_priority"                                   	HeaderText="Plan Priority"	/>
<asp:BoundField DataField="wko_det_temp_asset"                                      	HeaderText="Loaner Equipment"	/>
<asp:BoundField DataField="wko_det_wr_no"                                           	HeaderText="WR Number"	/>
<asp:BoundField DataField="wko_det_perm_id"                                         	HeaderText="Zone"	/>
<asp:BoundField DataField="wko_det_work_type"                                       	HeaderText="WO Conditional Status"	/>
<asp:BoundField DataField="wko_det_work_grp"                                        	HeaderText="Work Group"	/>
<asp:BoundField DataField="wko_det_sc_date"                                         	HeaderText="Status Change Date"	/>
<asp:BoundField DataField="wko_det_sched_date"                                      	HeaderText="Acknowledge Date & Time"	/>
<asp:BoundField DataField="wko_det_contract_no"                                     	HeaderText="Contract No"	/>
<asp:BoundField DataField="wko_det_delay_cd"                                        	HeaderText="Delay Code"	/>
<asp:BoundField DataField="wko_det_customer_cd"                                     	HeaderText="Clinic Code"	/>
<asp:BoundField DataField="wko_det_supv_id"                                         	HeaderText="Supervisor ID"	/>
<asp:BoundField DataField="wko_det_est_con_cost"                                    	HeaderText="Estimated Contract Cost"	/>
<asp:BoundField DataField="wko_det_con_cost"                                        	HeaderText="Contract Cost"	/>
<asp:BoundField DataField="wko_det_est_mtl_cost"                                    	HeaderText="Estimated Material Cost"	/>
<asp:BoundField DataField="wko_det_mtl_cost"                                        	HeaderText="Material Cost"	/>
<asp:BoundField DataField="wko_det_est_lab_cost"                                    	HeaderText="Estimated Labor Cost"	/>
<asp:BoundField DataField="wko_det_lab_cost"                                        	HeaderText="Labor Cost"	/>
<asp:BoundField DataField="wko_det_varchar1"                                        	HeaderText="Clinic Type"	/>
<asp:BoundField DataField="wko_det_varchar2"                                        	HeaderText="Clinic Category"	/>
<asp:BoundField DataField="wko_det_varchar3"                                        	HeaderText="Clinic Address"	/>
<asp:BoundField DataField="wko_det_varchar4"                                        	HeaderText="Clinic Zone"	/>
<asp:BoundField DataField="wko_det_varchar5"                                        	HeaderText="Manufacturer"	/>
<asp:BoundField DataField="wko_det_varchar6"                                        	HeaderText="Model"	/>
<asp:BoundField DataField="wko_det_varchar7"                                        	HeaderText="Serial No"	/>
<asp:BoundField DataField="wko_det_varchar8"                                        	HeaderText="Ownership"	/>
<asp:BoundField DataField="wko_det_varchar9"                                        	HeaderText="Clinic Contact"	/>
<asp:BoundField DataField="wko_det_numeric1"                                        	HeaderText="VCM Proposed Amount"	/>
<asp:BoundField DataField="wko_det_numeric3"                                        	HeaderText="VCM Agreed Amount"	/>
<asp:BoundField DataField="wko_det_datetime1"                                       	HeaderText="PPM Reschedule Date"	/>
<asp:BoundField DataField="wko_det_datetime4"                                       	HeaderText="Rejected Date"	/>
<asp:BoundField DataField="wko_det_exc_date"                                        	HeaderText="Response Date & Time"	/>
<asp:BoundField DataField="wko_det_note1"                                           	HeaderText="Clinic Name"	/>
<asp:BoundField DataField="wko_mst_create_by"                                       	HeaderText="Created by"	/>
<asp:BoundField DataField="wko_mst_create_date"                                     	HeaderText="Created Date & Time"	/>

        </Columns>
      </asp:GridView>
       
</asp:Content>

