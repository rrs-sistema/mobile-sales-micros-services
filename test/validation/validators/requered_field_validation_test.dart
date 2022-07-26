import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/protocols/validation.dart';
import 'package:delivery_micros_services/validators/validators/validators.dart';

void main() {
  RequiredFieldValidation sut;
  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('Should return null if is not empty', () {
    expect(sut.validate({'any_field': 'any_field'}), null);
  });

  test('Should return error if is empty', () {
    expect(sut.validate({'any_field': ''}), ValidationError.requiredField);
  });

  test('Should return error if is null', () {
    expect(sut.validate({'any_field': null}), ValidationError.requiredField);
  });  

}