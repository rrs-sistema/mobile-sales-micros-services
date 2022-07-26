
class ProductEntity {

  final int id;
  final String name;
  final int quantityAvailable;
  final String createdAt;
  final SupplierEntity supplier;
  final CategoryEntity sategory;
  
  ProductEntity({this.id, this.name, this.quantityAvailable, this.createdAt, this.supplier, this.sategory});

}

class CategoryEntity {
  final int id;
  final String description;
  CategoryEntity({this.id, this.description});
}

class SupplierEntity {
  final int id;
  final String name;
  SupplierEntity({this.id, this.name});
}