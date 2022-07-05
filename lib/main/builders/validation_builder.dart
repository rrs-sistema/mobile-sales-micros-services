import '../../validators/validators/validators.dart';
import '../../validators/protocols/protocols.dart';

class ValidationBuilder {
  static ValidationBuilder _instance;
  String fieldName;
  List<FieldValidation> validations = [];

  ValidationBuilder._();

  static ValidationBuilder filed(String fieldName) {
    _instance = ValidationBuilder._();
    _instance.fieldName = fieldName;
    return _instance;
  }

  ValidationBuilder required() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationBuilder email() {
    validations.add(EmailValidation(fieldName));
    return this;
  }

  List<FieldValidation> build() => validations;

}