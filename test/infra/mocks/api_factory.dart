import 'package:faker/faker.dart';

import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/model/model.dart';

class ApiFactory {
  static Map makeAccountJson() => {
        'accessToken': faker.guid.guid(),
      };

  static List<Map<dynamic, dynamic>> makeApiJson() => [
        {
          'id': 1000,
          'name': 'Bíblia atualizada',
          'description': 'Bíblia atualizada de Almeida e Corrigida',
          'quantity_available': 8,
          'created_at': '01/08/2022 12:00:00',
          "price": 2.28,
          'img_url': 'https://source.unsplash.com/640x480',
          "category": {
            "id": 1000,
            "description": 'Bíblia',
          },
          "supplier": {
            "id": 1000,
            "name": 'Sociedade Bíblica do Brasil',
          },
        },
        {
          'id': 1002,
          'name': 'Bíblia Pentecostal',
          'description': 'Bíblia Pentecostal atualizada de Almeida e Corrigida',
          'quantity_available': 8,
          'created_at': '28/07/2022 08:00:00',
          "price": 135.98,
          'img_url': 'https://source.unsplash.com/640x480',
          "category": {
            "id": 1000,
            "description": 'Bíblia',
          },
          "supplier": {
            "id": 1000,
            "name": 'Sociedade Bíblica do Brasil',
          },
        },
      ];

  static List<ProductEntity> makeApiJsonToListProductEntity() => [
        ProductEntity(
          id: makeApiJson()[0]['id'],
          name: makeApiJson()[0]['name'],
          description: makeApiJson()[0]['description'],
          imgUrl: makeApiJson()[0]['img_url'],
          quantityAvailable: makeApiJson()[0]['quantity_available'],
          createdAt: makeApiJson()[0]['created_at'],
          price: makeApiJson()[0]['price'],
          category: RemoteCategoryModel.fromJson(makeApiJson()[0]['category'])
              .toEntity(),
          supplier: RemoteSupplierModel.fromJson(makeApiJson()[0]['supplier'])
              .toEntity(),
        ),
        ProductEntity(
          id: makeApiJson()[1]['id'],
          name: makeApiJson()[1]['name'],
          description: makeApiJson()[1]['description'],
          imgUrl: makeApiJson()[1]['img_url'],
          quantityAvailable: makeApiJson()[1]['quantity_available'],
          createdAt: makeApiJson()[1]['created_at'],
          price: makeApiJson()[1]['price'],
          category: RemoteCategoryModel.fromJson(makeApiJson()[1]['category'])
              .toEntity(),
          supplier: RemoteSupplierModel.fromJson(makeApiJson()[1]['supplier'])
              .toEntity(),
        ),
      ];

  static List<Map> makeInvalidJson() => [
        {
          'invalid_key': 'invalid_value',
        },
      ];
}
