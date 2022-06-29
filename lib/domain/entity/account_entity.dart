class AccountEntity {

  final String accessToken;
  
  AccountEntity(this.accessToken);

  factory AccountEntity.fromJson(Map json) => AccountEntity(json['accessToken']);

}