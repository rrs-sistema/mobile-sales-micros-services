
import 'package:faker/faker.dart';

import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/model/model.dart';

import '../../infra/mocks/cache_factory.dart';

class EntityFactory {
  static AccountEntity makeAccountEntity() => AccountEntity(
        accessToken: faker.guid.guid(),
      );

  static List<ProductEntity> makeProductList() => [
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
          category: CategoryEntity(id: 1000, description: 'Bíblia'),
        ),
      ];

  static List<ProductEntity> makeCacheJsonToListProductEntity() => [
        ProductEntity(
            id: int.parse(CacheFactory.makeProducts()[0]['id']),
            name: CacheFactory.makeProducts()[0]['name'],
            description: CacheFactory.makeProducts()[0]['description'],
            imgUrl: CacheFactory.makeProducts()[0]['imgUrl'],
            quantityAvailable:
                int.parse(CacheFactory.makeProducts()[0]['quantityAvailable']),
            createdAt: CacheFactory.makeProducts()[0]['createdAt'],
            price: double.parse(CacheFactory.makeProducts()[0]['price']),
            supplier:
                LocalSupplierModel.fromJson(CacheFactory.makeProducts()[0]['supplier'])
                    .toEntity(),
            category:
                LocalCategoryModel.fromJson(CacheFactory.makeProducts()[0]['category'])
                    .toEntity()),
        ProductEntity(
            id: int.parse(CacheFactory.makeProducts()[1]['id']),
            name: CacheFactory.makeProducts()[1]['name'],
            description: CacheFactory.makeProducts()[1]['description'],
            imgUrl: CacheFactory.makeProducts()[1]['imgUrl'],
            quantityAvailable:
                int.parse(CacheFactory.makeProducts()[1]['quantityAvailable']),
            createdAt: CacheFactory.makeProducts()[1]['createdAt'],
            price: double.parse(CacheFactory.makeProducts()[1]['price']),
            supplier:
                LocalSupplierModel.fromJson(CacheFactory.makeProducts()[1]['supplier'])
                    .toEntity(),
            category:
                LocalCategoryModel.fromJson(CacheFactory.makeProducts()[1]['category'])
                    .toEntity()),
      ];      
}
