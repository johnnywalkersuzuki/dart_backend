import 'package:shelf/shelf.dart';

abstract class SecurityService<T> {
  Future<String> generateJWT(String userID);
  Future<T?> validateJWT(String token);

  //Aula 18 - Implantando Middlewares de segurança JWT
  Middleware get verifyJWT;
  Middleware get authorization;
}
