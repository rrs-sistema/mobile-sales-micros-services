import 'package:meta/meta.dart';

import './../../../domain/entities/entities.dart';
import './../../../domain/usecases/usecases.dart';
import './../../../domain/helpers/helpers.dart';
import './../../model/model.dart';
import './../../http/http.dart';

class RemoteLoadCategories implements LoadCategories {
  final Uri uri;
  final HttpClient httpClient;

  RemoteLoadCategories({@required this.uri, @required this.httpClient});

  Future<List<CategoryEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(uri: uri, method: 'get');
      return httpResponse.map<CategoryEntity>((json) => RemoteCategoryModel.fromJson(json).toEntity()).toList();      
    } on HttpError catch(error) {
       throw error == HttpError.forbidden ? DomainError.accessDenied :DomainError.unexpected;
    }
  }
}