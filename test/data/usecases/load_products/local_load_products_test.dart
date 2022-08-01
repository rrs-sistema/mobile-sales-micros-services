import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

class LocalLoadProducts {
  final FetchCacheStorage fetchCacheStorage;

  LocalLoadProducts({@required this.fetchCacheStorage});

  Future<void> load() async {
    await fetchCacheStorage.fetch('products');
  }
}

abstract class FetchCacheStorage {
  Future<void> fetch(String key);
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {}


void main() {
  LocalLoadProducts sut;
  FetchCacheStorageSpy fetchCacheStorage;
  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalLoadProducts(
      fetchCacheStorage: fetchCacheStorage
    );
  });

  test('Should call FetchCacheStorage', () async {
    await sut.load();

    verify(fetchCacheStorage.fetch('products')).called(1);
  });
}