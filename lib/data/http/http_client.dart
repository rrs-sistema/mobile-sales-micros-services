import 'package:meta/meta.dart';

abstract class HttpClient {
  Future<dynamic> request({
    @required Uri uri, 
    @required String method,
    Map body,
    Map headers
  });
}