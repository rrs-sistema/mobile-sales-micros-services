import '../../../domain/usecases/usecases.dart';
import '../../../data/usecases/usecases.dart';
import '../factories.dart';

Authentication makeRemoteAuthentication() {
  return RemoteAuthentication(
    httpClient: makeHttpAdapter<Map>(), 
    uri: makeApiLogin('user/auth')
  );
}