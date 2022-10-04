import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_application_1/src/services/products_services.dart';
import 'package:shelf/shelf.dart';

import '../models/products_models.dart';

class ProductsController {
  ProductsController(this._productsServices);
  final ProductsServices _productsServices;

  FutureOr<Response> getAllProducts(Request request) async {
    try {
      final List<ProductModel> allProducts =
          await _productsServices.findAllProducts();
      return Response.ok(
          jsonEncode({
            'products': allProducts.map((product) => product.toMap()).toList(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({
        'error': 'no encontre una mierda!, tas seguro???',
      }));
    }
  }

  FutureOr<Response> getProductById(Request request, String id) async {
    final int product_id = int.parse(id);
    try {
      final ProductModel productSelect =
          await _productsServices.findProductById(product_id);
      return Response.ok(
          jsonEncode({
            'product': productSelect.toMap(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({
        'error': 'no encontre una mierda!, tas seguro???',
      }));
    }
  }
}
