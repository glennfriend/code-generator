import React, { useState, useEffect } from 'react';
import { Spin } from 'antd';
import { {{$obj->upperCamel()}}Service, {{$obj->upperCamel()}} } from '@onr/{{$obj->lower('-')}}';

interface IProps {
  current{{$obj->upperCamel()}}: {{$obj->upperCamel()}};
  emailTemplateId: number;
  emailVariables: object;
}

/**
 * preview theme
 *    - get API
 *    - preview HTML content
 *
 * example
 *    <>
 *      <Modal
 *        title="Show Contents"
 *        width={800}
 *        footer={null}
 *      >
 *        <>
 *          {previewVisible && (
 *            <{{$obj->upperCamel()}}ShowContentSection
 *              current{{$obj->upperCamel()}}={current{{$obj->upperCamel()}}}
 *              emailTemplateId={current_email_template_id}
 *              emailVariables={current_email_variables_json_format}
 *            />
 *          )}
 *        </>
 *      </Modal>
 *    </>
 *
 * @param props
 */
export const {{$obj->upperCamel()}}ShowContentSection: React.FC<IProps> = (props: IProps) => {
  const {{$obj}} = props.current{{$obj->upperCamel()}};
  const emailTemplateId = props.emailTemplateId;
  const emailVariables = props.emailVariables;
  const [previewContent, setPreviewContent] = useState('');

  useEffect(() => {
    fetchData({{$obj}}.id);
  }, [{{$obj}}.id]);

  async function fetchData({{$obj}}Id: number) {
    setPreviewContent(await fetchByApi({{$obj}}Id));
  }

  async function fetchByApi({{$obj}}Id: number): string {
    const result = await {{$obj->upperCamel()}}Service.get______({
      params: {
        {{$obj}}Id,
      },
      data: {
        email_template_id: emailTemplateId,
        email_variables: emailVariables,
      },
    });

    return result.data;
  }

  return (
    <>
      {!previewContent && <Spin />}
      {previewContent && <div dangerouslySetInnerHTML={{ __html: previewContent }}></div>}
    </>
  );
};
