import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'utils/custom_env.dart';

void main() async {
  //Aula 8 - Cascade para conseguir chamar em cascata diferentes handlers
  var cascadeHandler =
      Cascade().add(LoginApi().handler).add(BlogApi().handler).handler;

  // Adicionando um middleware para fazer o nosso log
  var handler =
      Pipeline().addMiddleware(logRequests()).addHandler(cascadeHandler);

  // CustomServer().initialize(handler);
  // Aula 9 - chamar do .env as variáveis
  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
