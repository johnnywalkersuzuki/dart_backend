import 'package:shelf/shelf.dart';
import 'package:shelf/src/middleware.dart';

import '../../utils/custom_env.dart';
import 'security_service.dart';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

//import 'validate/api_router_validate.dart';

class SecurityServiceImp implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userID) async {
    var jwt = JWT({
      'iat': DateTime.now().millisecondsSinceEpoch,
      'userID': userID,
      'roles': ['admin', 'user']
    });

    // Recupera a key do arquivo .env
    String key = await CustomEnv.get(key: 'jwt_key');
    // Recupera o Token criado pela JWT
    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    String key = await CustomEnv.get(key: 'jwt_key');

    // Tratamento de cada uma das exceções do JWT
    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidError {
      return null;
    } on JWTExpiredError {
      return null;
    } on JWTNotActiveError {
      return null;
    } on JWTUndefinedError {
      return null;
    } catch (e) {
      return null;
    }
  }

  // Aula 18 Implementando Middlewares de autorização e verificação de Token para APIs
  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        String? authorizationHeader = req.headers['Authorization'];

        JWT? jwt;

        if (authorizationHeader != null) {
          if (authorizationHeader.startsWith('Bearer ')) {
            String token = authorizationHeader.substring(7);
            jwt = await validateJWT(token);
          }
        }
        // Se não tiver um valor, o JWT vai ser adicionado nulo, senão preenche
        var request = req.change(context: {'jwt': jwt});
        return handler(request);
      };
    };
  }

  @override
  Middleware get verifyJWT => createMiddleware(
        requestHandler: (Request req) {
          // Aula 21 14:46 deixar restrito
          // //Aula 20 Testando o verificador de rota com Builder
          // //_ApiSecurity _apiSecurity = _ApiSecurity();
          // // ignore: no_leading_underscores_for_local_identifiers
          // var _apiSecurity = ApiRouterValidate()
          //     .add('login')
          //     .add('xpto')
          //     .add('register')
          //     .add('qualquer');

          // if (_apiSecurity.isPublic(req.url.path)) return null;
          // //Aula 20 uma injeção do login
          // //if (req.url.path == 'login') return null;

          if (req.context['jwt'] == null) {
            return Response.forbidden('Access denied');
          }
          return null;
        },
      );
}
