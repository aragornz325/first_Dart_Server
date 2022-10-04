import '../data/fake_data.dart';

import '../models/products_models.dart';

class ProductsServices {
  Future<List<ProductModel>> findAllProducts() async {
    await Future.delayed(Duration(milliseconds: 500));
    final List<ProductModel> allProducts =
        products.map((productMap) => ProductModel.fromMap(productMap)).toList();
    return allProducts;
  }

  Future<ProductModel> findProductById(int id) async {
    await Future.delayed(Duration(milliseconds: 500));
    final List<ProductModel> allProducts =
        products.map((productMap) => ProductModel.fromMap(productMap)).toList();
    final productSelect = allProducts.firstWhere((product) => product.id == id);
    print(productSelect);
    if (productSelect == null) {
      throw Exception('No se encontro el producto');
    }
    return productSelect;
  }
}
