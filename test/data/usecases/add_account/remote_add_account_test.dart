import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';
import 'package:delivery_micros_services/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  HttpClientSpy httpClient;
  RemoteAddAccount sut;
  AddAccountParams params;
  Uri uri;
  Map mockValidData() => {'accessToken': faker.guid.guid()};

  PostExpectation mockRequest() =>
  when(httpClient.request(uri: anyNamed('uri'), method: anyNamed('method'), body: anyNamed('body')));

  void mockHttpErro(HttpError error) {
    mockRequest().thenThrow(error);
  }

  void mockHttpData(Map data) {
    mockRequest().thenAnswer((_) async => data);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    uri = Uri.parse(url);
    sut = RemoteAddAccount(httpClient: httpClient, uri: uri);
    params = AddAccountParams(
      name: faker.person.name(), 
      email: faker.internet.email(), 
      password: faker.internet.password(), 
      passwordConfirmation: faker.internet.password(), 
      admin: false);
    mockHttpData(mockValidData());
  });

  test('Shoul call HttpClient with correct values', () async {
    await sut.add(params);

    verify(httpClient.request(
        uri: uri,
        method: 'post',
        body: {
          'name': params.name, 
          'email': params.email, 
          'admin': params.admin, 
          'password': params.password,
          'passwordConfirmation': params.passwordConfirmation
        }
      ));
  });

  test('Should throw UnexpectedError if HttpClinete returns 400', () async {
    mockHttpErro(HttpError.badRequest);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClinete returns 404', () async {
    mockHttpErro(HttpError.notFound);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClinete returns 500', () async {
    mockHttpErro(HttpError.serverError);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClinete returns 403', () async {
    mockHttpErro(HttpError.forbidden);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.emailInUse));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final validData = mockValidData();
    mockHttpData(validData);

    final account = await sut.add(params);

    expect(account.accessToken, validData['accessToken']);
  });

}