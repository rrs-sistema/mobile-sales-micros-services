import 'package:meta/meta.dart';

import '../../../domain/usecases/usecases.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../model/model.dart';
import '../../http/http.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final Uri uri;

  RemoteAuthentication({@required this.httpClient, @required this.uri});

  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      final httpResponse = await httpClient.request(uri: uri, method: 'post', body: body);
      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch(error) {
       throw error == HttpError.unauthorized ? DomainError.invalidCredentials :DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
    final String email;
    final String password; 

    RemoteAuthenticationParams({
      @required this.email, 
      @required this.password
    });

    factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) => 
      RemoteAuthenticationParams(email: params.email, password: params.secret);

    Map toJson() => {'email': email, 'password': password};

}