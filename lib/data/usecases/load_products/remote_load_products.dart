import './../../../domain/entities/entities.dart';
import './../../../domain/usecases/usecases.dart';
import './../../../domain/helpers/helpers.dart';
import './../../model/model.dart';
import './../../http/http.dart';

class RemoteLoadProducts implements LoadProducts {
  final String url;
  final HttpClient httpClient;

  RemoteLoadProducts({required this.url, required this.httpClient});

  Future<ProductEntity> loadById(int id) async {
    try {
      final _url = '$url/$id';
      final httpResponse = await httpClient.request(url: _url, method: 'get');
      return RemoteProductModel.fromJson(httpResponse).toEntity();
    } on HttpError catch(error) {
      throw error == HttpError.forbidden ? DomainError.accessDenied : error == HttpError.unauthorized ? DomainError.accessDenied : DomainError.unexpected;
    }
  }

  Future<List<ProductEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      return httpResponse.map<ProductEntity>((json) => RemoteProductModel.fromJson(json).toEntity()).toList();
    } on HttpError catch(error) {
      throw error == HttpError.forbidden ? DomainError.accessDenied : error == HttpError.unauthorized ? DomainError.accessDenied : DomainError.unexpected;
    }
  }
  
}