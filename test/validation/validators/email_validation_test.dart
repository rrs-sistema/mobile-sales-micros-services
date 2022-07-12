import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/protocols/protocols.dart';
import 'package:delivery_micros_services/validators/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empyty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });  

  test('Should return null if email is valid', () {
    expect(sut.validate('rrs.sistema@gmail.com'), null);
  });  

  test('Should return error if email is invalid', () {
    expect(sut.validate('rrs.sistema'), ValidationError.invalidField);
  });  

}