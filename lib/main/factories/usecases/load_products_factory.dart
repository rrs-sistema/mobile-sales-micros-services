import './../../../domain/usecases/usecases.dart';
import './../../../data/usecases/usecases.dart';
import './../../composites/composites.dart';
import './../factories.dart';

RemoteLoadProducts makeRemoteLoadProducts() {
  return RemoteLoadProducts(
    httpClient: makeAuthorizeHttpClientDecorator(), 
    url: makeApiProduct('product')
  );
}

LocalLoadProducts makeLocalLoadProducts() => LocalLoadProducts(
  cacheStorage: makeLocalStorageAdapter()
);

LoadProducts makeRemoteLoadProductsWithLocalFallback() => RemoteLoadProductsWithLocalFallback(
  remote: makeRemoteLoadProducts(),
  local: makeLocalLoadProducts()
);