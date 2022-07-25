import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:delivery_micros_services/presentation/protocols/validation.dart';
import 'package:delivery_micros_services/validators/protocols/protocols.dart';

class MinLengthValidation implements FieldValidation {

  final String field;
  final int size;

  MinLengthValidation({@required this.field, @required this.size});

  ValidationError validate(String value) {
    return ValidationError.invalidField;
  }

}

void main() {
  MinLengthValidation sut;
  setUp(() {
    sut = MinLengthValidation(field: 'any_field', size: 5);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), ValidationError.invalidField);
  });

  test('Should return error if value is less than min size', () {
    expect(sut.validate(faker.randomGenerator.string(4, min: 1)), ValidationError.invalidField);
  });

}