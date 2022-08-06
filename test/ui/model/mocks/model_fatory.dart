import 'package:delivery_micros_services/ui/pages/views_models/views_models.dart';

class ModelFactory {
  static List<ProductViewModel> makeViewModel() => [
        ProductViewModel(
          id: 1002,
          name: 'Bíblia atualizada',
          description: 'Bíblia atualizada de Almeida e Corrigida',
          imgUrl: 'https://source.unsplash.com/640x480',
          quantityAvailable: 8,
          createdAt: '01/08/2022 12:00:00',
          price: 92.28,
          supplier:
              SupplierViewModel(id: 1000, name: 'Sociedade Bíblica do Brasil'),
          category: CategoryViewModel(id: 1000, description: 'Bíblia'),
        ),
        ProductViewModel(
          id: 1002,
          name: 'Bíblia Pentecostal',
          description: 'Bíblia Pentecostal atualizada de Almeida e Corrigida',
          imgUrl: 'https://source.unsplash.com/640x480',
          quantityAvailable: 8,
          createdAt: '28/07/2022 08:00:00',
          price: 135.98,
          supplier:
              SupplierViewModel(id: 1000, name: 'Sociedade Bíblica do Brasil'),
          category: CategoryViewModel(id: 1000, description: 'Bíblia'),
        ),
      ];
}
