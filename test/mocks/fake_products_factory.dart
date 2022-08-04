import 'package:delivery_micros_services/domain/entities/product_entity.dart';
import 'package:delivery_micros_services/ui/pages/categories/categories.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/model/model.dart';

class FakeProductsFactory {
  static List<Map> makeCacheJson() => [
        {
          'id': '1002',
          'name': 'Bíblia atualizada',
          'description': 'Bíblia atualizada de Almeida e Corrigida',
          'quantityAvailable': '8',
          'createdAt': '01/08/2022 12:00:00',
          "price": '92.28',
          'imgUrl': 'https://source.unsplash.com/640x480',
          "supplier": {
            "id": '1000',
            "name": 'Sociedade Bíblica do Brasil',
          },
          "category": {
            "id": '1000',
            "description": 'Bíblia',
          },
        },
        {
          'id': '1002',
          'name': 'Bíblia Pentecostal',
          'description': 'Bíblia Pentecostal atualizada de Almeida e Corrigida',
          'quantityAvailable': '8',
          'createdAt': '28/07/2022 08:00:00',
          "price": '135.98',
          'imgUrl': 'https://source.unsplash.com/640x480',
          "supplier": {
            "id": '1000',
            "name": 'Sociedade Bíblica do Brasil',
          },
          "category": {
            "id": '1000',
            "description": 'Bíblia',
          },
        }
      ];

  static List<Map<String, dynamic>> makeSaveCacheJson() => [
        {
          "id": "1002",
          "name": "Bíblia atualizada",
          "description": "Bíblia atualizada de Almeida e Corrigida",
          "imgUrl": 'https://source.unsplash.com/640x480',
          "quantityAvailable": "8",
          "createdAt": "01/08/2022 12:00:00",
          "price": "92.28",
          "supplier": {
            "id": "1000",
            "name": "Sociedade Bíblica do Brasil",
          },          
          "category": {
            "id": "1000",
            "description": "Bíblia",
          },
        },
        {
          "id": "1002",
          "name": "Bíblia Pentecostal",
          "description": "Bíblia Pentecostal atualizada de Almeida e Corrigida",
          "imgUrl": 'https://source.unsplash.com/640x480',
          "quantityAvailable": "8",
          "createdAt": "28/07/2022 08:00:00",
          "price": "135.98",
          "category": {
            "id": "1000",
            "description": "Bíblia",
          },
          "supplier": {
            "id": "1000",
            "name": "Sociedade Bíblica do Brasil",
          },
        },
      ];

  static List<Map> makeInvalidCacheJson() => [
        {
          "id": 'invalid id',
          'name': 'Bíblia atualizada',
          'description': 'Bíblia atualizada de Almeida e Corrigida',
          "quantityAvailable": 'invalid price',
          'createdAt': '01/08/2022 12:00:00',
          "price": 'invalid price',
          'imgUrl': 'https://source.unsplash.com/640x480',
          "supplier": {
            "id": '1000',
            "name": 'Sociedade Bíblica do Brasil',
          },
          "category": {
            "id": '1000',
            "description": 'Bíblia',
          },
        },
      ];

  static List<Map> makeIncompleteCacheJson() => [
        {
          'id': '1002',
          'name': 'Bíblia atualizada',
          'description': 'Bíblia atualizada de Almeida e Corrigida',
          'quantityAvailable': '8',
          'createdAt': '01/08/2022 12:00:00',
          "price": '92.28',
          'imgUrl': 'https://source.unsplash.com/640x480',
        }
      ];

  static List<ProductEntity> makeCacheJsonToListProductEntity() => [
        ProductEntity(
            id: int.parse(makeCacheJson()[0]['id']),
            name: makeCacheJson()[0]['name'],
            description: makeCacheJson()[0]['description'],
            imgUrl: makeCacheJson()[0]['imgUrl'],
            quantityAvailable:
                int.parse(makeCacheJson()[0]['quantityAvailable']),
            createdAt: makeCacheJson()[0]['createdAt'],
            price: double.parse(makeCacheJson()[0]['price']),
            supplier:
                LocalSupplierModel.fromJson(makeCacheJson()[0]['supplier'])
                    .toEntity(),
            category:
                LocalCategoryModel.fromJson(makeCacheJson()[0]['category'])
                    .toEntity()),
        ProductEntity(
            id: int.parse(makeCacheJson()[1]['id']),
            name: makeCacheJson()[1]['name'],
            description: makeCacheJson()[1]['description'],
            imgUrl: makeCacheJson()[1]['imgUrl'],
            quantityAvailable:
                int.parse(makeCacheJson()[1]['quantityAvailable']),
            createdAt: makeCacheJson()[1]['createdAt'],
            price: double.parse(makeCacheJson()[1]['price']),
            supplier:
                LocalSupplierModel.fromJson(makeCacheJson()[1]['supplier'])
                    .toEntity(),
            category:
                LocalCategoryModel.fromJson(makeCacheJson()[1]['category'])
                    .toEntity()),
      ];

  static List<ProductEntity> makeEntities() => [
        ProductEntity(
          id: 1002,
          name: 'Bíblia atualizada',
          description: 'Bíblia atualizada de Almeida e Corrigida',
          imgUrl: 'https://source.unsplash.com/640x480',
          quantityAvailable: 8,
          createdAt: '01/08/2022 12:00:00',
          price: 92.28,
          supplier:
              SupplierEntity(id: 1000, name: 'Sociedade Bíblica do Brasil'),
          category: CategoryEntity(id: 1000, description: 'Bíblia'),
        ),
        ProductEntity(
            id: 1002,
            name: 'Bíblia Pentecostal',
            description: 'Bíblia Pentecostal atualizada de Almeida e Corrigida',
            imgUrl: 'https://source.unsplash.com/640x480',
            quantityAvailable: 8,
            createdAt: '28/07/2022 08:00:00',
            price: 135.98,
            supplier:
                SupplierEntity(id: 1000, name: 'Sociedade Bíblica do Brasil'),
            category: CategoryEntity(id: 1000, description: 'Bíblia')),
      ];

  static List<ProductViewModel> makeViewModel() => [
        ProductViewModel(
            id: 1002,
            name: 'Bíblia atualizada',
            description: 'Bíblia atualizada de Almeida e Corrigida',
            imgUrl: 'https://source.unsplash.com/640x480',
            quantityAvailable: 8,
            createdAt: '01/08/2022 12:00:00',
            price: 92.28,
            supplier: SupplierViewModel(
                id: 1000, name: 'Sociedade Bíblica do Brasil'),
            category: CategoryViewModel(id: 1000, description: 'Bíblia')),
        ProductViewModel(
            id: 1002,
            name: 'Bíblia Pentecostal',
            description: 'Bíblia Pentecostal atualizada de Almeida e Corrigida',
            imgUrl: 'https://source.unsplash.com/640x480',
            quantityAvailable: 8,
            createdAt: '28/07/2022 08:00:00',
            price: 135.98,
            supplier: SupplierViewModel(
                id: 1000, name: 'Sociedade Bíblica do Brasil'),
            category: CategoryViewModel(id: 1000, description: 'Bíblia')),
      ];

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
        }
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

  static List<Map> makeInvalidApiJson() => [
        {'invalid_key': 'invalid_value'}
      ];
}
