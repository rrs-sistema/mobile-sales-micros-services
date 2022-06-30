import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({@required Uri uri, @required String method, Map body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    await client.post(uri, headers: headers, body: jsonBody);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  HttpAdapter sut;
  ClientSpy client;
  String url;
  Uri uri;

  setUp(() {
      client = ClientSpy();
      sut = HttpAdapter(client);
      url = faker.internet.httpUrl();
      uri = Uri.parse(url);
  });

  group('post', () {
    test('Should call post with correct values', () async {

      await sut.request(uri: uri, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(uri, headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        }, body: '{"any_key":"any_value"}'
      ));
    });

    test('Should call post without body', () async {

      await sut.request(uri: uri, method: 'post');

      verify(client.post(uri, headers: anyNamed('headers')
      ));
    });

  });
}
