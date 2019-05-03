<%@ Page Title=""  Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="BILLEntry.aspx.cs" Inherits="BILLEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    
      <table>
        <tr>
            <td></td>
            <td></td>
            <td > 
                 
                 <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" Text="NBE BILL Entry" Width="265px" style="text-align: center"></asp:Label>               
            </td>
            <td>
                <br />
            </td>

        </tr>
         <tr>
                    
                    <td>
                       <ej:DropDownList Width="300" EnableFilterSearch="true" FilterType="Contains"  WatermarkText="State"  CascadeTo ="District_combobox"   OnValueSelect="State_combobox_ValueSelect1"   ID="State_combobox" runat="server" DataTextField="ast_lvl_ast_lvl" DataValueField="ast_lvl_ast_lvl" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None"  Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" ></ej:DropDownList>
             
                         
                    </td>
             
            <td >
              
                <asp:Label   Width=75 runat="server"></asp:Label>  
                
            </td>
            <td>
                 <ej:DropDownList Width="300" EnableFilterSearch="true" FilterType="Contains"  WatermarkText="District"  ID="District_combobox" OnValueSelect="District_combobox_ValueSelect" runat="server" DataTextField="ast_loc_ast_loc" DataValueField="RowID" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None"  Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" ></ej:DropDownList>
             
            </td>
             
            <td>
                <asp:Label runat="server"    Width=75 ></asp:Label>
            </td>

              <td>
                <ej:DropDownList Width="300" EnableFilterSearch="true" FilterType="Contains"  WatermarkText="Clinic Category" OnValueSelect="DropDownCliniccat_ValueSelect"  ID="DropDownCliniccat" runat="server" DataTextField="Cliniccat" DataValueField="RowID" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None"  Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" ></ej:DropDownList>           
             
            </td>
             
            
        </tr>
        <tr>
            <td>
                <asp:Label   Width=75 runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>   
                <%--<ej:DropDownList Width="300" EnableFilterSearch="true" FilterType="Contains"  WatermarkText="Clinic Name"  ID="DropDownclinicname" runat="server" DataTextField="clinic_name" DataValueField="clinic_code" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None"  Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" ></ej:DropDownList>--%>           
               
           
    <ej:Autocomplete   ShowEmptyResultText="true" DataSourceCachingMode="Session"   OnValueSelect="DropDownclinicname_ValueSelect"   ShowResetIcon="true" HighlightSearch="true"   
        AnimateType="Slide" ShowPopupButton="true" ShowRoundedCorner="true" EnableAutoFill="true" EmptyResultText="No Records Found" ShowLoadingIcon="true"
        Width="300" FilterType="Contains" WatermarkText="Clinic Code" ID="DropDownclinicname" runat="server" DataTextField="clinic_name" DataUniqueKeyField="clinic_code"  >

    <MultiColumnSettings Enable="true"  ShowHeader="true" StringFormat="{0}"     >
    <Columns>
    <ej:Columns Field="clinic_code" HeaderText="Clinic Code" />
    <ej:Columns Field="clinic_name" HeaderText="Clinic Name" />
     
    </Columns>
    </MultiColumnSettings> 
        </ej:Autocomplete>
    

     
            </td>
            <td> <asp:Label id="template_label" Visible="false" Text="<input type='checkbox' class='check' />"    Width=75 runat="server"></asp:Label></td>
             <td>   
                 <ej:DropDownList OnValueSelect="DropDownListInstallmentYear_ValueSelect" Width="300" EnableFilterSearch="true" FilterType="Contains"  WatermarkText="Installment Year"
                    ID="DropDownListInstallmentYear" runat="server" DataTextField="start_year"
                 DataValueField="start_year" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None" 
                 Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" ></ej:DropDownList>  
             </td>
          <td> <asp:Label   Width=75 runat="server"></asp:Label></td>
             <td>

             <ej:DropDownList Width="300" EnableFilterSearch="true" FilterType="Contains"  WatermarkText="Installment Month"
                    ID="DropDownListInstallmentMonth" runat="server" DataTextField="MonthName"
                 DataValueField="MonthNumber" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None" 
                 Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" OnValueSelect="DropDownListInstallmentMonth_ValueSelect" ></ej:DropDownList>           
            
                 
                    
            </td>
        </tr>
           <tr>
            <td>
                <asp:Label   Width=75 runat="server"></asp:Label>
            </td>
        </tr>
           <tr>
            <td>   
                <ej:DropDownList Width="300" EnableFilterSearch="true" FilterType="Contains"  WatermarkText="Batch"
                    ID="DropDownListBatch" runat="server" DataTextField="Batchname"
                 DataValueField="Batchno" ActionFailureTemplate="The Request Failed" CssClass="" DataSourceCachingMode="None" 
                 Locale="en-MY" NoRecordsTemplate="No Records Found" SortOrder="None" OnValueSelect="DropDownListBatch_ValueSelect" EnableSorting="true" ></ej:DropDownList>           
            
            </td>
            <td> <asp:Label   Width=75 runat="server"></asp:Label></td>
             <td>  
           
                  <ej:Autocomplete  ShowEmptyResultText="true" ShowResetIcon="true"    AnimateType="Slide" ShowPopupButton="true" 
                  ShowRoundedCorner="true" EnableAutoFill="true" EmptyResultText="No Records Found" Width="300" FilterType="Contains"
                  WatermarkText="BE Number" ID="BENumberAutocomplete" runat="server" DataTextField="be_number" DataUniqueKeyField="be_number"  >

    <MultiColumnSettings Enable="true"  ShowHeader="true" StringFormat="{0}"     >
    <Columns>
    <ej:Columns Field="be_number" HeaderText="BE Number" />
     
     
    </Columns>
    </MultiColumnSettings> 
        </ej:Autocomplete>

             </td>
          <td> <asp:Label   Width=75 runat="server"></asp:Label></td>
             <td>

        
                      <ej:Button ID="Button2" runat="server" Type="Button"  ShowRoundedCorner="true"  Text="Search" OnClick="Button1_Click"></ej:Button>
                    
            </td>
        </tr>
 
    </table>
        

 
    <br />
 <%--//HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"--%>
    <%--https://www.aspsnippets.com/Articles/GridView-with-CheckBox-Get-Selected-Rows-in-ASPNet.aspx--%>
    <%--<asp:CheckBox ID="chkRow" runat="server" Checked='<%# Eval("curr_install_status1") %>'    />--%>
    <asp:GridView ID="GridView1" runat="server"  HeaderStyle-CssClass = "header"

