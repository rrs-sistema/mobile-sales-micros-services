import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/protocols/validation.dart';
import 'package:delivery_micros_services/validators/validators/validators.dart';

void main() {
  CompareFieldsValidation sut;
  setUp(() {
    sut = CompareFieldsValidation(field: 'any_field', fieldToCompare: 'other_field');
  });

  test('Should return null on invalid casess', () {
    expect(sut.validate({'any_field': 'any_value',}), null);
    expect(sut.validate({'any_field': 'any_value', 'other_field': 'any_value'}), null);
    expect(sut.validate({}), null);
  });

  test('Should return error if values is not equal', () {
    final formData = {'any_field': 'any_value', 'other_field': 'other_value',};
    expect(sut.validate(formData), ValidationError.invalidField);
  });

  test('Should return null if values are equal', () {
    final formData = {
      'any_field': 'any_value',
      'other_field': 'any_value',
    };
    expect(sut.validate(formData), null);
  });

}