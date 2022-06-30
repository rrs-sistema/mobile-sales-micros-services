import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({@required Uri uri, @required String method}) async {
    await client.post(uri);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  group('post', () {
    test('Should call post with correct values', () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();

      final Uri uri = Uri.parse(url);

      await sut.request(uri: uri, method: 'post');

      verify(client.post(uri));
    });
  });
}
