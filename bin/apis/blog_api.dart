import 'dart:convert';
import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/noticia_model.dart';
import '../services/generic_service.dart';

class BlogApi {
  // final NoticiaService _service;
  // Usando o DIP, podemos usar o Genérico
  final GenericService<NoticiaModel> _service;

  BlogApi(this._service);

  Handler get handler {
    Router router = Router();

    // Listagem
    router.get('/blog/noticias', (Request req) {
      List<NoticiaModel> noticias = _service.findAll();
      //return Response.ok(noticias.toString());
      // Retornando em JSON
      List<Map> noticiasMap = noticias.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(noticiasMap),
          headers: {'content-type': 'application/json'});
      //return Response.ok('Choveu ontem com get');
    });

    // Nova notícias
    router.post('/blog/noticias', (Request req) async {
      // _service.save(1);
      var body = await req.readAsString();

      //return Response.ok('Choveu agora com post');
      _service.save(NoticiaModel.fromJson(jsonDecode(body)));
      return Response(201);
    });

    // blog/noticias?id=1 // update
    router.put('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      // _service.save(2);
      return Response.ok('Noticia $id: choveu por horas com put');
    });

    // blog/noticias?id=1 // delete
    router.delete('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      // _service.delete(1);
      return Response.ok('Apagaram a notícia $id que diz que chovia');
    });

    return router;
  }
}
