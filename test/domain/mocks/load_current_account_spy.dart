import 'package:mocktail/mocktail.dart';

import 'package:delivery_micros_services/domain/entities/account_entity.dart';
import 'package:delivery_micros_services/domain/usecases/usecases.dart';

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {
  When mockLoadCall() => when(() => this.load());
  void mockLoad({required AccountEntity account}) => this.mockLoadCall().thenAnswer((_) async => account);
  void mockLoadError() => this.mockLoadCall().thenThrow(Exception());
}