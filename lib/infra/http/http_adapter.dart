import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import '../../data/http/http.dart';

class HttpAdapter<ResponseType> implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<dynamic> request({@required Uri uri, @required String method, Map body, Map headers}) async {
    final defautHeaders = headers?.cast<String, String>() ?? {}..addAll({
      'content-type': 'application/json',
      'accept': 'application/json',
      'transactionid': '123456'
    });

    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    try {
      if (method == 'post') {
        response = await client.post(uri, headers: defautHeaders, body: jsonBody);
      } else if (method == 'get') {
        response = await client.get(uri, headers: defautHeaders);
      }
    } catch(error) {
      throw HttpError.serverError;
    }
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200: return response.body.isEmpty ? null : json.decode(utf8.decode(response.bodyBytes));
      case 204: return null;
      case 400: throw HttpError.badRequest;
      case 401: throw HttpError.unauthorized;
      case 403: throw HttpError.forbidden;
      case 404: throw HttpError.notFound;
      default: throw HttpError.serverError;
    }
  }
}