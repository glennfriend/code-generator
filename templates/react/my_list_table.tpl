import React, { FC } from 'react';
import { Table, Spin } from 'antd';
import { IResponsePagination } from '@onr/core';
import { I{{$obj->upperCamel()}} } from '@onr/{{$obj->lower('_')}}';

interface Iprops {
  page?: number;
  setPage?: CallableFunction;
  responsePagination: IResponsePagination<I{{$obj->upperCamel()}}>;
  columnRender?: any;
}

enum Position {
  bottom = 'bottom',
  top = 'top',
  both = 'both',
}

function getColumns(render: any) {
  const columns = [
    {
      title: 'Id',
      dataIndex: 'id',
    },
    {
      title: 'Name',
      dataIndex: 'name',
    },
  ];
 
  if (render) {
    const operations = {
      title: 'Operations',
      dataIndex: 'operations',
      render: render,
    };
    columns.push(operations);
  }
 
  return columns;
}

/**
 * @param responsePagination
 */
function getPerPageByResponsePagination(responsePagination: IResponsePagination<I{{$obj->upperCamel()}}>) {
  if (responsePagination && responsePagination.meta && responsePagination.meta.per_page) {
    return responsePagination.meta.per_page;
  } else {
    return 15;
  }
}




/**
 * {{$mod->upperCamel()}} list table
 *    - list content to table
 *    - 如果 responsePagination.meta.per_page 存在, 那麼該值會覆蓋 pageSize
 *    - pageSize 必須配合 backend 設定值
 * 
 * example
      <>
        <{{$obj->upperCamel()}}ListTable
          page={1}
          setPage={useState}
          responsePagination={responsePagination}
          columnRender={callback}
        />
      </>
 *
 * @see columnRender https://ant.design/components/table/
 * @param props
 */
export const {{$obj->upperCamel()}}ListTable: FC<Iprops> = (props: Iprops) => {
  const { responsePagination } = props;
  if (!responsePagination) {
    return <Spin />;
  }

  const { page, setPage, lastFieldRender } = props;
  const { data: rows, meta } = responsePagination;
  const pageSize = getPerPageByResponsePagination(responsePagination);

  const onChange = function(changePage: number) {
    setPage(changePage);
  };

  if (page && setPage) {
    return (
      <>
        <Table
          data-testid="table"
          rowKey={row => String(row.id)}
          size="small"
          columns={getColumns(lastFieldRender)}
          dataSource={rows}
          pagination={{
            size: 'middle',
            current: page,
            pageSize: pageSize,
            total: meta.total || rows.length,
            position: Position.bottom,
            onChange: onChange,
            showTotal: (total, range) => `${range[0]}-${range[1]} of ${total} rows`,
          }}
        />
      </>
    );
  } else {
    return (
      <>
        <Table
          data-testid="table"
          rowKey={row => String(row.id)}
          size="small"
          columns={getColumns(lastFieldRender)}
          dataSource={rows}
          pagination={false}
        />
      </>
    );
  }

};
