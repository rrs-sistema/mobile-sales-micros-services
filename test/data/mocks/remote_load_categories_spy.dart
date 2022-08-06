import 'package:mocktail/mocktail.dart';

import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

class RemoteLoadCategoriesSpy extends Mock implements RemoteLoadCategories {
  When mockLoadCall() => when(() => this.load());
  void mockLoad(List<CategoryEntity> categories) => this.mockLoadCall().thenAnswer((_) async => categories);
  void mockLoadError(DomainError error) => mockLoadCall().thenThrow(error);
}