import 'package:mocktail/mocktail.dart';

import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

class LoadProductsSpy extends Mock implements LoadProducts {
  When mockLoadCall() => when(() => this.load());
  void mockLoad(List<ProductEntity> products) => this.mockLoadCall().thenAnswer((_) async => products);
  void mockLoadError(DomainError error) => mockLoadCall().thenThrow(error);
}