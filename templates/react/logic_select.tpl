import React, { useState, useEffect } from 'react';
import { Select, Spin, Tooltip } from 'antd';
import { FormComponentProps } from 'antd/lib/form';
import { {{$obj->upperCamel()}}Service } from '@onr/{{$obj->lower('-')}}';

interface IProps extends FormComponentProps {
  fieldDecorator: object;
  disabled: boolean;
}

/**
 * {{$obj->upperCamel()}} Select smart component
 *
 * example
 *
 *  const fieldDecorator = getFieldDecorator('{{$obj}}.id', 
 *  {
 *    rules: [{
 *      required: true,
 *      message: 'Please select one !'
 *    }],
 *    initialValue: current{{$obj->upperCamel()}}.id,
 *  });
 * 
 *  return (
 *    <>
 *      <Form.Item label="{{$obj->upperCamel(' ')}}" hasFeedback>
 *        <{{$obj->upperCamel()}}SelectSection
 *          fieldDecorator={fieldDecorator}
 *          disabled={false}
 *        />
 *      </Form.Item>
 *    </>
 *  );
 *
 */
export const {{$obj->upperCamel()}}SelectSection: React.FC<IProps> = ({
  form,
  fieldDecorator = {},
  disabled = false,
}: IProps) => {
  const { getFieldDecorator } = form;
  const [items, setItems] = useState([]);

  // fetch data
  (function() {
    useEffect(() => {
      fetchData();
    }, []);

    async function fetchData() {
      setItems(await retrieveData());
    }

    async function retrieveData() {
      const result = await {{$obj->upperCamel()}}Service.get{{$mod->upperCamel()}}({
        accountId: xxxxxx.accountId,
      });

      return result.data;
    }
  })();

  return (
    <>
      {fieldDecorator(
        <Select
          style={{ width: 200 }}
          showSearch
          disabled={disabled}
          placeholder="Select an {{$obj->upperCamel(' ')}}"
          notFoundContent={items ? <Spin size="small" /> : null}
          optionFilterProp="children"
          filterOption={function(input, option) {
            // console.log(option.props.children.toString().toLowerCase().indexOf(input.toLowerCase()) >= 0);
            // console.log(option.props.children.props.title.indexOf(input) >= 0);
            return option.props.children.props.title.indexOf(input) >= 0;
          }}
        >
          {items.map(option => (
            <Select.Option key={option.id} value={option.id}>
              <Tooltip placement="right" title={option.note ? option.note : null}>
                <div>{option.name}</div>
              </Tooltip>
            </Select.Option>
          ))}
        </Select>,
      )}
    </>
  );
};
