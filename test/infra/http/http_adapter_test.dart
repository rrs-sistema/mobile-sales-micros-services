import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

import 'package:sales_micros_services/data/http/http.dart';

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
    return jsonDecode(response.body);
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
      when(client.post(any, body: anyNamed('body') , headers: anyNamed('headers')))
        .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut.request(uri: uri, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(uri, headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        }, body: '{"any_key":"any_value"}'
      ));
    });

    test('Should call post without body', () async {
      when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers')))
        .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut.request(uri: uri, method: 'post');

      verify(client.post(uri, headers: anyNamed('headers')
      ));
    });

    test('Should return data if post returns 200', () async {
      when(client.post(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      final response = await sut.request(uri: uri, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

  });
}
