import React, { useState } from 'react';
import { Button, Table, Modal } from 'antd';
import { {{$obj->upperCamel()}}ShowContentSection } from '@onr/{{$obj}}/components/{{$obj->upperCamel()}}ShowContentSection';

interface IConfig {
  readonly pageSize?: number;
}

/**
 * show content
 *
 * example
      <>
        <Form.Item label="Show Content">
          <{{$obj->upperCamel()}}ShowContentSection
            pageSize={10}
          />
        </Form.Item>
      </>
 *
 */
export const {{$obj->upperCamel()}}ShowContentSection: React.FC<IConfig> = (config: IConfig) => {
  const { pageSize = 20 } = config;
  const [visible, setVisible] = useState(false);

  const getDataSources = function() {
    const rows = [
      {
        name: 'zipcode',
        description: 'Zipcode',
      },
      {
        name: 'first_name',
        description: 'First Name',
      },
      {
        name: 'last_name',
        description: 'Last Name',
      },
      {
        name: 'email',
        description: 'Email',
      },
    ];

    return rows.map(function(item, index) {
      return {
        ...item,
        key: index,
      };
    });
  };

  const columns = [
    {
      title: 'Name',
      dataIndex: 'name',
      key: 'name',
    },
    {
      title: 'Description',
      dataIndex: 'description',
      key: 'description',
    },
  ];

  enum Position {
    bottom = 'bottom',
    top = 'top',
    both = 'both',
  }

  return (
    <>
      <Button onClick={() => setVisible(true)}>Show Content</Button>

      <Modal
        title="Show Content"
        width={800}
        visible={visible}
        onCancel={() => setVisible(false)}
        footer={null}
      >
        <>
          {visible && (
            <Table
              dataSource={getDataSources()}
              columns={columns}
              pagination={{
                size: 'middle',
                pageSize: pageSize,
                total: getDataSources().length,
                position: Position.bottom,
                showTotal: (total, range) => `${range[0]}-${range[1]} of ${total} contacts`,
              }}
              loading={false}
              size="small"
            />
          )}
        </>
      </Modal>
    </>
  );
};
