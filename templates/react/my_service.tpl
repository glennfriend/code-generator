import { Http } from '@onr/core';
import { AssetModel, IAsset } from '@onr/asset';

// 未修改 !!!!!!!!!

export const AssetService = {
  /**
   *
   */
  getAssets: async (payload: AssetModel.IGetPayload): Promise<AssetModel.IGetResponse> => {
    let response: AssetModel.IGetResponse;

    try {
      response = await Http.request<AssetModel.IGetResponse>(
        'GET',
        `/accounts/${payload.accountId}/assets/`,
        payload.params,
      );
    } catch (error) {
      console.log(error);
      throw new Error(`[AssetService] getAssets Error: ${JSON.stringify(error)}`);
    }

    return response;
  },

  /**
   *
   */
  createAsset: async (payload: {
    accountId: number;
    data: any;
  }): Promise<AssetModel.IGetResponse> => {
    let response: AssetModel.IGetResponse;

    try {
      response = await Http.request<AssetModel.IGetResponse>(
        'POST',
        `/accounts/${payload.accountId}/assets`,
        {},
        payload.data,
      );
    } catch (error) {
      console.log(error);
      throw new Error(`[AssetService] createAsset Error: ${JSON.stringify(error)}`);
    }

    return response;
  },

  /**
   *
   */
  updateAsset: async (payload: {
    assetId: number;
    accountId: number;
    data: any;
  }): Promise<AssetModel.IGetResponse> => {
    let response: AssetModel.IGetResponse;

    try {
      response = await Http.request<AssetModel.IGetResponse>(
        'PATCH',
        `/accounts/${payload.accountId}/assets/${payload.assetId}`,
        {},
        payload.data,
      );
    } catch (error) {
      console.log(error);
      throw new Error(`[AssetService] updateAsset Error: ${JSON.stringify(error)}`);
    }

    return response;
  },

  /**
   *
   */
  deleteAsset: async (payload: any): Promise<any> => {
    let response: any;

    try {
      response = await Http.request<any>(
        'DELETE',
        `/accounts/${payload.accountId}/assets/${payload.assetId}`,
        {},
      );
    } catch (error) {
      console.log(error);
      throw new Error(`[AssetService] deleteAsset Error: ${JSON.stringify(error)}`);
    }

    return response;
  },
};
