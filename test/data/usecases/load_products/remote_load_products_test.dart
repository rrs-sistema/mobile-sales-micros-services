import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/data/http/http.dart';

class RemoteLoadProducts {
  final Uri uri;
  final HttpClient httpClient;

  RemoteLoadProducts({@required this.uri, @required this.httpClient});

  Future<void> load() async {
    await httpClient.request(uri: uri, method: 'get');
  }
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteLoadProducts sut;
  HttpClient httpClient;
  Uri uri;
  String url;

  setUp(() {
    url = faker.internet.httpUrl();
    uri = Uri.parse(url);
    httpClient = HttpClientSpy();
    sut = RemoteLoadProducts(uri: uri, httpClient: httpClient);
  });
  
  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(httpClient.request(uri: uri, method: 'get'));
  });
}