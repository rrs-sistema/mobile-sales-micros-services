import './../../../domain/entities/entities.dart';
import './../../../domain/usecases/usecases.dart';
import './../../../domain/helpers/helpers.dart';
import './../../model/model.dart';
import './../../http/http.dart';

class RemoteLoadProducts implements LoadProducts {
  final String url;
  final HttpClient httpClient;

  RemoteLoadProducts({required this.url, required this.httpClient});

  Future<List<ProductEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      return httpResponse.map<ProductEntity>((json) => RemoteProductModel.fromJson(json).toEntity()).toList();
    } on HttpError catch(error) {
      throw error == HttpError.forbidden ? DomainError.accessDenied : DomainError.unexpected;
    }
  }

}