import 'package:test/test.dart';

abstract class FieldValidation {
  String get field;
  String validate(String value);
}

class RequiredFieldValidation  implements FieldValidation {

  final String field;

  RequiredFieldValidation(this.field);

  String validate(String value) {
    return value.isEmpty ? 'Campo obrigatório' : null;
  }

}

void main() {
  RequiredFieldValidation sut;
  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('Should return null if is not empty', () {
    expect(sut.validate('any_field'), null);
  });

  test('Should return error if is empty', () {
    expect(sut.validate(''), 'Campo obrigatório');
  });

}