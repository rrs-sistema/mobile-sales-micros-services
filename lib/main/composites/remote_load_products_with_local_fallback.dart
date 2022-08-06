import 'package:get/get.dart';

import './../../domain/entities/entities.dart';
import './../../domain/usecases/usecases.dart';
import './../../domain/helpers/helpers.dart';
import './../../data/usecases/usecases.dart';

class RemoteLoadProductsWithLocalFallback implements LoadProducts {
  final RemoteLoadProducts remote;
  final LocalLoadProducts local;

  RemoteLoadProductsWithLocalFallback({
    required this.remote,
    required this.local
  });

  final _navigateTo = RxString('');

  Stream<String> get navigateToStream => _navigateTo.stream;

  Future<List<ProductEntity>> load() async {
    try {
      final products = await remote.load();
      await local.save(products);
      return products;
    } catch(error) {
      if (error == DomainError.accessDenied) {
        _navigateTo.value = '/login';
        rethrow;
      }
      await local.validate();
      return await local.load();
    }
  }
}