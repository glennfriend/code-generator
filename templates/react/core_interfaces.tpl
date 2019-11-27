/**
 * a laravel response
 * rows data + links + pagination meta data
 */
export interface IResponsePagination<T> {
  data?: T | array;
  links?: {
    first?: string;
    last?: string;
    prev?: string;
    next?: string;
  };
  meta?: {
    current_page: number;
    from: number;
    last_page: number;
    path: string;
    per_page: number;
    to: number;
    total: number;
  };
}
