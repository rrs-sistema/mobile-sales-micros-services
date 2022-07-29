import '../../../domain/usecases/usecases.dart';
import '../../../data/usecases/usecases.dart';
import '../factories.dart';

LoadProducts makeRemoteLoadProducts() {
  return RemoteLoadProducts(
    httpClient: makeAuthorizeHttpClientDecorator(), 
    uri: makeApiProduct('product')
  );
}