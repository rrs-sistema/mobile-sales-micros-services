import './../../../domain/usecases/usecases.dart';
import './../../../data/usecases/usecases.dart';
import './../../composites/composites.dart';
import './../factories.dart';

LoadProducts makeRemoteLoadProducts() {
  return RemoteLoadProducts(
    httpClient: makeAuthorizeHttpClientDecorator(), 
    uri: makeApiProduct('product')
  );
}

LoadProducts makeLocalLoadProducts() => LocalLoadProducts(
  cacheStorage: makeLocalStorageAdapter()
);

LoadProducts makeRemoteLoadProductsWithLocalFallback() => RemoteLoadProductsWithLocalFallback(
  remote: makeRemoteLoadProducts(),
  local: makeLocalLoadProducts()
);