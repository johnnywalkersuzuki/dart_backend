import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServeHandler {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response(
        200,
        body: '<h1>Primeira Rota</h1>',
        headers: {'content-type': 'text/html'},
      );
    });
    // http://localhost:8080/ola/mundo
    // ola mundo
    // Aula 4
    router.get('/ola/mundo/<usuario>', (Request req, String usuario) {
      return Response.ok("Olá, mundo, $usuario!");
    });

    // Aula 5
    // router.post('/login', (Request req) {
    //   //Se usuário == admin e senha == 123
    //   return Response.ok('Bem vindo, admin!');
    // });

    // Aula 6
    // http://localhost:8080/query?
    router.get('/query', (Request req) {
      String? nome = req.url.queryParameters['nome'];
      String? idade = req.url.queryParameters['idade'];
      return Response.ok("A query eh: Nome: '$nome', Idade: '$idade' anos");
    });

    // Aula 7
    router.post('/login', (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);

      var usuario = json['usuario'];
      var senha = json['senha'];
      // Se usuário == admin e senha == 123
      // if (usuario == 'admin' && senha == '123') {
      //   return Response.ok('Bem vindo, $usuario');
      // } else {
      //   return Response.forbidden('Acesso negado');
      // }

      if (usuario == 'admin' && senha == '123') {
        Map result = {'token': 'token123', 'user_id': 1};
        String jsonResponse = jsonEncode(result);
        return Response.ok(
          jsonResponse,
          headers: {'content-type': 'application/json'},
        );
      } else {
        return Response.forbidden('Acesso negado');
      }
    });

    return router;
  }
}
