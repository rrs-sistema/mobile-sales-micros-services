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

  Map mockValidData() => {'accessToken': faker.guid.guid()};

  PostExpectation mockRequest() =>
  when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')));

  void mockHttpData(Map data) {
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpErro(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
    mockHttpData(mockValidData());
  });

  test('Shoul call HttpClient with correct values', () async {

    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.secret}
      ));
  });

  test('Should throw UnexpectedError if HttpClinete returns 400', () async {
    mockHttpErro(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Shoul throw UnexpectedError if HttpClinete returns 404', () async {
    mockHttpErro(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClinete returns 500', () async {
    mockHttpErro(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClinete returns 401', () async {
    mockHttpErro(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredential));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final validData = mockValidData();
    mockHttpData(validData);

    final account = await sut.auth(params);

    expect(account.accessToken, validData['accessToken']);
  });

  test('Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

}