AutoGenerateColumns = "false" Font-Names = "Arial"  OnPageIndexChanging="GridView1_PageIndexChanging"  PageSize="10"

OnRowDataBound = "GridView1_RowDataBound" AllowPaging="false"

Font-Size = "11pt" AlternatingRowStyle-BackColor = "#F5F5F5" HeaderStyle-Font-Size="Small" >

 
    <Columns>
        <asp:TemplateField >

    <HeaderTemplate>

      <%--<asp:CheckBox ID="checkAll" runat="server" onclick = "checkAll(this);" />--%>
          <asp:CheckBox ID="CheckBox1" runat="server" onclick = "checkAll(this);" />

    </HeaderTemplate>

   <ItemTemplate>

     <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("curr_install_status1") %>' onclick = "Check_Click(this)" />

   </ItemTemplate>

</asp:TemplateField>
        
        <asp:TemplateField HeaderText="rowid" Visible="false" ItemStyle-Width="130">
            <ItemTemplate  >
                <asp:Label Visible="false"  ID="rowid_label" runat="server" Text='<%# Eval("rowid") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        
        
        <asp:BoundField DataField="s_no" HeaderText="No" ItemStyle-Width="50"  />
        <asp:BoundField DataField="be_number" HeaderText="BE Number"  ItemStyle-Width="130" />
        <asp:TemplateField HeaderText="Batch" ItemStyle-Width="130">
            <ItemTemplate>
                <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("batch") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="install_start_date" HeaderText="Installment Start Date"  />
        <asp:BoundField DataField="install_end_date"  HeaderText="Installment End Date"  />
        <asp:BoundField DataField="curr_install_no" HeaderText="Current Installment No"  />

        <asp:BoundField DataField="modified_by" HeaderText="Audit User" ItemStyle-Width="150" />
        <asp:BoundField DataField="modified_date" HeaderText="Audit Date" ItemStyle-Width="160" />

         
                 

    </Columns>
</asp:GridView>
<br />
    
            <p align="center">
