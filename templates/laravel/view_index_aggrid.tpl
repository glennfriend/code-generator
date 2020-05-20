@extends('layouts.admin')
@section('content')

    <!-- ag-grid -->
    <script src="{{ asset('dist/ag-grid/grid-tool.js') }}"></script>
    <script src="{{ asset('dist/ag-grid/ag-grid-enterprise.noStyle.js') }}"></script>
    <link  href="{{ asset('dist/ag-grid/ag-grid.css') }}"         rel="stylesheet" type="text/css">
    <link  href="{{ asset('dist/ag-grid/ag-theme-balham.css') }}" rel="stylesheet" type="text/css">


    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">{$obj->upperCamel(' ')}</h1>
        </div>
    </div>

    <button class="btn btn-default" onclick="data_reload()" title="">
        <span class="glyphicon glyphicon-repeat"></span>
        data reload
    </button>
    <script>
        // event
        function data_reload() {
            gridOptions.api.setRowData(API.getAll());
        }
    </script>


    <p></p>
    <div id="app-grid" style="width:100%; height:606px;" class="ag-theme-balham"></div>
    <script>

        var gridOptions = {};

        const API = (function () {
            const url = {
                index: '/api/{$obj->lower('-')}',
            };

            var _fetch = function (url) {
                fetch(url).then(function (response) {
                    return response.json();
                }).then(function (json) {
                    Grid.load(json.data);
                }).catch(function (err) {
                    console.warn(err);
                });
            };

            // --------------------------------------------------------------------------------
            return {

                getAll: function () {
                    _fetch(url.index);
                },

            };
        })();

        const Grid = (function () {

            this.autoExtendColumnFunc = {};

            this.autoExtendColumnFunc.id = function (obj) {
                obj.width = 100;
                obj.suppressSizeToFit = true;
                obj.filter = 'agNumberColumnFilter';
                obj.sort = 'desc';
                obj.valueParser = GridTool.numberParser;
            };

            this.autoExtendColumnFunc.name = function (obj) {
                obj.suppressSizeToFit = true;
                obj.filter = 'agTextColumnFilter';
            };

            var expandColumnDefs = function (columnDefs) {
                for (let key in columnDefs) {
                    if (!columnDefs.hasOwnProperty(key)) {
                        continue;
                    }
                    let el = columnDefs[key];
                    if (!el.field) {
                        continue;
                    }
                    if (this.autoExtendColumnFunc[el.field]) {
                        this.autoExtendColumnFunc[el.field](el);
                    }
                }
            };

            // --------------------------------------------------------------------------------
            return {

                init: function () {
                    gridOptions = {
                        columnDefs: [],
                        rowData: [],
                        rowSelection: 'multiple',
                        defaultColDef: {
                            // editable: true,
                            enableRowGroup: true,
                            enablePivot: true,
                            enableValue: true,
                            sortable: true,
                            resizable: true,
                            filter: true,
                        },
                        pagination: true,
                        paginationAutoPageSize: true,
                        // sideBar: true, // for enterprise
                    };

                    var gridDiv = document.querySelector('#app-grid');
                    new agGrid.Grid(gridDiv, gridOptions);

                    // extend
                    gridOptions.api.showLoadingOverlay();

                    // first API call
                    API.getAll();
                },

                load: function (data) {
                    expandColumnDefs(data.columnDefs);
                    gridOptions.api.setColumnDefs(data.columnDefs);
                    gridOptions.api.setRowData(data.rowData);

                    // extend
                    //gridOptions.api.setDomLayout('autoHeight');
                    GridTool.autoSizeAllColumns(gridOptions, false);
                },

            };
        })();

        ;(function () {
            Grid.init();
        })();

    </script>

