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
  test('Should call HttpClient with correct values', () async {
    final url = faker.internet.httpUrl();
    final uri = Uri.parse(url);
    final httpClient = HttpClientSpy();
    final sut = RemoteLoadProducts(uri: uri, httpClient: httpClient);

    await sut.load();

    verify(httpClient.request(uri: uri, method: 'get'));
  });
}