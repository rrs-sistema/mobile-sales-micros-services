import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

import 'package:delivery_micros_services/ui/pages/base_screen/base_screen.dart';
import 'package:delivery_micros_services/ui/pages/products/products.dart';

class ProductsPresenterSpy extends Mock implements ProductsPresenter {}

void main() {
  ProductsPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = ProductsPresenterSpy();
    final basePageScreen = GetMaterialApp(
      initialRoute: '/base_screen',
      getPages: [
        GetPage(
          name: '/base_screen',
          page: () => BasePageScreen(presenter,)),
      ],
    );
    await tester.pumpWidget(basePageScreen);
  }

  testWidgets('Should call LoadProducts on page load', (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });

}
