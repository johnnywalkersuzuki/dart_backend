import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';

void main() async {
  //Aula 8 - Cascade para conseguir chamar em cascata diferentes handlers
  var cascadeHandler =
      Cascade().add(LoginApi().handler).add(BlogApi().handler).handler;

  // Adicionando um middleware para fazer o nosso log
  var handler =
      Pipeline().addMiddleware(logRequests()).addHandler(cascadeHandler);

  CustomServer().initialize(handler);
}
