未修改

import React from 'react';
import {Select} from 'antd';
import {SelectProps} from 'antd/lib/select';
import styled from 'styled-components';

const SelectStyled = styled(Select)`
  .ant-select-selection-item {
    min-width: 100px;
  }
`;

interface IProps extends SelectProps<any> {
  source?: [];
}

interface ISelectOption {
  value: string,
  key: string,
  name: string,
}

const parseOptionsValues = function (rows: ISelectOption[]) {
  let result: [] = [];
  rows.map(function (item: [], index: string) {
    const value: string = _matchValue(item) ?? '';
    const name: string = _matchName(item) ?? index;
    const optionKey = `Select_${value}_${index}`;
    result.push({
      "value": value,
      "key": optionKey,
      "name": name,
    });
  });
  return result;
}

const parseMaxNameLength = function (rows: []): number {
  let length = 0;
  rows.map(function (item: []) {
    const name: string = _matchName(item);
    if (name.length > length) {
      length = name.length;
    }
  });
  return length;
}

const _matchName = function (rows: []) {
  if (rows['name']) {
    return rows['name'];
  } else if (rows['description']) {
    return rows['description'];
  }
  for (const key in rows) {
    if (key.match("name")) {
      return rows[key];
    }
  }
  return null;
};

const _matchValue = function (rows: []) {
  if (rows['value']) {
    return rows['value'];
  }
  for (const key in rows) {
    if (key.match("value")) {
      return rows[key];
    } else if (key.match("key")) {
      return rows[key];
    }
  }
  return null;
};

export const CampaignSelect: React.FC<IProps> = props => {

  const {source} = props;
  const maxNameLength: number = parseMaxNameLength(source);
  const space = '\xa0';
  const spaces = Array(maxNameLength).fill(space).join('');
  const defaultOptionName = '------ Select One ------ ' + spaces

  let optionsValues: ISelectOption[] = parseOptionsValues(source);
  optionsValues = [{name: defaultOptionName, key: "", value: ""}, ...optionsValues];

  return (
    <SelectStyled {...props}>
      {optionsValues.map(function (row: []) {
        const {value, key, name} = row;
        const title = '(' + value + ') ' + name;
        return (
          <Select.Option value={value} key={key} title={title}>{name}</Select.Option>
        );
      })}
    </SelectStyled>
  );
};
