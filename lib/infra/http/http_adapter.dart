import 'package:http/http.dart';
import 'dart:convert';

import '../../data/http/http.dart';

class HttpAdapter<ResponseType> implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<dynamic> request({required String url, required String method, Map? body, Map? headers}) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}..addAll({
      'content-type': 'application/json',
      'accept': 'application/json',
      'transactionid': '123456'
    });

    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    Future<Response>? futureResponse;
    try {
      final uri = Uri.parse(url);
      if (method == 'post') {
        futureResponse = client.post(uri, headers: defaultHeaders, body: jsonBody);
      } else if (method == 'get') {
        futureResponse = client.get(uri, headers: defaultHeaders);
      }
      if(futureResponse != null){
        response = await futureResponse.timeout(Duration(seconds: 10));
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