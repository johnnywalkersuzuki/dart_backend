import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

void main() async {
  // Aula 3
  final server = await shelf_io.serve(
      (request) => Response(200, body: 'status 200 ok'), 'localhost', 8080);
  print("Servidor inicado em http://localhost:8080");
}
