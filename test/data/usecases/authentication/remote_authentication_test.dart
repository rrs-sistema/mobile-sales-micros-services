import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/data/http/http.dart';

import './../../../domain/mocks/params_factory.dart';
import './../../../infra/mocks/mocks.dart';
import './../../mocks/mocks.dart';

void main() {
  late HttpClientSpy httpClient;
  late RemoteAuthentication sut;
  late AuthenticationParams params;
  late String url;
  late Map apiResult;

  setUp(() {
    apiResult = ApiFactory.makeAccountJson();
    params = ParamsFactory.makeAuthentication();
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    httpClient.mockRequest(apiResult);
  });

  test('Shoul call HttpClient with correct values', () async {
    await sut.auth(params);

    verify(() => httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.secret}, 
      ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    httpClient.mockRequestError(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Shoul throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 401', () async {
    httpClient.mockRequestError(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final validData = ApiFactory.makeAccountJson();
    httpClient.mockRequest(validData);

    final account = await sut.auth(params);

    expect(account.accessToken, validData['accessToken']);
  });

  test('Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    httpClient.mockRequest({'invalid_key': 'invalid_value'});

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

}
