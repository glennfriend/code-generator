import React, { useState, useEffect } from 'react';
import { Form, Checkbox, Button, Input, Select, Modal } from 'antd';
import { FormComponentProps } from 'antd/lib/form';
import { {{$obj->upperCamel()}}, {{$obj->upperCamel()}}Service } from '@onr/{{$obj}}';

// import { NextSection } from './NextSection';

interface IProps extends FormComponentProps {
  current{{$obj->upperCamel()}}: {{$obj->upperCamel()}};
}

// export function {{$obj->upperCamel()}}Section(props) {
// }

export const {{$obj->upperCamel()}}Section: React.FC<IProps> = (props: IProps) => {

  const { current{{$obj->upperCamel()}} = {}, form } = props;
  const { getFieldDecorator, getFieldValue, setFieldsValue } = form;
  const config = current{{$obj->upperCamel()}}.config || {};
  const { MyLinks = [] } = props;



  /**
   * assign data
   */
  (function() {
{{foreach $tab as $key => $field}}
{{if $key=='id'}}
{{elseif $field.ado->type=='tinyint'}}
{{elseif $field.ado->type=='varchar' || $field.ado->type=='char'}}
    // change to tinyint
    const all{{$field.name->upperCamel(' ')}} = [
      { id: '1', option: 'data_1' },
      { id: '2', option: 'data_2' },
    ];

{{else}}
{{/if}}
{{/foreach}}
  })();


  return (
    <>
{{foreach $tab as $key => $field}}
{{if $key=='id'}}
{{elseif $key=='properties' || $key=='attribs'}}
{{elseif $field.ado->name=='status'}}
      // status

{{elseif $field.ado->type=='int'}}
      // int

{{elseif $field.ado->type=='tinyint'}}
      // tinyint

{{elseif $field.ado->type=='varchar' || $field.ado->type=='char'}}
      <Form.Item label="{{$field.name->upperCamel(' ')}}" hasFeedback>
        {getFieldDecorator('{{$obj}}.{{$key}}', {
          rules: [{ required: true, message: 'Please input !' }],
          initialValue: current{{$obj->upperCamel()}}.{{$key}},
        })(<Input style={{ width: 300 }} />)}
      </Form.Item>

      // change to tinyint
      <Form.Item label="{{$field.name->upperCamel(' ')}}" hasFeedback>
        {getFieldDecorator('{{$obj}}.{{$key}}', {
          initialValue: current{{$obj->upperCamel()}}.{{$key}},
        })(
          <Select style={{ width: 200 }}>
            {all{{$field.name->upperCamel(' ')}}.map(function(data) {
              return <Select.Option key={data.id}>{data.option}</Select.Option>;
            })}
          </Select>,
        )}
      </Form.Item>

{{elseif $field.ado->type=='text' || $field.ado->type=='mediumtext' || $field.ado->type=='json'}}
      <Form.Item label="{{$field.name->upperCamel(' ')}}" hasFeedback>
        {getFieldDecorator('{{$obj}}.{{$key}}', {
          rules: [{ required: false }],
          initialValue: current{{$obj->upperCamel()}}.{{$key}},
        })(<Input.TextArea style={{ width: 400, height: 50 }} />)}
      </Form.Item>

{{else}}
{{/if}}
{{/foreach}}

      <NextSection currentAction={current{{$obj->upperCamel()}}} form={form} />
    </>
  );

};