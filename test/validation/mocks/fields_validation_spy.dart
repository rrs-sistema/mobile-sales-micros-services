import 'package:mocktail/mocktail.dart';

import 'package:delivery_micros_services/presentation/protocols/protocols.dart';
import 'package:delivery_micros_services/validators/protocols/protocols.dart';

class FieldValidationSpy extends Mock implements FieldValidation {
  FieldValidationSpy() {
    this.mockValidation();
    this.mockFieldName('any_field');
  }

  When mockValidationCall() => when(() => this.validate(any()));
  void mockValidation() => this.mockValidationCall().thenReturn(null);
  void mockValidationError(ValidationError error) => this.mockValidationCall().thenReturn(error);

  void mockFieldName(String filedName) => when(() => this.field).thenReturn(filedName);

}