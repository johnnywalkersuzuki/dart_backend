import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service_imp.dart';
import 'services/noticia_service.dart';
import 'utils/custom_env.dart';

void main() async {
  //Aula 8 - Cascade para conseguir chamar em cascata diferentes handlers
  var cascadeHandler = Cascade()
      //Aula 16 está passando o Token para a API de Login
      .add(LoginApi(SecurityServiceImp()).handler)
      .add(BlogApi(NoticiaService()).handler)
      .handler;

  // Adicionando um middleware para fazer o nosso log
  var handler = Pipeline()
      .addMiddleware(logRequests())
      // Aula 18 insere a autorização
      .addMiddleware(MiddlewareInterception().middleware)
      .addMiddleware(SecurityServiceImp().authorization)
      // Aula 19 verifica a JWT após inserir a autorização
      .addMiddleware(SecurityServiceImp().verifyJWT)
      .addHandler(cascadeHandler);

  // CustomServer().initialize(handler);
  // print('Hora local em ms:');
  // print(DateTime.now().millisecondsSinceEpoch.toString());

  // Aula 9 - chamar do .env as variáveis
  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
