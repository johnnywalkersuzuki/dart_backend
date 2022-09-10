import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';

import 'api.dart';

//class LoginApi {
// Aula 21 - Customizando com os Middlewares customizados por API
class LoginApi extends Api {
  final SecurityService _securityService;
  LoginApi(this._securityService);

  // Handler get handler {
  // }

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
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

    // return router;
    // Aula 21, ao invés do router, passar com o createHandler passando o router
    return createHandler(
      router: router,
      middlewares: middlewares,
    );
  }
}
