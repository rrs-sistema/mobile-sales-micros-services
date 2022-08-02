import 'package:meta/meta.dart';
import 'package:get/get.dart';

import './../../../domain/entities/entities.dart';
import './../../../domain/usecases/usecases.dart';
import './../../../domain/helpers/helpers.dart';
import './../../model/model.dart';
import './../../http/http.dart';

class RemoteLoadProducts implements LoadProducts {
  final Uri uri;
  final HttpClient httpClient;

  RemoteLoadProducts({@required this.uri, @required this.httpClient});

  final _navigateTo = RxString();

  Stream<String> get navigateToStream => _navigateTo.stream;

  Future<List<ProductEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(uri: uri, method: 'get');
      return httpResponse.map<ProductEntity>((json) => RemoteProductModel.fromJson(json).toEntity()).toList();
    } on HttpError catch(error) {
      throw error == HttpError.forbidden
        ? DomainError.accessDenied
        : DomainError.unexpected;
    }
  }

}