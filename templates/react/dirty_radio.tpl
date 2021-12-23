import {Badge, Card, Radio} from "antd";
import React, {useEffect, useState} from "react";
import {AgGridColumnGroupProps, AgGridColumnProps} from 'ag-grid-react';
import {AgGrid} from "../agGrid";
import {SelectionChangedEvent, ValueGetterParams} from "ag-grid-community";

export enum AllType {
  ALL_ITEMS = 1,
  CHOOSE_ITEMS = 2,
}

interface IProps {
  // useState
  onTypeChange: (typeId: number) => void;
  type: AllType;
}

export const ____Board: React.FC<IProps> = props => {

  const typeDefaultValue = AllType.ALL_ITEMS;
  const {onTypeChange, type = typeDefaultValue} = props;

  useEffect(() => {
    //
  }, []);

  const handleRadioChange = (event: any) => {
    const changeValue = event.target.value;
    onTypeChange(changeValue);
  }

  return (
    <Card>

      <Radio.Group defaultValue={type} onChange={handleRadioChange}
                   buttonStyle={"solid"} optionType={"button"}>
        <Radio value={AllType.ALL_ITEMS}    >type 1</Radio>
        <Radio value={AllType.CHOOSE_ITEMS} >type 2</Radio>
      </Radio.Group>

      <div style={{ldelim}}display: ChooseOne === AllType.ALL_ITEMS ? 'block' : 'none'{{rdelim}}>
        <Card style={{ldelim}}width: 300{{rdelim}}>
          <p>Choose 1</p>
        </Card>
      </div>
      <div style={{ldelim}}display: ChooseOne === AllType.CHOOSE_ITEMS ? 'block' : 'none'{{rdelim}}>
        <Card style={{ldelim}}width: 300{{rdelim}}>
          <p>Choose 2</p>
        </Card>
      </div>

    </Card>
  )
};
