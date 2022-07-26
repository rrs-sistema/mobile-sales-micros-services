import '../../../../presentation/protocols/protocols.dart';
import '../../../../validators/validators/validators.dart';
import '../../../../validators/protocols/protocols.dart';
import '../../../builders/builders.dart';

Validation makeSignUpValidation() {
  return ValidationComposite(makeSignUpValidations());
}

List<FieldValidation> makeSignUpValidations() {
  return [
    ...ValidationBuilder.filed('name').required().min(3).build(),
    ...ValidationBuilder.filed('email').required().email().build(),
    ...ValidationBuilder.filed('password').required().min(3).build(),
    ...ValidationBuilder.filed('passwordConfirmation').required().sameAs('password').build()
  ];
}