import 'package:mocktail/mocktail.dart';

import 'package:delivery_micros_services/data/cache/cache.dart';

class SecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage, DeleteSecureCacheStorage, SaveSecureCacheStorage {
  SecureCacheStorageSpy() {
    mockDelete();
    mockSave();
  }

  When mockFetchAll() => when(() => fetch(any()));
  void mockFetch(String? data) => mockFetchAll().thenAnswer((_) async => data);
  void mockFetchError() => mockFetchAll().thenThrow(Exception());

  When mockDeleteAll() => when(() => delete(any()));
  void mockDelete() => mockDeleteAll().thenAnswer((_) async => _);
  void mockDeleteError() => mockDeleteAll().thenThrow(Exception());

  When mockSaveAll() => when(() => save(key: any(named: 'key'), value: any(named: 'value')));
  void mockSave() => mockSaveAll().thenAnswer((_) async => _);
  void mockSaveError() => mockSaveAll().thenThrow(Exception());
}

/*

  void mockFetchSecure(String? data) => mockFetchSecureCall().thenAnswer((_) async => data);

  void mockFetchSecureError() {
    mockFetchSecureCall().thenThrow(Exception());
  }
*/