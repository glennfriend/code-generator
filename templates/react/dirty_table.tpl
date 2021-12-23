未修改

import {Card, message, Select, Spin, Table, Tag, Space, Checkbox, Radio, Layout, Row, Col} from "antd";
import React, {useEffect, useState} from "react";
import styled from "styled-components";
import Sider from "antd/lib/layout/Sider";
import {Content, Footer, Header} from "antd/lib/layout/layout";
import {SelectProps} from "antd/lib/select";
import {AgGridColumn, AgGridColumnGroupProps, AgGridColumnProps, AgGridReact} from 'ag-grid-react';
import {AgGrid, ReportService} from "../../../report";
import {ICellRendererParams, ValueGetterParams} from "ag-grid-community";

interface IProps {
  campainSource?: [];
}

export const CampaignBoard: React.FC<IProps> = props => {

  const {campainSource} = props;

  useEffect(() => {
  }, [campainSource]);


  const dataColumns = [
    {
      title: 'id',
      dataIndex: 'item_id',
      key: 'item_id',
      className: "hide",
    },
    {
      title: 'campaign',
      dataIndex: 'item_name',
      key: 'item_name',
      className: "show",
    },
  ];

  const rowSelection = {
    onChange: (selectedRowKeys: React.Key[], selectedRows: DataType[]) => {
      console.log(`selectedRowKeys: ${selectedRowKeys}`, 'selectedRows: ', selectedRows);
    },
    getCheckboxProps: (record: DataType) => ({
      disabled: record.name === 'Disabled User', // Column configuration not to be checked
      name: record.name,
    }),
  };

  const rowData = [
    {make: "Toyota", model: "Celica", price: 35000},
    {make: "Ford", model: "Mondeo", price: 32000},
    {make: "Porsche", model: "Boxter", price: 72000}
  ];

  return (
    <Card type="inner" title="Campaign">

      <Table
        dataSource={campainSource}
        columns={dataColumns}
        rowSelection={rowSelection}
        rowKey="id"
      >
      </Table>

    </Card>
  )

};
