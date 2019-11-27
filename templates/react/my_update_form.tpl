import React, { useContext } from 'react';
import { message } from 'antd';
import { useAppState, DefaultPubSubContext } from '@onr/core';
import { {{$obj->upperCamel()}}Form, {{$obj->upperCamel()}}Service, I{{$obj->upperCamel()}} } from '@onr/{{$obj->lower('_')}}';

interface IProps {
  current{{$obj->upperCamel()}}: I{{$obj->upperCamel()}};
  onSubmit(): void;
}

export const {{$obj->upperCamel()}}UpdateForm: React.FC<IProps> = ({ onSubmit, current{{$obj->upperCamel()}} }: IProps) => {
  const subscribeUpdateKey = '{{$obj}}.updated';
  const [state] = useAppState();
  const { publish } = useContext(DefaultPubSubContext);





  async function handleSubmit({{$obj}}: I{{$obj->upperCamel()}}) {
    await {{$obj->upperCamel()}}Service.update{{$obj->upperCamel()}}({
      accountId: state.accountId,
      {{$obj}}Id: current{{$obj->upperCamel()}}.id,
      data: {{$obj}},
    });

    message.info(`{{$obj->upperCamel()}} ${ {{$obj}}.name } created`);
    publish(subscribeUpdateKey);

    if (onSubmit) {
      onSubmit();
    }
  }

  return <{{$obj->upperCamel()}}Form current{{$obj->upperCamel()}}={current{{$obj->upperCamel()}}} handleSubmit={handleSubmit} />;
};
