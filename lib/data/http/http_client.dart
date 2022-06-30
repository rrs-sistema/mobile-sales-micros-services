import 'package:meta/meta.dart';

abstract class HttpClient {
  Future<Map> request({
    @required Uri uri, 
    @required String method,
    Map body
  });
}