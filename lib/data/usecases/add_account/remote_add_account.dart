import '../../../domain/usecases/usecases.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../model/model.dart';
import '../../http/http.dart';

class RemoteAddAccount implements AddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({required this.httpClient, required this.url});

  Future<AccountEntity> add(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    try {
      final adminString = params.admin.toString();
      body.update('admin', (value) => adminString);
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body);
      return RemoteAccountModel.fromJson(httpResponse).toEntity();
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
      required this.name, 
      required this.email, 
      required this.password,
      required this.passwordConfirmation,
      required this.admin
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