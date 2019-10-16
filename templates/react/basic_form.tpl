import React, { useState } from 'react';
import { Form, Input, Checkbox, Button } from 'antd';
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
  const { MyLinks = [] } = props;
  const { getFieldDecorator } = form;
  const config = current{{$obj->upperCamel()}}.config || {};

  return (
    <>
{{foreach $tab as $key => $field}}
{{if $key=='id'}}
{{elseif $key=='properties' || $key=='attribs'}}
{{elseif $field.ado->name=='status'}}
{{elseif $field.ado->type=='int' || $field.ado->type=='tinyint'}}
{{elseif $field.ado->type=='varchar' || $field.ado->type=='char'}}
      <Form.Item label="{{$field.name->upperCamel(' ')}}" hasFeedback>
        {getFieldDecorator('{{$obj}}.{{$key}}', {
          rules: [{ required: true, message: 'Please input !' }],
          initialValue: current{{$obj->upperCamel()}}.{{$key}},
        })(<Input style={{ width: 300 }} />)}
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
