import '../../../../presentation/protocols/protocols.dart';
import '../../../../validators/validators/validators.dart';
import '../../../../validators/protocols/protocols.dart';
import '../../../builders/builders.dart';

Validation makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.filed('email').required().email().build(),
    ...ValidationBuilder.filed('password').required().min(3).build()
  ];
}