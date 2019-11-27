import React, { useContext } from 'react';
import { message } from 'antd';
import { useAppState, DefaultPubSubContext } from '@onr/core';
import { {{$obj->upperCamel()}}Form, {{$obj->upperCamel()}}Service, I{{$obj->upperCamel()}} } from '@onr/{{$obj->lower('_')}}';

interface IProps {
  onSubmit(): void;
}


export const {{$obj->upperCamel()}}CreateForm: React.FC<IProps> = ({ onSubmit }: IProps) => {
  const subscribeUpdateKey = '{{$obj}}.updated';
  const [state] = useAppState();
  const { publish } = useContext(DefaultPubSubContext);

  const current{{$obj->upperCamel()}}: I{{$obj->upperCamel()}} = {
    // config: {},
  };

  async function handleSubmit({{$obj}}: I{{$obj->upperCamel()}}) {
    await {{$obj->upperCamel()}}Service.create{{$obj->upperCamel()}}({
      accountId: state.accountId,
      data: {{$obj}},
    });


    message.info(`{{$obj->upperCamel()}} ${ {{$obj}}.name } updated`);
    publish(subscribeUpdateKey);

    if (onSubmit) {
      onSubmit();
    }
  }

  return <{{$obj->upperCamel()}}Form current{{$obj->upperCamel()}}={current{{$obj->upperCamel()}}} handleSubmit={handleSubmit} />;
};
