import '../../../domain/usecases/usecases.dart';
import '../../../data/usecases/usecases.dart';
import '../factories.dart';

LoadCategories makeRemoteLoadCategories() {
  return RemoteLoadCategories(
    httpClient: makeAuthorizeHttpClientDecorator(), 
    uri: makeApiProduct('category')
  );
}

LoadCategories makeLocalLoadCategories() => LocalLoadCategories(
  cacheStorage: makeLocalStorageAdapter()
);

LoadCategories makeRemoteLoadCategoriesWithLocalFallback() => RemoteLoadCategoriesWithLocalFallback(
  remote: makeRemoteLoadCategories(),
  local: makeLocalLoadCategories()
);