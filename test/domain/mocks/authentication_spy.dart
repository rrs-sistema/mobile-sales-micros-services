import 'package:mocktail/mocktail.dart';

import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

class AuthenticationSpy extends Mock implements Authentication {
  When mockAuthenticationCall() => when(() =>  this.auth(any()));
  void mockcAuthentication(AccountEntity data) => this.mockAuthenticationCall().thenAnswer((_) async => data);
  void mockcAuthenticationError(DomainError error) => this.mockAuthenticationCall().thenThrow(error);
}