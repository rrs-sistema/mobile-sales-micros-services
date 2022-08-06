import 'package:mocktail/mocktail.dart';

import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

class LocalLoadProductsSpy extends Mock implements LocalLoadProducts {
  LocalLoadProductsSpy() {
    this.mockValidate();
  }

  When mockLocalCall() => when(() => this.load());
  void mockLoad(List<ProductEntity> products) => this.mockLocalCall().thenAnswer((_) async => products);
  void mockLoadError() => mockLocalCall().thenThrow(DomainError.unexpected);

  When mockValidateCall() => when(() => this.validate());
  void mockValidate() => this.mockValidateCall().thenAnswer((_) async => _);
  void mockValidateError() => mockValidateCall().thenThrow(Exception());

  When mockSaveCall() => when(() => this.save(any()));
  void mockSave() => this.mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => mockSaveCall().thenThrow(Exception());
}