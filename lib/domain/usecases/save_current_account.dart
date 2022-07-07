import '../entity/entity.dart';

abstract class SaveCurrentAccount {
  Future<void> save(AccountEntity account);
}