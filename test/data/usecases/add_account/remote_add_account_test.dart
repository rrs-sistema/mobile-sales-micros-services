import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';
import 'package:delivery_micros_services/data/http/http.dart';

import './../../../domain/mocks/mocks.dart';
import '../../../infra/mocks/mocks.dart';
import './../../mocks/mocks.dart';

void main() {
  late RemoteAddAccount sut;
  late HttpClientSpy httpClient;
  late AddAccountParams params;
  late String url;
  late Map apiResult;

  setUp(() {
    apiResult = ApiFactory.makeAccountJson();
    params = ParamsFactory.makeAddAccount();

    url = faker.internet.httpUrl();

    httpClient = HttpClientSpy();
    httpClient.mockRequest(apiResult);
    sut = RemoteAddAccount(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.add(params);

    verify(() => httpClient.request(
      url: url,
      method: 'post',
      body: {
        'name': params.name,
        'email': params.email,
        'password': params.password,
        'passwordConfirmation': params.passwordConfirmation,
        'admin': params.admin.toString(),
      }
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    httpClient.mockRequestError(HttpError.badRequest);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 403', () async {
    httpClient.mockRequestError(HttpError.forbidden);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.emailInUse));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final validData = ApiFactory.makeAccountJson();
    httpClient.mockRequest(validData);

    final account = await sut.add(params);

    expect(account.accessToken, validData['accessToken']);
  });

  test('Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    httpClient.mockRequest({'invalid_key': 'invalid_value'});

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

}