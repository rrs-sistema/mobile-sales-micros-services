abstract class SplashPresenter {
  Stream<String> get navigateToController;

  Future<void> loadCurrentAccount();
}