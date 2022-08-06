import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {

  final String accessToken;
  
  AccountEntity({required this.accessToken});

  List get props => [accessToken];

}