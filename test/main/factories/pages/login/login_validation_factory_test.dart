import 'package:test/test.dart';

import 'package:delivery_micros_services/validators/validators/validators.dart';
import 'package:delivery_micros_services/main/factories/factories.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password')
      ]);

  });
}