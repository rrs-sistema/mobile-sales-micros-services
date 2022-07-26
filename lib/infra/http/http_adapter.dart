import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request({@required Uri uri, @required String method, Map body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'transactionid': '123456'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    try {
      if (method == 'post') {
        response = await client.post(uri, headers: headers, body: jsonBody);
      }
    } catch(error) {
      throw HttpError.serverError;
    }
    return _handleResponse(response);
  }

  Map _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200: return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204: return null;
      case 400: throw HttpError.badRequest;
      case 401: throw HttpError.unauthorized;
      case 403: throw HttpError.forbidden;
      case 404: throw HttpError.notFound;
      default: throw HttpError.serverError;
    }
  }
}