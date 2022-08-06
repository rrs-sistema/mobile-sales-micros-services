import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/infra/cache/cache.dart';

import './../mocks/mocks.dart';

void main() {
  late SecureStorageAdapter sut;
  late FlutterSecureStorageSpy secureStorage;
  late String key;
  late String value;

  setUp(() {
    key = faker.lorem.word();
    value = faker.guid.guid();

    secureStorage = FlutterSecureStorageSpy();
    secureStorage.mockFetch(value);
    sut = SecureStorageAdapter(secureStorage: secureStorage);
  });

  group('saveSecure', () {

    test('Should call save secure with correct values', () async {
      await sut.save(key: key, value: value);

      verify(() => secureStorage.write(key: key, value: value));
    });

    test('Should throw if save serure throws', () {
      secureStorage.mockSaveError();

      final future = sut.save(key: key, value: value);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('fetchSecure', () {
    test('Should call fetch secure with correct value', () async {
      await sut.fetch(key);

      verify(() => secureStorage.read(key: key));
    });

    test('Should return carrect value on success', () async {
      final fetchedValue = await sut.fetch(key);

      expect(fetchedValue, value);
    });    

    test('Should throw if fetch serure throws', () {
      secureStorage.mockFetchError();

      final future = sut.fetch(key);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });

  });
  
  group('delete', () {
    test('Should call delete with correct key', () async {
      await sut.delete(key);

      verify(() => secureStorage.delete(key: key)).called(1);
    });

    test('Should throw if delete throws', () async {
      secureStorage.mockDeleteError();

      final future = sut.delete(key);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });  
}
