import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServeHandler {
  Handler get handler {
    final router = Router();
    // Aula 4 Primeira rotta GET no raiz
    router.get('/', (Request request) {
      // return Response(200, body: 'Primeira rota');
      // Aula 6 retornando em HTML
      return Response(200,
          body: '<h1>Primeira rota</h1>',
          headers: {'content-type': 'text/html'});
    });
    // Aula 5 - Usando Get
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

    // Aula 6 - trabalhando com POST e JSON
    router.post('/login', (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);

      var usuario = json['usuario'];
      var senha = json['senha'];

      //Se usuário == admin e senha == 123
      if (usuario == 'admin' && senha == '123') {
        Map result = {'token': 'token123', 'user_id': 2};
        String jsonResponse = jsonEncode(result);
        return Response.ok(jsonResponse,
            headers: {'content-type': 'application/json'});
        // return Response.ok('Bem vindo, $usuario');
      } else {
        return Response.forbidden('Acesso negado');
      }
    });

    return router;
  }
}
