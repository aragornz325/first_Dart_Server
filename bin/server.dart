import 'dart:io';
import 'dart:developer';

import 'package:dart_application_1/src/controller/products_controller.dart';
import 'package:dart_application_1/src/services/products_services.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router();

void main(List<String> args) async {
  final ProductsServices _productsServices = ProductsServices();
  final ProductsController _productsController =
      ProductsController(_productsServices);

  _router.get('/products', _productsController.getAllProducts);
  _router.get('/products/<id>', _productsController.getProductById);
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
