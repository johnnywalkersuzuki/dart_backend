// Aula 13 - Criando extensão de lista criando firstWhereOrNull
//  para ser utilizado na lista de save em NoticiaService

extension ListExtension<E> on List<E> {
  firstWhereOrNull(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
