import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class LoginApi {
  Handler get handler {
    Router router = Router();
    //Aqui entram as rotas
    router.post('/login', (Request req) {
      return Response.ok('API de Login');
    });

    return router;
  }
}
