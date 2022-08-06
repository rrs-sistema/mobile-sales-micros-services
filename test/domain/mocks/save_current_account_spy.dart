import 'package:mocktail/mocktail.dart';

import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {
  SaveCurrentAccountSpy() {
    this.mockcAuthentication();
  }

  When mockSaveCurrentAccountCall() => when(() => this.save(any()));
  void mockcAuthentication() => this.mockSaveCurrentAccountCall().thenAnswer((_) async => _);
  void mockcSaveCurrentAccountError() => mockSaveCurrentAccountCall().thenThrow(DomainError.unexpected);
}