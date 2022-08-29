import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../services/generic_service.dart';
import '../services/noticia_service.dart';

class BlogApi {
  // final NoticiaService _service;
  // Usando o DIP, podemos usar o Genérico
  final GenericService _service;

  BlogApi(this._service);

  Handler get handler {
    Router router = Router();

    // Listagem
    router.get('/blog/noticias', (Request req) {
      // _service.findAll();
      return Response.ok('Choveu ontem com get');
    });

    // Nova notícias
    router.post('/blog/noticias', (Request req) {
      // _service.save(1);
      return Response.ok('Choveu agora com post');
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
