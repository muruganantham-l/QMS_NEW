 < !--Code corresponding to columnTemplate-- >
    <script type="text/x-jsrender" id="checkboxTemplate">
        <input type="checkbox" class="rowCheckbox" />
    </script>

    <!--Code corresponding to headerTemplate-- >
        <script type="text/x-jsrender" id="headerTemplate">
            <input type="checkbox" id="headchk" />
    </script>

    <div id="Grid"></div>
    <script type="text/javascript">
        $(function () {// Document is ready.        
            $("#Grid").ejGrid({
                dataSource: window.gridData,
                allowSelection: true,
                selectionType: "multiple",
                allowPaging: true
            columns: [
                    { headerTemplateID: "#headerTemplate", template: true, templateID: "#checkboxTemplate", textAlign: ej.TextAlign.Center },//The checkbox column is bound to the grid using template property and headerTemplateID property
                    { field: "OrderID", headerText: "Order ID", isPrimaryKey: true, width: 100 },
                    { field: "CustomerID", headerText: "Customer ID", width: 130 },
                    { field: "Freight", headerText: "Freight", width: 100, format: "{0:C}" },
                    { field: "ShipCountry", headerText: "ShipCountry", width: 100 }
                ],
                create: "create",
                actionComplete: "complete",
                recordClick: "recordClick"
            });
        });
</script>