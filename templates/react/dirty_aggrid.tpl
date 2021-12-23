未修改

import {Card, Radio} from "antd";
import React, CSSProperties, {useEffect, useState} from "react";
import {AgGridColumnGroupProps, AgGridColumnProps} from 'ag-grid-react';
import {AgGrid} from "../agGrid";
import {ValueGetterParams} from "ag-grid-community";

interface IProps {
  rowData?: [];
  pageSize?: number,
}

export const ____Board: React.FC<IProps> = props => {

  const [columnDefs, setColumnDefs] = useState<AgGridColumnProps[]>([]);
  const {rowData, pageSize} = props;

  const ValueGetter = {
    header: (params: ValueGetterParams) => {
      const header = params.column.getColDef().headerName as string
      const words = header.split(" ");
      for (let i = 0; i < words.length; i++) {
        words[i] = words[i][0].toUpperCase() + words[i].substr(1);
      }
      return words.join(" ");
    },
    showValue: (params: ValueGetterParams) => {
      const key = params.colDef.field as string;
      return params.data[key];
    },
    none: (params: ValueGetterParams) => {
      return '';
    },
  }
  const ValueFormatter = {
    number: (params: ValueFormatterParams) => {
      return params.value > 0 ? params.value.toFixed(2) : '0';
    },
    integer: (params: ValueFormatterParams) => {
      // 自訂顯示內容, 但是對於 integer 的排序不起作用, cellRendererFramework 也是相同的狀況
      return parseInt(params.value);
    },
  };
  const CellStyle = {
    number: (params: CellClassParams): CSSProperties => {
      const value = params.value;
      switch (true) {
        case (value <= 0):
          return {color: 'red'};
        case (value <= 10):
          return {color: 'orange'};
        case (value <= 50):
          return {color: 'black'};
        case (value <= 100):
          return {color: 'purple'};
        default:
          return {color: 'green'};
      }
    }
  }


  const makeColumnDefs = (data: any[]) => {
    if (data.length === 0) {
      return [];
    }

    // 多層 title
    const infoColumnDefs: AgGridColumnGroupProps[] = [
      {
        headerName: '',
        children: [
          {
            field: 'name',
          },
          {
            field: 'age',
          },
        ],
      }
    ];

    // AgGridColumnProps
    // AgGridColumnGroupProps
    const infoColumnDefs: AgGridColumnProps[] = [
      {
        headerName: '',
        width: 50,
        pinned: true,
        checkboxSelection: true,
        headerCheckboxSelection: true,
        headerCheckboxSelectionFilteredOnly: true,
      },
      {
        headerName: 'hidden-default-sorting',
        field: 'id',
        hide: true,
        sort: 'asc',
      },
      {
        headerName: 'id',
        field: 'id',
        width: 120,
        hide: false,
        sort: 'asc',
        headerValueGetter: ValueGetter.header,
        valueGetter: ValueGetter.name,
        valueFormatter: ValueFormatter.integer,
        cellStyle: CellStyle.number,
      },
      {
        headerName: 'Name',
        field: 'item_name',
        width: 500,
        pinned: false,
      },
    ];

    return infoColumnDefs;
  }

  useEffect(() => {
    const myColumnDefs = makeColumnDefs(rowData);
    setColumnDefs(myColumnDefs);
  }, [rowData]);


  return (
    <Card type="inner" title="Campaign">

      <AgGrid
        columnDefs={columnDefs}
        rowData={rowData}
        pageSize={pageSize}
        closeSideBarByDefault={true}
        rowSelection={'multiple'}
      />

    </Card>
  )
};




// --------------------------------------------------------------------------------
//  base AgGrid
// --------------------------------------------------------------------------------

import React, {useState} from 'react';
import {AgGridColumnProps, AgGridReact, AgGridReactProps} from 'ag-grid-react';
import {
  GridReadyEvent,
  IServerSideDatasource,
  RowSelectedEvent,
  SelectionChangedEvent,
  ServerSideStoreType
} from 'ag-grid-community';
import 'ag-grid-enterprise';
import 'ag-grid-community/dist/styles/ag-theme-alpine.css';
import 'ag-grid-community/dist/styles/ag-grid.css';