<ej:Button   ID="Save_Btn" runat="server" Type="Button"   Text="Save" OnClick="Save_Btn_Click"></ej:Button>
       </p>
<hr />


<!--Code corresponding to columnTemplate-->
    <script type="text/x-jsrender" id="checkboxTemplate">
         {{if curr_install_status1}}
           <input type="checkbox"  id="Selected"    name="Selected"     checked              class="rowCheckbox" />
        {{else}}
           <input id="Selected" name="Selected" type="checkbox" class="rowCheckbox"  />
         {{/if}}
    </script>
  
    <!--Code corresponding to headerTemplate-->
    <script type="text/x-jsrender" id="headerTemplate">
        <input type="checkbox" id="headchk" />
    </script>

            <ej:Grid ID="Grid"   Visible="false"      AllowFiltering="true" runat="server" AllowPaging="True"  >  
               <%--<EditSettings AllowEditing="true" EditMode="Normal"   ></EditSettings>--%>
            <%--<ClientSideEvents Create="create" ActionComplete="complete"           />--%>         
                <FilterSettings    FilterType="Excel"></FilterSettings>
                <PageSettings PageSize="5"   />
                   <%--<ToolbarSettings ShowToolbar="True" ToolbarItems="edit ,update,cancel"></ToolbarSettings>--%>
                
            <Columns>
               <%-- <ej:Column Field ="curr_install_status1" AllowEditing="true"  EditType="BooleanEdit"  DisplayAsCheckbox="true" Type="boolean"   
                   HeaderTemplateID="#headerTemplate" Template="True" TemplateID="#checkboxTemplate" TextAlign="Center" /> --%> 
                <ej:Column Field="rowid" HeaderText="row id" Visible="false" IsPrimaryKey="True" />                
                 
                <ej:Column Field="be_number" HeaderText="BE Number"  />                
                <ej:Column Field="batch" HeaderText="Batch" />
                <ej:Column Field="install_start_date" HeaderText="Installment Start Date" />
                <ej:Column Field="install_end_date" HeaderText="Installment End Date" />
                <ej:Column Field="curr_install_no" HeaderText="Current Installment No" />
                
                <ej:Column Field="created_by" HeaderText="created_by" Visible="false" />
                <ej:Column Field="modified_by" HeaderText="Audit User"  AllowEditing="true" />
                <ej:Column Field="created_date" HeaderText="created_date" Visible="false" />
                <ej:Column Field="modified_date" HeaderText="Audit Date"  />

                <ej:Column Type="checkbox" EditType="BooleanEdit"   Field="curr_install_status1" HeaderText="Paid Status"  />

            </Columns>
</ej:Grid>  
<%-- <script type="text/javascript"> 
    function click(args) { 
        if (this.model.editSettings.editMode == "normal") { 
            this.startEdit(args.row);  //trigger to edit the row 
            //this.selectRows(args.row);
            
        } 
    } 
</script>--%> 
    <script type="text/javascript" >
        
    
    function create(args){
        $("#Grid .rowCheckbox").ejCheckBox({ "change": checkChange });
         $("#headchk").ejCheckBox({ "change": headCheckChange });
   }
function complete(args) {
        $("#Grid .rowCheckbox").ejCheckBox({"change": checkChange});
         $("#headchk").ejCheckBox({ "change": headCheckChange, checked: false });
    }

