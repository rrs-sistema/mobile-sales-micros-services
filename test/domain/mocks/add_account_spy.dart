import 'package:mocktail/mocktail.dart';

import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

class AddAccountSpy extends Mock implements AddAccount {
  When mockAddAccountCall() => when(() => this.add(any()));
  void mockAddAccount(AccountEntity data) => this.mockAddAccountCall().thenAnswer((_) async => data);
  void mockAddAccountError(DomainError error) => this.mockAddAccountCall().thenThrow(error); 
}