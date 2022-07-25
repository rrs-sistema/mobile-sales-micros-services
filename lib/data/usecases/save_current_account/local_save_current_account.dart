import 'package:meta/meta.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../domain/helpers/helpers.dart';
import '../../cache/cache.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({@required this.saveSecureCacheStorage});

  Future<void> save(AccountEntity account) async {
    try {
      print('Salvando os dados --->>> ${account.accessToken}');
      await saveSecureCacheStorage.saveSecure(key: 'accessToken', value: account.accessToken);
    } catch (error) {
      print('LocalSaveCurrentAccount --->>> $error');
      throw DomainError.unexpected;
    }
  }
}