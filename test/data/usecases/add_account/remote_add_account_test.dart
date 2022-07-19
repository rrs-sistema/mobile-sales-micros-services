import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  HttpClientSpy httpClient;
  RemoteAddAccount sut;
  AddAccountParams params;
  Uri uri;

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

}