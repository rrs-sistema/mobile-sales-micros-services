import 'package:delivery_micros_services/validators/protocols/field_validation.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {

  final String field;

  EmailValidation(this.field);

  String validate(String value) {
    return null;
  }

}

void main() {
  test('Should return null if email is empyty', () {
    final sut = EmailValidation('any_field');

    final error = sut.validate('');

    expect(error, null);
  });


}