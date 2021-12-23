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
      console.error(`[AssetService]: ${error.message}`);
      throw error;
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
      console.error(`[AssetService]: ${error.message}`);
      throw error;
    }

    return response;
  },

  /**
   *
   */
  createAsset: async (payload: any): Promise<AssetModel.IGetResponse> => {
    try {
      const response = await fetch(`/api/accounts/${payload.accountId}/asset`, {
        method: 'POST',
        body: JSON.stringify(payload.data),
        headers: new Headers({
          'Content-Type': 'application/json'
        }),
      });
      if (!response.ok) {
        throw new Error('[AssetService] response failed');
      }
      return response.json();

    } catch (error) {
      console.error(`[AssetService]: ${error.message}`);
      throw error;
    }
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
      console.error(`[AssetService]: ${error.message}`);
      throw error;
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
      console.error(`[AssetService]: ${error.message}`);
      throw error;
    }

    return response;
  },
};









/*
interface IDemoApiServicePayload {
  id: string;
};

export interface ICampaign {
  id: number;
  name: string;
  status: string;
  created_at: ???;
}

interface ICampaignResponse {
  data: ICampaign[];
}
*/

export class DemoApiService {

  /**
   * example
   *    const jsonData = await DemoApiService.getItems();
   */
  static async queryApi() {
    const payload = {
      id: 'owenvoke',
    }

    try {
      // const response = await fetch(`https://api.github.com/users/owenvoke`);
      const response = await fetch(`https://api.github.com/users/${payload.id}`);
      if (!response.ok) {
        throw new Error('response query failed');
      }

      return response.json();

    } catch (error) {
      console.error(`fetch failed message: ${error.message}`);
      throw error;
    }
  }

  static async getUser() {
    return {
      "login": "owenvoke",
      "id": 1899334,
      "node_id": "MDQ6VXNlcjE4OTkzMzQ=",
      "avatar_url": "https://avatars.githubusercontent.com/u/1899334?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/owenvoke",
      "html_url": "https://github.com/owenvoke",
      "followers_url": "https://api.github.com/users/owenvoke/followers",
      "following_url": "https://api.github.com/users/owenvoke/following{/other_user}",
      "gists_url": "https://api.github.com/users/owenvoke/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/owenvoke/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/owenvoke/subscriptions",
      "organizations_url": "https://api.github.com/users/owenvoke/orgs",
      "repos_url": "https://api.github.com/users/owenvoke/repos",
      "events_url": "https://api.github.com/users/owenvoke/events{/privacy}",
      "received_events_url": "https://api.github.com/users/owenvoke/received_events",
      "type": "User",
      "site_admin": false,
      "name": "Owen Voke",
      "company": "Cylix Limited",
      "blog": "https://voke.dev",
      "location": "Bristol, UK",
      "email": null,
      "hireable": null,
      "bio": "Web Developer at Cylix Limited. Maintainer for @laravel-zero, @tldr-pages, @pestphp, and more.\r\n",
      "twitter_username": "owenvoke",
      "public_repos": 391,
      "public_gists": 23,
      "followers": 142,
      "following": 0,
      "created_at": "2012-06-27T16:20:08Z",
      "updated_at": "2021-09-25T09:50:15Z"
    };
  }

  static async getItems(count?: number) {
    count = count || 15;
    const isPrimeNumber = (num: number) => {
      for (let i = 2, s = Math.sqrt(num); i <= s; i++)
        if (num % i === 0) return false;
      return num > 1;
    }

    return Array.from({length: count}, function (_, i) {
        i++;
        const min = 1
        const max = 9999
        const number = (Math.floor(Math.random() * (max - min + 1)) + min);
        return {
          "item_id": i,
          "item_name": "fake " + i + "." + number,
          "is_prime": isPrimeNumber(i),
          "type": (i % 2 == 0 ? 'even' : 'odd'),
        }
      }
    );
  }

  static async getItemValues(itemId: number) {
    return Array.from({length: (itemId % 5)}, function (_, i) {
        return {
          "linkId": itemId,
          "name": "fake link value " + (i + 1),
          "value": parseInt(itemId.toString() + ((i + 1) * 2).toString()),
        }
      }
    );
  }

}
