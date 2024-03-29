import '../../validators/validators/validators.dart';
import '../../validators/protocols/protocols.dart';

class ValidationBuilder {
  static ValidationBuilder? _instance;
  String fieldName;
  List<FieldValidation> validations = [];

  ValidationBuilder._(this.fieldName);

  static ValidationBuilder filed(String fieldName) {
    _instance = ValidationBuilder._(fieldName);
    return _instance!;
  }

  ValidationBuilder required() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationBuilder email() {
    validations.add(EmailValidation(fieldName));
    return this;
  }

  ValidationBuilder min(int size) {
    validations.add(MinLengthValidation(field: fieldName, size: size));
    return this;
  }

  ValidationBuilder sameAs(String fieldCompare) {
    validations.add(CompareFieldsValidation(field: fieldName, fieldToCompare: fieldCompare));
    return this;
  }

  List<FieldValidation> build() => validations;

}