import React, { FC } from 'react';
import { useAppState } from '@onr/core';
import { {{$obj->upperCamel()}}ListSection } from '@onr/{{$obj->lower('_')}}';

export const AssetPage: FC = () => {
  const [state] = useAppState();

  return (
    <>
      <{{$obj->upperCamel()}}List accountId={state.accountId} />
    </>
  );
};