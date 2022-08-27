

目前的做法不打算建立 元件界面的 component 
偏向使用 DataGutter 或是 custom hook


////// 以下不再使用 //////


import {Select} from 'antd';
import React from 'react';
import {OptionsType} from "rc-select/lib/interface";
import {FieldProps} from "rc-field-form/lib/Field";

interface CustomOption {
  label: string;
  value: any;
}

interface {{$obj->upperCamel()}}SelectSectionProps {
  customFieldProps: FieldProps;         // for Form.Item
  options: OptionsType | undefined;     // for external json data    // XxxxxResponse;
  disabled?: boolean;
  hidden?: boolean;
}

/**
 * {{$obj->upperCamel()}}SelectSection
 *    - Select smart component
 *    - include Form.Item
 *
 * example
 *
 *    <Form.Item name="{{$obj}}Id" label="{{$obj->upperCamel()}}" required>
 *      <{{$obj->upperCamel()}}SelectSection
 *        options={stateArrayData}
 *        disabled={false}
 *        hidden={false}
 *        customFieldProps={{
 *          name: 'userId',
 *          label: "{{$obj->upperCamel()}}",
 *          rules: [{required: true, message: 'required !'}],
 *        }}
 *       />
 *    </Form.Item>
 *
 */
export const {{$obj->upperCamel()}}SelectSection = (props: {{$obj->upperCamel()}}SelectSectionProps) => {
  const {options, customFieldProps} = props;
  const {disabled = false} = props;
  const {hidden = false} = props;
  const style = {
    base: {},
    hidden: (hidden ? {display: 'none'} : {}),
  };

  // 外部的資料可能來自 API
  const parseExternalOptions = options?.data
    .filter(function (item: any) {
      return item.name.substr(0, 4) !== 'test';       // 過濾掉開頭為 test
    }).map(({name, id}) => ({
      label: `${name} (id: ${id})`,
      value: id,
    }))
    .sort((a, z) => z.label.localeCompare(a.label))   // custom sort Z to A
    // .reverse()
  ;
  // if (typeof (parseExternalOptions) !== 'undefined') {
  //   console.log(parseExternalOptions)
  // }



  return (
    <Form.Item {...customFieldProps} >
      <Select
        showSearch
        // mode="multiple"
        filterOption={(input, option) => {
          const customOption = option as CustomOption;
          if (!customOption) {
            return false;
          }
          return customOption?.label?.toLowerCase().indexOf(input.toLowerCase()) >= 0;  // 在 label 中搜尋
        }}
        //
        style={{ ...style.base,...style.hidden }}
        disabled={disabled}
        options={parseExternalOptions}
        
      />
    </Form.Item>
  );
};


// 外部的資料可能來自 API
function parseExternalOptions(options: OptionsType | undefined): CustomOption[] {
  if (!options) {
    return [];
  }
  return options.map(x => ({
    label: x.campaignName,
    value: x.campaignId,
  }));
}

// custom sort Z to A
function sortZA(items: any[]) {
  return items.sort((a, z) => z.label.localeCompare(a.label));
}




////// 以下是舊的 //////




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
