import 'package:meta/meta.dart';

import '../../../domain/usecases/usecases.dart';
import '../../../domain/helpers/helpers.dart';
import '../../http/http.dart';

class RemoteAddAccount{
  final HttpClient httpClient;
  final Uri uri;

  RemoteAddAccount({@required this.httpClient, @required this.uri});

  Future<void> add(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    try {
      await httpClient.request(uri: uri, method: 'post', body: body);
    } on HttpError catch(error) {
       throw error == HttpError.forbidden ? DomainError.emailInUse :DomainError.unexpected;
    }
  }
}

class RemoteAddAccountParams {
    final String name;
    final String email;
    final String password; 
    final String passwordConfirmation; 
    final bool admin; 

    RemoteAddAccountParams({
      @required this.name, 
      @required this.email, 
      @required this.password,
      @required this.passwordConfirmation,
      @required this.admin
    });

    factory RemoteAddAccountParams.fromDomain(AddAccountParams params) => 
      RemoteAddAccountParams(
        name: params.name, 
        email: params.email, 
        password: params.password, 
        passwordConfirmation: params.passwordConfirmation, 
        admin: params.admin
      );

    Map toJson() => {'name': name, 'email': email, 'password': password, 'admin': admin, 'passwordConfirmation': passwordConfirmation};

}