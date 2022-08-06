import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/presenters/presenters.dart';
import 'package:delivery_micros_services/presentation/protocols/protocols.dart';
import 'package:delivery_micros_services/domain/usecases/authentication.dart';
import 'package:delivery_micros_services/ui/helpers/errors/errors.dart';
import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

import './../../domain/mocks/mocks.dart';
import './../mocks/mocks.dart';

void main() {
  late AuthenticationSpy authentication;
  late GetxLoginPresenter sut;
  late ValidationSpy validation;
  late SaveCurrentAccountSpy saveCurrentAccount;
  late String email;
  late String password;
  late AccountEntity account;

  setUp(() {
    account = EntityFactory.makeAccountEntity();
    email = faker.internet.email();
    password = faker.internet.password();
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    authentication.mockcAuthentication(account);
    saveCurrentAccount = SaveCurrentAccountSpy();
    sut = GetxLoginPresenter(
      validation: validation, 
      authentication: authentication,
      saveCurrentAccount: saveCurrentAccount
    );
  });

 setUpAll(() {
    registerFallbackValue(ParamsFactory.makeAuthentication());
    registerFallbackValue(EntityFactory.makeAccountEntity());
  });

  test('Should call Validation with correct email', () {
    final formData = {'email': email, 'password': null};

    sut.validateEmail(email);
    
    verify(() => validation.validate(field: 'email', input: formData)).called(1);
  });

  test('Should emit email error if validation fails', () {
    validation.mockValidation(value: ValidationError.invalidField);

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit invalidFieldError if email is invalid', () {
    validation.mockValidation(value: ValidationError.invalidField);

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit requiredFieldError if email is empty', () {
    validation.mockValidation(value: ValidationError.requiredField);

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit email null if validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });  

  test('Should call Validation with correct password', () {
    final formData = {'email': null, 'password': password};

    sut.validatePassword(password);
    
    verify(() => validation.validate(field: 'password', input: formData)).called(1);
  });

  test('Should emit requiredFieldError if password is empty', () {
    validation.mockValidation(value: ValidationError.requiredField);

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit email null if validation succeeds', () {
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should disable form button if any field is invalid', () {
    validation.mockValidation(field: 'email', value: ValidationError.invalidField);

    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should enable form button if all field is valid', () async {
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call Authentication with correct values', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);
    await sut.auth();

    verify(() => authentication.auth(AuthenticationParams(email: email, secret: password))).called(1);
  });  

  test('Should call SaveCurrentAccount with correct values', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();

    verify(() => saveCurrentAccount.save(account)).called(1);
  });  

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async {
    saveCurrentAccount.mockcSaveCurrentAccountError();
    sut.validateEmail(email);
    sut.validatePassword(password);
    
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.unexpected]));

    await sut.auth();
  });

  test('Should emit correct events on Authetication success', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emits(true));
    expectLater(sut.mainErrorStream, emits(null));
    
    await sut.auth();
  }); 

  test('Should change page on success', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/base_screen')));

    await sut.auth();
  }); 

  test('Should emit correct events on InvalidCredentialsError', () async {
    authentication.mockcAuthenticationError(DomainError.invalidCredentials);
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.invalidCredentials]));
  
    await sut.auth();
  }); 

  test('Should emit correct events on UnexpectedError', () async {
    authentication.mockcAuthenticationError(DomainError.unexpected);
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.unexpected]));

    await sut.auth();
  });   

  test('Should go to SignUpPage on link lick', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/signup')));

    sut.goToSignUp();
  }); 

}