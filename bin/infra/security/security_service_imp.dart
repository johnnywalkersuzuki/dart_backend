import '../../utils/custom_env.dart';
import 'security_service.dart';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

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
  validateJWT(String token) {
    // TODO: implement validateJWT
    throw UnimplementedError();
  }
}
