import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

abstract class AddAccount {
  Future<AccountEntity> add(AddAccountParams params);
}

class AddAccountParams extends Equatable {
    final String name; 
    final String email;
    final String password; 
    final String passwordConfirmation; 
    final bool admin;

    @override
    List get props => [name, email, password, passwordConfirmation, admin];

    AddAccountParams({
      required this.name,
      required this.email, 
      required this.password,
      required this.passwordConfirmation,
      required this.admin
    });

}