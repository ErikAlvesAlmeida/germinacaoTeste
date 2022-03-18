class Germinacao {
  int id;
  double sementesGerminadas;
  double totalSementes;
  double germinacao;

  Germinacao(
      {this.id, this.sementesGerminadas, this.totalSementes, this.germinacao});

  Germinacao.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        sementesGerminadas = res["sementesGerminadas"],
        totalSementes = res["totalSementes"],
        germinacao = res["germinacao"];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'sementesGerminadas': sementesGerminadas,
      'totalSementes': totalSementes,
      'germinacao': calcGerminacao()
    };
  }

  double calcGerminacao() {
    return ((this.sementesGerminadas / this.totalSementes) * 100);
  }
}