function checkChange(e) {
                gridObj = $("#Grid").data("ejGrid");
                var rowCheck = $(".rowCheckbox:checked");
                if (rowCheck.length == gridObj.model.pageSettings.pageSize)//check if all checkboxes in the current page are checked
                    $("#headchk").ejCheckBox({ "checked": true });
                else
                    $("#headchk").ejCheckBox({ "checked": false });
  
                if (($("#headchk").is(':checked')) && this.model.checked != true) {                    
                    for (i = 0; i < rowCheck.length; i++) {
                        gridObj.multiSelectCtrlRequest = true;
                        gridObj.selectRows($(rowCheck[i]).parents("tr").index());// To prevent unselection of other rows when a checkbox is unchecked after selectAll rows
                    }
                    //uncomment by murugan
                   // gridObj.clearSelection($(this).parents("tr").index()); // To remove selection of current row when the checkbox is unchecked after selectAll rows
                }
                if (this.model.checked == false) {
                    $("#headchk").ejCheckBox({ "checked": false });
                    //$("#Grid .rowCheckbox").ejCheckBox({ "checked": false });
                }
                gridObj.multiSelectCtrlRequest = true;//For MultiSelection using Checkbox
            }


    function recordClick(args) {
                if (this.multiSelectCtrlRequest == false) {
                    for (var i = 0; i < $("#Grid .rowCheckbox").length; i++)
                        $($("#Grid .rowCheckbox")[i]).ejCheckBox({ "checked": false })  //To clear checkbox when we select row by recordclick rather than checkbox
                    this.clearSelection();
                    $("#headchk").ejCheckBox({ "checked": false });
                }
            }


    function headCheckChange(e) {
                $("#Grid .rowCheckbox").ejCheckBox({ "change": checkChange });
                gridObj = $("#Grid").data("ejGrid");
                if ($("#headchk").is(':checked')) {
                    $(".rowCheckbox").ejCheckBox({ "checked": true });
                    gridObj.multiSelectCtrlRequest = true;

                    gridObj.selectRows(0, gridObj.model.pageSettings.pageSize);  // To Select all rows in Grid Content

                    
                    
                }
                else {
                    $(".rowCheckbox").ejCheckBox({ "checked": false });
                    gridObj.clearSelection(); // To remove selection for all rows
                }
            }


        </script>
    
    <script type = "text/javascript">

function Check_Click(objRef)

{

    //Get the Row based on checkbox

    var row = objRef.parentNode.parentNode;

    if(objRef.checked)

    {

        //If checked change color to Aqua

       // row.style.backgroundColor = "aqua";

    }

    else

    {   

        //If not checked change back to original color

        if(row.rowIndex % 2 == 0)

        {

           //Alternating Row Color

           row.style.backgroundColor = "#F5F5F5";

        }

        else

        {

           row.style.backgroundColor = "white";

        }

    }

   

    //Get the reference of GridView

    var GridView = row.parentNode;

   

    //Get all input elements in Gridview

    var inputList = GridView.getElementsByTagName("input");

   

    for (var i=0;i<inputList.length;i++)

    {

        //The First element is the Header Checkbox

        var headerCheckBox = inputList[0];

       

        //Based on all or none checkboxes

        //are checked check/uncheck Header Checkbox

        var checked = true;

        if(inputList[i].type == "checkbox" && inputList[i] != headerCheckBox)

        {

            if(!inputList[i].checked)

            {

                checked = false;

                break;

            }

        }

    }

    headerCheckBox.checked = checked;

   

}

</script>

    <script type = "text/javascript">

function checkAll(objRef)

{

    var GridView = objRef.parentNode.parentNode.parentNode;

    var inputList = GridView.getElementsByTagName("input");

    for (var i=0;i<inputList.length;i++)

    {

        //Get the Cell To find out ColumnIndex

        var row = inputList[i].parentNode.parentNode;

        if(inputList[i].type == "checkbox"  && objRef != inputList[i])

        {

            if (objRef.checked)

            {

                //If the header checkbox is checked

                //check all checkboxes

                //and highlight all rows

               // row.style.backgroundColor = "aqua";

                inputList[i].checked=true;

            }

            else

            {

                //If the header checkbox is checked

                //uncheck all checkboxes

                //and change rowcolor back to original

                if(row.rowIndex % 2 == 0)

                {

                   //Alternating Row Color

                   row.style.backgroundColor = "#F5F5F5";

                }

                else

                {

                   row.style.backgroundColor = "white";

                }

                inputList[i].checked=false;

            }

        }

    }

}

</script> 


    <script type = "text/javascript">

function MouseEvents(objRef, evt)

{

    var checkbox = objRef.getElementsByTagName("input")[0];

   if (evt.type == "mouseover")

   {

        objRef.style.backgroundColor = "orange";

   }

   else

   {

        //if (checkbox.checked)

        //{

        //    objRef.style.backgroundColor = "aqua";

        //}

         if(evt.type == "mouseout")

        {

            if(objRef.rowIndex % 2 == 0)

            {

               //Alternating Row Color

               objRef.style.backgroundColor = "#F5F5F5";

            }

            else

            {

               objRef.style.backgroundColor = "white";

            }

        }

   }

}

</script>



</asp:Content>

