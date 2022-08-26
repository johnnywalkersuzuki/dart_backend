import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'server_handler.dart';

void main() async {
  // Aula 4
  // Usando o pacote do Shelf_io para dar o retorno do server
  var _server = ServeHandler();

  final server = await shelf_io.serve(_server.handler, 'localhost', 8080);

  // Aula 3
  // final my_server = await shelf_io.serve(
  // (request) => Response(200, body: 'status 200 ok'), 'localhost', 8080);
  print("Servidor inicado em http://localhost:8080");
}
