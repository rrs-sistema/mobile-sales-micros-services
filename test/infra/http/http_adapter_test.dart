import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/infra/http/http.dart';
import 'package:delivery_micros_services/data/http/http.dart';

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

  group('shared', () { 
    test('Should throw ServerError if invalid method is provided', () async {

      final future = sut.request(uri: uri, method: 'invalid_method');

      expect(future, throwsA(HttpError.serverError));
    });
  });

  group('post', () {

    PostExpectation mockRequest() => when(client.post(any, body: anyNamed('body') , headers: anyNamed('headers')));

    void mockResponse(int statusCode, {String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    void mockError() {
      mockRequest().thenThrow(Exception());
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {

      await sut.request(uri: uri, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(uri, headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'transactionid': '123456'
        }, body: '{"any_key":"any_value"}'
      ));

      await sut.request(uri: uri, method: 'post', body: {'any_key': 'any_value'}, headers: {'any_header': 'any_value'});

      verify(client.post(uri, headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'any_header': 'any_value',
          'transactionid': '123456'
        }, body: '{"any_key":"any_value"}'
      ));
    });

    test('Should call post without body', () async {

      await sut.request(uri: uri, method: 'post');

      verify(client.post(uri, headers: anyNamed('headers')
      ));
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.request(uri: uri, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if post returns 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.request(uri: uri, method: 'post');

      expect(response, null);
    });

    test('Should return null if post returns 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(uri: uri, method: 'post');

      expect(response, null);
    });

    test('Should return null if post returns 204 with data', () async {
      mockResponse(204);

      final response = await sut.request(uri: uri, method: 'post');

      expect(response, null);
    });

    test('Should return BadRequestError if post returns 400', () async {
      mockResponse(400, body: '');

      final future = sut.request(uri: uri, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if post returns 400', () async {
      mockResponse(400);

      final future = sut.request(uri: uri, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return UnauthorizedError if post returns 401', () async {
      mockResponse(401);

      final future = sut.request(uri: uri, method: 'post');

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return ForbiddenError if post returns 403', () async {
      mockResponse(403);

      final future = sut.request(uri: uri, method: 'post');

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return NotFoundError if post returns 404', () async {
      mockResponse(404);

      final future = sut.request(uri: uri, method: 'post');

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return ServerError if post returns 500', () async {
      mockResponse(500);

      final future = sut.request(uri: uri, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });

    test('Should return ServerError if post throws', () async {
      mockError();

      final future = sut.request(uri: uri, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });

  });

  group('get', () {

    PostExpectation mockRequest() => when(client.get(any, headers: anyNamed('headers')));

    void mockResponse(int statusCode, {String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    void mockError() {
      mockRequest().thenThrow(Exception());
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call get with correct values', () async {
      await sut.request(uri: uri, method: 'get');
      verify(client.get(uri, headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'transactionid': '123456'
        }
      ));

      await sut.request(uri: uri, method: 'get', body: {'any_key': 'any_value'}, headers: {'any_header': 'any_value'});

      verify(client.get(uri, headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'any_header': 'any_value',
          'transactionid': '123456'
        },
      ));      
    });

    test('Should return data if get returns 200', () async {
      final response = await sut.request(uri: uri, method: 'get');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if get returns 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.request(uri: uri, method: 'get');

      expect(response, null);
    });

    test('Should return null if get returns 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(uri: uri, method: 'get');

      expect(response, null);
    });

    test('Should return null if get returns 204 with data', () async {
      mockResponse(204);

      final response = await sut.request(uri: uri, method: 'get');

      expect(response, null);
    });
    
    test('Should return BadRequestError if get returns 400', () async {
      mockResponse(400, body: '');

      final future = sut.request(uri: uri, method: 'get');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if get returns 400', () async {
      mockResponse(400);

      final future = sut.request(uri: uri, method: 'get');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return UnauthorizedError if get returns 401', () async {
      mockResponse(401);

      final future = sut.request(uri: uri, method: 'get');

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return ForbiddenError if get returns 403', () async {
      mockResponse(403);

      final future = sut.request(uri: uri, method: 'get');

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return NotFoundError if get returns 404', () async {
      mockResponse(404);

      final future = sut.request(uri: uri, method: 'get');

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return ServerError if get returns 500', () async {
      mockResponse(500);

      final future = sut.request(uri: uri, method: 'get');

      expect(future, throwsA(HttpError.serverError));
    });

    test('Should return ServerError if get throws', () async {
      mockError();

      final future = sut.request(uri: uri, method: 'get');

      expect(future, throwsA(HttpError.serverError));
    });

  });

}
