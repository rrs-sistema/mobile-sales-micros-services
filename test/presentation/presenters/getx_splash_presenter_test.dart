import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/presenters/presenters.dart';
import './../../domain/mocks/mocks.dart';

void main() {
  late GetxSplashPresenter sut;
  late LoadCurrentAccountSpy loadCurrentAccount;

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    loadCurrentAccount.mockLoad(account: EntityFactory.makeAccountEntity());
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);    
  });

 setUpAll(() {
    registerFallbackValue(EntityFactory.makeAccountEntity());
    registerFallbackValue(ParamsFactory.makeAddAccount());
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount(durationInSeconds: 0);

    verify(() => loadCurrentAccount.load()).called(1);
  });

  test('Should go to products page on success', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/base_screen')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on error', () async {
    loadCurrentAccount.mockLoadError();

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });

}