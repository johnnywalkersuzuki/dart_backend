import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';

class LoginApi {
  final SecurityService _securityService;
  LoginApi(this._securityService);

  Handler get handler {
    Router router = Router();
    //Aqui entram as rotas
    router.post('/login', (Request req) async {
      //return Response.ok('API de Login');
      // Aula 16 passando a Token
      //return Response.ok(await _securityService.generateJWT('1'));
      // Aula 17 testar a implementação do validateJWT
      var token = await _securityService.generateJWT('1');
      var result = await _securityService.validateJWT(token);
      //return Response.ok((result != null).toString());
      return Response.ok(token);
    });

    return router;
  }
}
