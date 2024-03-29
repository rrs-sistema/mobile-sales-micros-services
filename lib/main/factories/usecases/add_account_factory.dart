import '../../../domain/usecases/usecases.dart';
import '../../../data/usecases/usecases.dart';
import '../factories.dart';

AddAccount makeRemoteAddAccount() {
  return RemoteAddAccount(
    httpClient: makeHttpAdapter<Map>(), 
    url: makeApiLogin('user/create')
  );
}