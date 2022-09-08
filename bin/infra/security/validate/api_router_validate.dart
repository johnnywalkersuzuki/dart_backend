class ApiRouterValidate {
  // Aula 20 Validador de rotas

  //Deixar construtor privado
  // ApiRouterValidate._();

  final List<String> _rotas = [];

  // Builder de rota
  ApiRouterValidate add(String rota) {
    _rotas.add(rota);
    return this;
  }

  // bool validate() {
  //   // return _rotas.contains(element)
  // }

  // Método de verificação se a rota é pública
  bool isPublic(String rota) {
    return _rotas.contains(rota);
  }
}
