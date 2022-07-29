import '../../../domain/usecases/usecases.dart';
import '../../../data/usecases/usecases.dart';
import '../factories.dart';

LoadProducts makeRemoteLoadProducts() {
  return RemoteLoadProducts(
    httpClient: makeHttpAdapter<Map>(), 
    uri: makeApiProduct('product')
  );
}