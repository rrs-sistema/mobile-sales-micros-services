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
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response = await client.post(uri, headers: headers, body: jsonBody);
    return _handleResponse(response);
  }

  Map _handleResponse(Response response) {
    if(response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else if(response.statusCode == 204) {
      return null;
    } else if(response.statusCode == 400) {
      throw HttpError.badRequest;
    } else {
      throw HttpError.serverError;
    }
  }
}