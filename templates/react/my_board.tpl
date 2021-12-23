import {Badge, Card, Radio} from "antd";
import React, {useEffect, useState} from "react";

interface IProps {
  title: string;
  // useState
  onItemsChange: ([]) => {};
  onTypeChange: (typeId: number) => void;
}

export const ____Board: React.FC<IProps> = props => {

  const {onItemsChange, onTypeChange} = props;

  useEffect(() => {
    // onItemsChange([]);
    // onTypeChange(1);
  }, []);

  return (
    <Card type="inner" title={title}>

    </Card>
  )
};
