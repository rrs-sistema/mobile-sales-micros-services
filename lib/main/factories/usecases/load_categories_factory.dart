import '../../../domain/usecases/usecases.dart';
import '../../../data/usecases/usecases.dart';
import '../factories.dart';

RemoteLoadCategories makeRemoteLoadCategories() {
  return RemoteLoadCategories(
    httpClient: makeAuthorizeHttpClientDecorator(), 
    url: makeApiProduct('category')
  );
}

LocalLoadCategories makeLocalLoadCategories() => LocalLoadCategories(
  cacheStorage: makeLocalStorageAdapter()
);

LoadCategories makeRemoteLoadCategoriesWithLocalFallback() => RemoteLoadCategoriesWithLocalFallback(
  remote: makeRemoteLoadCategories(),
  local: makeLocalLoadCategories()
);