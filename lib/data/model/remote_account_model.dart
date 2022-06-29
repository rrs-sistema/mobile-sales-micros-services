import 'package:sales_micros_services/domain/entity/entity.dart';

class RemoteAccountModel {

  final String accessToken;
  
  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map json) => RemoteAccountModel(json['accessToken']);

  AccountEntity toEntity() => AccountEntity(accessToken);

}