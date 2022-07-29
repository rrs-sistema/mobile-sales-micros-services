import 'package:meta/meta.dart';

import './../../data/cache/cache.dart';
import './../../data/http/http.dart';

class AuthorizeHttpClientDecorator implements HttpClient{
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final HttpClient decoratee;

  AuthorizeHttpClientDecorator(
      {@required this.fetchSecureCacheStorage, @required this.decoratee});

  Future<dynamic> request({@required Uri uri, @required String method, Map body, Map headers}) async {
    try {
      final accessToken = await fetchSecureCacheStorage.fetchSecure('accessToken');
      final authorizadHeaders = headers ?? {}..addAll({'Authorization': accessToken});
      return await decoratee.request(uri: uri, method: method, body: body, headers: authorizadHeaders);      
    } on HttpError {
      rethrow;
    } catch (error) {
      throw HttpError.forbidden;
    }
  }
}