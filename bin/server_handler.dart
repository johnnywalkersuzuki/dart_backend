import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServeHandler {
  Handler get handler {
    final router = Router();
    // Aula 4 Primeira rotta GET no raiz
    router.get('/', (Request request) {
      return Response(200, body: 'Primeira rota');
    });

    // http:/localhost:8080/ola/mundo
    // Retorna 'Ola, mundo'

    router.get('/ola/mundo/<usuario>', (Request req, String usuario) {
      return Response.ok("Olá, Mundo, $usuario");
    });

    // http:/localhost:8080/query?nome=Joao&idade=15
    // Retorna 'Query é: Joao, idade 15
    router.get('/query', (Request req) {
      String? nome = req.url.queryParameters['nome'];
      String? idade = req.url.queryParameters['idade'];
      return Response.ok('Query é: nome "$nome", idade: "$idade"');
    });

    return router;
  }
}
