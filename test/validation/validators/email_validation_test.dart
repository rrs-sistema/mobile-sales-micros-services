import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/protocols/protocols.dart';
import 'package:delivery_micros_services/validators/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empyty', () {
    expect(sut.validate({'any_field': ''}), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate({'any_field': null}), null);
  });  

  test('Should return null if email is valid', () {
    expect(sut.validate({'any_field': 'rrs.sistema@gmail.com'}), null);
  });  

  test('Should return error if email is invalid', () {
    expect(sut.validate({'any_field': 'rrs.sistema'}), ValidationError.invalidField);
  });  

}