export interface AgGridColumnDef extends AgGridColumnProps {
}

type RowSelectionEnum = 'single' | 'multiple';

interface AgGridProps {
  columnDefs?: AgGridColumnDef[];
  rowData?: any[];
  serverSideDatasource?: IServerSideDatasource,
  pageSize?: number;
  getRowHeight?: Function;
  onGridReady?: (event: GridReadyEvent) => void;
  onRowSelected?: (event: RowSelectedEvent) => void;
  onSelectionChanged?: (event: SelectionChangedEvent) => void;
  closeSideBarByDefault?: boolean;
  frameworkComponents?: any;
  rowSelection?: RowSelectionEnum;
}

export const AgGrid: React.FC<AgGridProps> = (props: AgGridProps) => {
  const [gridOption] = useState<AgGridReactProps>({
    sideBar: {
      toolPanels: ['columns'],
      defaultToolPanel: props.closeSideBarByDefault ? undefined : 'columns',
    },
    defaultColDef: {
      enableValue: true,
      enableRowGroup: true,
      enablePivot: true,
      sortable: true,
      resizable: true,
      filter: true,
    },
    autoGroupColumnDef: {
      pinned: 'left',
    },
    enableRangeSelection: true,
    groupDefaultExpanded: -1,
    suppressAggFuncInHeader: true,
    suppressColumnVirtualisation: true,
    onRowDataChanged: params => {
      const columns = params.columnApi.getAllColumns() ?? [];
      const columnIds = columns
        .filter(column => !column.getColDef().width) // do not auto-resize column width if it already defined its width.
        .map(column => column.getColId());

      params.columnApi.autoSizeColumns(columnIds);
    },
    onRowSelected: props.onRowSelected,
    onSelectionChanged: props.onSelectionChanged,
    statusBar: {
      statusPanels: [
        {statusPanel: 'agTotalAndFilteredRowCountComponent', align: 'left'},
        {statusPanel: 'agTotalRowCountComponent', align: 'center'},
        {statusPanel: 'agFilteredRowCountComponent'},
        {statusPanel: 'agSelectedRowCountComponent'},
        {
          statusPanel: 'agAggregationComponent',
          align: 'center',
          statusPanelParams: {
            aggFuncs: ['count', 'sum', 'avg'],
          },
        },
      ],
    },
    pagination: !!props.pageSize,
    paginationPageSize: props.pageSize,
  });

  return (
    <div
      id="myGrid"
      style={{ldelim}}height: 'calc(100vh - 210px)'{{rdelim}}
      className="ag-theme-alpine"
    >
      <AgGridReact
        columnDefs={props.columnDefs}
        rowModelType={props.rowData ? 'clientSide' : 'serverSide'}
        rowData={props.rowData}
        serverSideDatasource={props.serverSideDatasource}
        serverSideStoreType={props.serverSideDatasource ? ServerSideStoreType.Partial : undefined}
        cacheBlockSize={props.serverSideDatasource && props.pageSize ? props.pageSize : undefined}
        getRowHeight={props.getRowHeight}
        onGridReady={props.onGridReady}
        onRowDataChanged={gridOption.onRowDataChanged}
        onRowSelected={gridOption.onRowSelected}
        onSelectionChanged={gridOption.onSelectionChanged}
        frameworkComponents={props.frameworkComponents}
        defaultColDef={gridOption.defaultColDef}
        autoGroupColumnDef={gridOption.autoGroupColumnDef}
        groupDefaultExpanded={gridOption.groupDefaultExpanded}
        suppressAggFuncInHeader={gridOption.suppressAggFuncInHeader}
        suppressColumnVirtualisation={gridOption.suppressColumnVirtualisation}
        sideBar={gridOption.sideBar}
        enableRangeSelection={gridOption.enableRangeSelection}
        statusBar={gridOption.statusBar}
        pagination={gridOption.pagination}
        paginationPageSize={gridOption.paginationPageSize}
        rowSelection={props.rowSelection ? props.rowSelection : 'single'} // single, multiple
        multiSortKey={'ctrl'}
      />
    </div>
  );
};
