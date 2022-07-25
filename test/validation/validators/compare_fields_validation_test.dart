import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/protocols/validation.dart';
import 'package:delivery_micros_services/validators/validators/validators.dart';

void main() {
  CompareFieldsValidation sut;
  setUp(() {
    sut = CompareFieldsValidation(field: 'any_field', valueToCompare: 'any_value');
  });

  test('Should return error if values is not equal', () {
    expect(sut.validate('wrong_value'), ValidationError.invalidField);
  });

  test('Should return null if values are equal', () {
    expect(sut.validate('any_value'), null);
  });

}