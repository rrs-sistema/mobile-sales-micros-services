class CacheFactory {
  static List<Map> makeProducts() => [
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
        },
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
        },
      ];
}
