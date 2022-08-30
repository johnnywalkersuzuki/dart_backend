class NoticiaModel {
  final int id;
  final String titulo;
  final String descricao;
  final String imagem;
  final DateTime dtPublicacao;
  final DateTime? dtAtualizacao;
  // VS CODE criar construtor para campos final
  NoticiaModel(
    this.id,
    this.titulo,
    this.descricao,
    this.imagem,
    this.dtPublicacao,
    this.dtAtualizacao,
  );

  //Factory
  factory NoticiaModel.fromJson(Map map) {
    return NoticiaModel(
      map['id'] ?? '',
      map['titulo'],
      map['descricao'],
      map['imagem'],
      DateTime.fromMicrosecondsSinceEpoch(map['dtPublicacao']),
      map['dtAtualizacao'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(map['dtAtualizacao'])
          : null,
    );
  }
  Map toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'imagem': imagem
    };
  }

  // VS CODE Generate toString
  @override
  String toString() {
    return 'NoticiaModel(id: $id, titulo: $titulo, descricao: $descricao, imagem: $imagem, dtPublicacao: $dtPublicacao, dtAtualizacao: $dtAtualizacao)';
  }
}
