import 'package:test/test.dart';

import 'package:delivery_micros_services/validators/validators/validators.dart';
import 'package:delivery_micros_services/main/factories/factories.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeSignUpValidations();

    expect(validations, [
      RequiredFieldValidation('name'),
      MinLengthValidation(field: 'name', size: 3),   
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
      MinLengthValidation(field: 'password', size: 3),
      RequiredFieldValidation('passwordConfirmation'),
      CompareFieldsValidation(field: 'passwordConfirmation', fieldToCompare: 'password')
    ]);

  });
}