import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class BlogApi {
  Handler get handler {
    Router router = Router();

    // Listagem
    router.get('/blog/noticias', (Request req) {
      return Response.ok('Choveu ontem com get');
    });

    // Nova notícias
    router.post('/blog/noticias', (Request req) {
      return Response.ok('Choveu agora com post');
    });

    // blog/noticias?id=1 // update
    router.put('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      return Response.ok('Noticia $id: choveu por horas com put');
    });

    // blog/noticias?id=1 // delete
    router.delete('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      return Response.ok('Apagaram a notícia $id que diz que chovia');
    });

    return router;
  }
}
