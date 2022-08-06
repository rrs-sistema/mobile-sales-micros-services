import 'package:mocktail/mocktail.dart';

import 'package:delivery_micros_services/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {
  ValidationSpy() {
    this.mockValidation();
  }
  When mockValidationCall(String? field) => when(() => this.validate(field: field == null ? any(named: 'field') : field, input: any(named: 'input')));
  void mockValidation({ String? field, ValidationError? value}) => this.mockValidationCall(field).thenReturn(value);
  void mockValidationError({ String? field, required ValidationError value}) => this.mockValidationCall(field).thenReturn(value);
}