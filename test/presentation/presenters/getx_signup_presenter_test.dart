import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/presenters/presenters.dart';
import 'package:delivery_micros_services/presentation/protocols/protocols.dart';
import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/ui/helpers/errors/errors.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

import './../../domain/mocks/mocks.dart';
import './../mocks/mocks.dart';

void main() {
  late GetxSignUpPresenter sut;
  late ValidationSpy validation;
  late SaveCurrentAccountSpy saveCurrentAccount;
  late AddAccountSpy addAccount;
  late String email;
  late String name;
  late String password;
  late String passwordConfirmation;
  bool admin = false;
  late AccountEntity account;

  setUp(() {
    name = faker.person.name();
    email = faker.internet.email();
    password = faker.internet.password();
    passwordConfirmation = faker.internet.password();
    admin = false;    
    account = EntityFactory.makeAccountEntity();

    validation = ValidationSpy();
    addAccount = AddAccountSpy();
    addAccount.mockAddAccount(account);
    
    saveCurrentAccount = SaveCurrentAccountSpy();
    sut = GetxSignUpPresenter(
        validation: validation,
        addAccount: addAccount,
        saveCurrentAccount: saveCurrentAccount,);
  });

 setUpAll(() {
    registerFallbackValue(EntityFactory.makeAccountEntity());
    registerFallbackValue(ParamsFactory.makeAddAccount());
  });

  test('Should call Validation with correct email', () {
    final formData = {
      'name': null,
      'email': email,
      'password': null,
      'passwordConfirmation': null,
      'admin': false
    };

    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', input: formData)).called(1);
  });

  test('Should emit invalidFieldError if email is invalid', () {
    validation.mockValidation(value: ValidationError.invalidField);

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit requiredFieldError if email is empty', () {
    validation.mockValidation(value: ValidationError.requiredField);

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call Validation with correct name', () {
    final formData = {
      'name': name,
      'email': null,
      'password': null,
      'passwordConfirmation': null,
      'admin': false
    };

    sut.validateName(name);

    verify(() => validation.validate(field: 'name', input: formData)).called(1);
  });

  test('Should emit invalidFieldError if name is invalid', () {
    validation.mockValidation(value: ValidationError.invalidField);

    sut.nameErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should emit requiredFieldError if name is empty', () {
    validation.mockValidation(value: ValidationError.requiredField);

    sut.nameErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should emit null if validation succeeds', () {
    sut.nameErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should call Validation with correct password', () {
    final formData = {
      'name': null,
      'email': null,
      'password': password,
      'passwordConfirmation': null,
      'admin': false
    };

    sut.validatePassword(password);

    verify(() => validation.validate(field: 'password', input: formData)).called(1);
  });

  test('Should emit invalidFieldError if password is invalid', () {
    validation.mockValidation(value: ValidationError.invalidField);

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit requiredFieldError if password is empty', () {
    validation.mockValidation(value: ValidationError.requiredField);

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit null if validation succeeds', () {
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should call Validation with correct passwordConfirmation', () {
    final formData = {
      'name': null,
      'email': null,
      'password': null,
      'passwordConfirmation': passwordConfirmation,
      'admin': false
    };

    sut.validatePasswordConfirmation(passwordConfirmation);

    verify(() => validation.validate(field: 'passwordConfirmation', input: formData)).called(1);
  });

  test('Should emit invalidFieldError if passwordConfirmation is invalid', () {
    validation.mockValidation(value: ValidationError.invalidField);

    sut.passwordConfirmationErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should emit requiredFieldError if passwordConfirmation is empty', () {
    validation.mockValidation(value: ValidationError.requiredField);

    sut.passwordConfirmationErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should emit requiredFieldError if admin is null', () {
    validation.mockValidation(value: ValidationError.requiredField);

    sut.isAdminErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateAdmin(admin);
    sut.validateAdmin(admin);
  });

  test('Should call Validation with correct admin', () {
    final formData = {
      'name': null,
      'email': null,
      'password': null,
      'passwordConfirmation': null,
      'admin': false
    };

    sut.validateAdmin(admin);

    verify(() => validation.validate(field: 'admin', input: formData)).called(1);
  });

  test('Should emit null if validation succeeds', () {
    sut.passwordConfirmationErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should enable form button if all fields are valid', () async {
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateName(name);
    await Future.delayed(Duration.zero);
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
    await Future.delayed(Duration.zero);
    sut.validatePasswordConfirmation(passwordConfirmation);
    await Future.delayed(Duration.zero);
    sut.validateAdmin(admin);
    await Future.delayed(Duration.zero);
  });

  test('Should call AddAccount with correct values', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validateAdmin(admin);

    await sut.signUp();

    verify(() => addAccount.add(AddAccountParams(
            name: name,
            email: email,
            password: password,
            passwordConfirmation: passwordConfirmation,
            admin: false)))
        .called(1);
  });

  test('Should call SaveCurrentAccount with correct value', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validateAdmin(admin);

    await sut.signUp();

    verify(() => saveCurrentAccount.save(account))
        .called(1);
  });

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async {
    saveCurrentAccount.mockcSaveCurrentAccountError();
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validateAdmin(admin);

    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.unexpected]));
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.signUp();
  });

  test('Should emit correct events on AddAccount success', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validateAdmin(admin);

    expectLater(sut.mainErrorStream, emits(null));
    expectLater(sut.isLoadingStream, emits(true));

    await sut.signUp();
  });

  test('Should emit correct events on EmailInUseError', () async {
    addAccount.mockAddAccountError(DomainError.emailInUse);
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validateAdmin(admin);

    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.emailInUse]));
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.signUp();
  });

  test('Should emit correct events on UnexpectedError', () async {
    addAccount.mockAddAccountError(DomainError.unexpected);
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validateAdmin(admin);

    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.unexpected]));
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.signUp();
  });

  test('Should change page on success', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validateAdmin(admin);

    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/base_screen')));

    await sut.signUp();
  });

  test('Should go to LoginPage on link lick', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    sut.goToLogin();
  });
}
