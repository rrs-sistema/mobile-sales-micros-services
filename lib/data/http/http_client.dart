import 'package:meta/meta.dart';

abstract class HttpClient<ResponseType> {
  Future<ResponseType> request({
    @required Uri uri, 
    @required String method,
    Map body
  });
}