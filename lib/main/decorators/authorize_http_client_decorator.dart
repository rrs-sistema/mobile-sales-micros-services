import './../../data/cache/cache.dart';
import './../../data/http/http.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final DeleteSecureCacheStorage deleteSecureCacheStorage;
  final HttpClient decoratee;

  AuthorizeHttpClientDecorator({
    required this.fetchSecureCacheStorage,
    required this.deleteSecureCacheStorage,
    required this.decoratee,
  });

  Future<dynamic> request({
    required String url, 
    required String method,
    Map? body,
    Map? headers,
  }) async {
    try {
      final accessToken = await fetchSecureCacheStorage.fetch('accessToken');
      final authorizedHeaders = headers ?? {}..addAll({'Authorization': accessToken});
      return await decoratee.request(url: url, method: method, body: body, headers: authorizedHeaders);
    } catch(error) {
      if (error is HttpError && error != HttpError.forbidden) {
        rethrow;
      } else {
        await deleteSecureCacheStorage.delete('accessToken');
        throw HttpError.forbidden;
      }
    }
  }
}