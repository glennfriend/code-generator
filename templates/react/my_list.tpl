import React, { useContext, useState, useEffect, FC } from 'react';
import { Card, Button, Modal, Divider, Popconfirm, message } from 'antd';
import { DefaultPubSubContext, IResponsePagination } from '@onr/core';
import { {{$obj->upperCamel()}}ListTable, {{$obj->upperCamel()}}CreateForm, {{$obj->upperCamel()}}UpdateForm, {{$obj->upperCamel()}}Service, I{{$obj->upperCamel()}} } from '@onr/{{$obj->lower('_')}}';


interface IProps {
  accountId: number;
}

/**
 * {{$mod->upperCamel()}} list section
 *    - get API
 *    - list content to table
 *
 * example
      <>
        <{{$obj->upperCamel()}}List
          accountId={1}
        />
      </>
 *
 * @param props
 */
export const {{$obj->upperCamel()}}List: FC<IProps> = (props: IProps) => {
  const subscribeUpdateKey = '{{$obj}}.updated';
  const { subscribe, publish } = useContext(DefaultPubSubContext);
  const { accountId } = props;
  const [page, setPage] = useState(1);
  const [responsePagination, setResponsePagination] = useState<null | IResponsePagination<I{{$mod->upperCamel()}}>>(
    null,
  );

  const [createDialogVisible, setCreateDialogVisible] = useState(false);
  const [editDialogVisible, setEditDialogVisible] = useState(false);
  const [current{{$obj->upperCamel()}}, setCurrent{{$obj->upperCamel()}}] = useState<null | I{{$obj->upperCamel()}}>(null);

  const fieldRender = function(_text: string, {{$obj}}: I{{$obj->upperCamel()}}) {
    const title = `Sure to delete id = ${ {{$obj}}.id } ?`;
    return (
      <>
        <a onClick={() => openEditDialog({{$obj}})}>Edit</a>
        <Divider type="vertical" />
        <Popconfirm title={title} onConfirm={() => delete{{$obj->upperCamel()}}({{$obj}}.id)}>
          <a>Delete</a>
        </Popconfirm>
      </>
    );
  };

  async function delete{{$obj->upperCamel()}}({{$obj}}Id: number) {
    try {
      await {{$obj->upperCamel()}}Service.delete{{$obj->upperCamel()}}({
        accountId: accountId,
        {{$obj}}Id: {{$obj}}Id,
      });
      message.success('{{$obj}} has been delete!');
      publish(subscribeUpdateKey);
    } catch (error) {
      throw error;
    }
  }

  function openCreateDialog() {
    setCreateDialogVisible(true);
  }

  function openEditDialog({{$obj}}: I{{$obj->upperCamel()}}) {
    setEditDialogVisible(true);
    setCurrent{{$obj->upperCamel()}}({{$obj}});
  }

  useEffect(() => {
    fetchData(accountId, page);
    const callback = fetchData.bind(null, accountId, page);
    const unsub = subscribe(subscribeUpdateKey, callback);
    return unsub;
  }, [accountId, page]);

  /**
   * @param accountId 
   * @param page 
   */
  async function fetchData(accountId: number, page: number) {
    if (!accountId) {
      return;
    }

    const response = await fetchByApi(accountId, page);
    setResponsePagination(response);
  }

  async function fetchByApi(accountId: number, page: number) {
    const result = await {{$obj->upperCamel()}}Service.get{{$mod->upperCamel()}}({
      accountId,
      params: {
        page: page || 1,
      },
    });

    return result;
  }

  return (
    <>
      <Card
        title="{{$mod->upperCamel()}}"
        extra={
          <Button type="primary" onClick={() => openCreateDialog()}>
            Create
          </Button>
        }
      >

        <{{$obj->upperCamel()}}ListTable
          page={page}
          setPage={setPage}
          responsePagination={responsePagination}
          lastFieldRender={fieldRender}
        />

        {createDialogVisible && (
          <Modal
            title="Create {{$obj->upperCamel()}}"
            visible={createDialogVisible}
            width={600}
            onCancel={() => setCreateDialogVisible(false)}
            footer={null}
          >
            <{{$obj->upperCamel()}}CreateForm onSubmit={() => setCreateDialogVisible(false)} />
          </Modal>
        )}

        {editDialogVisible && (
          <Modal
            title="Edit {{$obj->upperCamel()}}"
            visible={editDialogVisible}
            width={600}
            onCancel={() => setEditDialogVisible(false)}
            footer={null}
          >
            <{{$obj->upperCamel()}}UpdateForm
              current{{$obj->upperCamel()}}={current{{$obj->upperCamel()}}}
              onSubmit={() => setEditDialogVisible(false)}
            />
          </Modal>
        )}
      </Card>
    </>
  );
};
