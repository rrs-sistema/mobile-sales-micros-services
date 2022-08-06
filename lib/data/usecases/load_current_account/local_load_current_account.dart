import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../domain/helpers/helpers.dart';
import '../../cache/cache.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  Future<AccountEntity> load() async {
    try {
      final accessToken = await fetchSecureCacheStorage.fetch('accessToken');
      if(accessToken == null) throw Error();
      return AccountEntity(accessToken: accessToken);      
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}