import React, { useState, useEffect } from 'react';
import { Spin } from 'antd';
import { ActionService, Action } from '@onr/action';

interface IProps {
  currentAction: Action;
  emailTemplateId: BigInteger;
  emailVariables: Object;
}

/**
 * preview theme
 *    - get API
 *    - preview HTML content
 *
 * example
 *    <>
 *      <Modal
 *        title="Theme Preview"
 *        width={800}
 *        footer={null}
 *      >
 *        <>
 *          {previewVisible && (
 *            <UseEmailTemplatePreviewSection
 *              currentAction={currentAction}
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
export const UseEmailTemplatePreviewSection: React.FC<IProps> = (props: IProps) => {
  const action = props.currentAction;
  const emailTemplateId = props.emailTemplateId;
  const emailVariables = props.emailVariables;
  const [previewContent, setPreviewContent] = useState('');

  useEffect(() => {
    fetchData(action.id);
  }, [action.id]);

  async function fetchData(actionId: number) {
    setPreviewContent(await fetchByApi(actionId));
  }

  async function fetchByApi(actionId: number): string {
    const result = await ActionService.getActionRenderThemeVariables({
      params: {
        actionId,
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
