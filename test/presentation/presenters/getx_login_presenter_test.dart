import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/presenters/presenters.dart';
import 'package:delivery_micros_services/presentation/protocols/protocols.dart';
import 'package:delivery_micros_services/domain/usecases/authentication.dart';
import 'package:delivery_micros_services/ui/helpers/errors/errors.dart';
import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

class ValidationSpy extends Mock implements Validation {}
class AuthenticationSpy extends Mock implements Authentication {}
class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {}


void main() {
  AuthenticationSpy authentication;
  GetxLoginPresenter sut;
  ValidationSpy validation;
  SaveCurrentAccountSpy saveCurrentAccount;
  String email;
  String password;
  String accessToken;

  PostExpectation mockValidationCall(String field) => 
    when(validation.validate(field: field == null ? anyNamed('field') : field, value: anyNamed('value')));

  void mockValidation({String field, ValidationError value}) {
    mockValidationCall(field).thenReturn(value);
  }

  PostExpectation mockAuthenticationCall() => when(authentication.auth(any));

  void mockcAuthentication() {
    mockAuthenticationCall().thenAnswer((_) async => AccountEntity(accessToken: accessToken));
  }

  void mockcAuthenticationError(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  PostExpectation mockSaveCurrentAccountCall() => when(saveCurrentAccount.save(any));

  void mockcSaveCurrentAccountError() {
    mockSaveCurrentAccountCall().thenThrow(DomainError.unexpected);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    saveCurrentAccount = SaveCurrentAccountSpy();
    sut = GetxLoginPresenter(
      validation: validation, 
      authentication: authentication,
      saveCurrentAccount: saveCurrentAccount
    );
    email = faker.internet.email();
    password = faker.internet.password();
    accessToken = faker.guid.guid();
    mockValidation();
    mockcAuthentication();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: ValidationError.invalidField);

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit invalidFieldError if email is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit requiredFieldError if email is empty', () {
    mockValidation(value: ValidationError.requiredField);

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
    sut.validatePassword(password);

    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit requiredFieldError if password is empty', () {
    mockValidation(value: ValidationError.requiredField);

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
    mockValidation(field: 'email', value: ValidationError.invalidField);

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

    verify(authentication.auth(AuthenticationParams(email: email, secret: password))).called(1);
  });  

  test('Should call SaveCurrentAccount with correct values', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();

    verify(saveCurrentAccount.save(AccountEntity(accessToken: accessToken))).called(1);
  });  

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async {
    mockcSaveCurrentAccountError();
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream.listen((error) {
      if(error != null)
        expect(error, UIError.unexpected);
      else 
        expect(error, null);
     });

    await sut.auth();
  });

  test('Should emit correct events on Authetication success', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emits(true));
    
    await sut.auth();
  }); 

  test('Should change page on success', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/products')));

    await sut.auth();
  }); 

  test('Should emit correct events on InvalidCredentialsError', () async {
    mockcAuthenticationError(DomainError.invalidCredentials);
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream.listen((error) {
      if(error != null)
        expect(error, UIError.invalidCredentials);
      else 
        expect(error, null);
     });
  
    await sut.auth();
  }); 

  test('Should emit correct events on UnexpectedError', () async {
    mockcAuthenticationError(DomainError.unexpected);
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream.listen((error) {
      if(error != null)
        expect(error, UIError.unexpected);
      else 
        expect(error, null);
     });

    await sut.auth();
  });   

}