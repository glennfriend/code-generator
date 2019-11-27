import React, { MouseEvent } from 'react';
import { Form, Checkbox, Button, Input, Select, Modal } from 'antd';
import { FormComponentProps } from 'antd/lib/form';
import { {{$obj->upperCamel()}}Service, I{{$obj->upperCamel()}} } from '@onr/asset';

interface IProps extends FormComponentProps {
  current{{$obj->upperCamel()}}: I{{$obj->upperCamel()}};
  handleSubmit(asset: I{{$obj->upperCamel()}}): void;
}

const layout = {
  form: {
    labelCol: { span: 6 },
    wrapperCol: { span: 18 },
  },
  submit: {
    wrapperCol: { span: 12, offset: 6 },
  },
};

const Component: React.FC<IProps> = ({ form, handleSubmit, current{{$obj->upperCamel()}} }: IProps) => {
  const { getFieldDecorator, getFieldValue, setFieldsValue } = form;

  const onSubmit = (e: MouseEvent) => {
    e.preventDefault();

    form.validateFields(async (err, values) => {
      if (err) {
        return;
      }
      console.log('Received values of form: ', values);

      handleSubmit(values.asset);
      form.resetFields();
    });
  };

  return (
    <>
      <Form {...layout.form} onSubmit={onSubmit}>

        <Form.Item label="Name" hasFeedback>
          ....
          ....
          ....
        </Form.Item>

        <Form.Item {...layout.submit}>
          <Button type="primary" htmlType="submit">
            Submit
          </Button>
        </Form.Item>
      </Form>
    </>
  );
};

export const {{$obj->upperCamel()}}Form = Form.create<IProps>()(Component);
