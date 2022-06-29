import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:sales_micros_services/domain/usecases/usecases.dart';
import 'package:sales_micros_services/domain/helpers/helpers.dart';
import 'package:sales_micros_services/data/usecases/usecases.dart';
import 'package:sales_micros_services/data/http/http.dart';


class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  HttpClientSpy httpClient;
  RemoteAuthentication sut;
  AuthenticationParams params;
  String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
  });

  test('Shoul call HttpClient with correct values', () async {
    
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenAnswer((_) async => {
        'accessToken': faker.guid.guid()
      });

    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.secret}
      ));
  });

  test('Shoul throw UnexpectedError if HttpClinete returns 400', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Shoul throw UnexpectedError if HttpClinete returns 404', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Shoul throw UnexpectedError if HttpClinete returns 500', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Shoul throw InvalidCredentialsError if HttpClinete returns 401', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredential));
  });

  test('Shoul return an Account if HttpClient returns 200', () async {
    final accessToken = faker.guid.guid();
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenAnswer((_) async => {
        'accessToken': accessToken
      });

    final account = await sut.auth(params);

    expect(account.accessToken, accessToken);
  });

}
