import '../../../domain/usecases/usecases.dart';
import '../../../data/usecases/usecases.dart';
import '../factories.dart';

LoadCategories makeRemoteLoadCategories() {
  return RemoteLoadCategories(
    httpClient: makeAuthorizeHttpClientDecorator(), 
    uri: makeApiProduct('category')
  );
}