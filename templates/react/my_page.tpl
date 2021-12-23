/*
    Page 裡面包含
        call API
        資整整合
        將要處理的資料往 Board 丟, Board 處理完就傳回 Page
        把 Board 想像成完全被包在 Page 裡面出不去, 只能做自己裡面的事, 不能跨越權限做 Page 的事

    檔案命名
        ____Board   大區塊, 在 Panel, Option 之上, 必須有顯示內容
        ____Panel   使用者可以選擇條件選項, 橫型板子
        ____Option  一般選項
        ____Form    一整個表單
*/
import React, {useEffect, useState} from "react";
import {Button, Card, Col, Form, message, Row, Spin} from "antd";
import { {{$obj->upperCamel()}}Board } from "../components/功能A";
import { {{$obj->upperCamel()}}ApiService } from "../services";
import { __useAppState } from '@onr/core';
import { __{{$obj->upperCamel()}}Section } from '@onr/{{$obj->lower('_')}}';


export const {{$obj->upperCamel()}}Page: React.FC = () => {
  const [query{{$obj->upperCamel()}}Data, setQuery{{$obj->upperCamel()}}Data] = useState<any[]>([]);
  const [loading,     setLoading]     = useState<true | false>(false);
  const [assetType,   setAssetType]   = useState<number>();
  const [assetItems,  setAssetItems]  = useState<any[]>([]);
  
  useEffect(() => {
    loadApi();
  }, []);

  const loadApi = async () => {
    try {
      setLoading(true);
      const jsonData = await {{$obj->upperCamel()}}ApiService.get();
      await setQuery{{$obj->upperCamel()}}Data(jsonData);
    } catch {
      message.error('failed to load content');
    } finally {
      setLoading(false);
    }
  }

  const targetData = {
    assetType,
    AssetItems,
  };

  const handleFinish = (values: any) => {
    // console.log('Success:', values);
    console.log(JSON.stringify(targetData, null, 2));
    const jsonData = {{$obj->upperCamel()}}ApiService.create(targetData.get());
    console.log(jsonData);
  };

  const handleFinishFailed = (errorInfo: any) => {
    console.log('Failed:', errorInfo);
  };

  return (
    <>
      <Card title="{{$obj->upperCamel()}} Page">

        <pre style={{ldelim}}maxHeight: 300{{rdelim}}>
          {JSON.stringify(targetData, null, 2)}
        </pre>

        <Spin spinning={loading} tip="Loading...">
          <Row>
            <Col span={24}>
              <{{$obj->upperCamel()}}Board
                rowData={query{{$obj->upperCamel()}}Data}
                onAssetItemsChange={setAssetItems}
                onAssetTypeChange={setAssetType}
              ></{{$obj->upperCamel()}}Board>
            </Col>
          </Row>
        </Spin>

        <Form
          onFinish={handleFinish}
          onFinishFailed={handleFinishFailed}
          initialValues={{ldelim}}remember: true{{rdelim}}
          autoComplete="off"
        >
          <Button type="primary" htmlType="submit">
            Submit
          </Button>
        </Form>

        <span>
          {targetData.console()}
        </span>

      </Card>
    </>
  )

};


/*
  const query____Data = useRef([]);
  const setQuery____Data = async function () {

    const jsonData = await ____Service.get(jsonData.data.id);
    if (!jsonData) {
      return;
    }

    query____Data.current = jsonData;
  };

  <Board
    rowData={query____Data.current}
  ></Board>
*/