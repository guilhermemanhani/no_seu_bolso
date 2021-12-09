import 'dart:convert';

class ExpenseModel {
  final int idlancamento;
  final double valor;
  final DateTime datahora;
  final String? descricao;
  final int idconta;
  final int localid;
  final int? motivoid;
  final String? local;
  final String? motivo;
  final String? instituicao;

  ExpenseModel({
    required this.idlancamento,
    required this.valor,
    required this.datahora,
    this.descricao,
    required this.idconta,
    required this.localid,
    this.motivoid,
    this.local,
    this.motivo,
    this.instituicao,
  });

  ExpenseModel copyWith({
    int? idlancamento,
    double? valor,
    DateTime? datahora,
    String? descricao,
    int? idconta,
    int? localid,
    int? motivoid,
    String? local,
    String? motivo,
    String? instituicao,
  }) {
    return ExpenseModel(
      idlancamento: idlancamento ?? this.idlancamento,
      valor: valor ?? this.valor,
      datahora: datahora ?? this.datahora,
      descricao: descricao ?? this.descricao,
      idconta: idconta ?? this.idconta,
      localid: localid ?? this.localid,
      motivoid: motivoid ?? this.motivoid,
      local: local ?? this.local,
      motivo: motivo ?? this.motivo,
      instituicao: instituicao ?? this.instituicao,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idlancamento': idlancamento,
      'valor': valor,
      'datahora': datahora.millisecondsSinceEpoch,
      'descricao': descricao,
      'idconta': idconta,
      'localid': localid,
      'motivoid': motivoid,
      'local': local,
      'motivo': motivo,
      'instituicao': instituicao,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      idlancamento: map['idlancamento'],
      valor: map['valor'],
      datahora: DateTime.fromMillisecondsSinceEpoch(map['datahora']),
      descricao: map['descricao'],
      idconta: map['idconta'],
      localid: map['localid'],
      motivoid: map['motivoid'],
      local: map['local'],
      motivo: map['motivo'],
      instituicao: map['instituicao'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpenseModel(idlancamento: $idlancamento, valor: $valor, datahora: $datahora, descricao: $descricao, idconta: $idconta, localid: $localid, motivoid: $motivoid, local: $local, motivo: $motivo, instituicao: $instituicao)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseModel &&
        other.idlancamento == idlancamento &&
        other.valor == valor &&
        other.datahora == datahora &&
        other.descricao == descricao &&
        other.idconta == idconta &&
        other.localid == localid &&
        other.motivoid == motivoid &&
        other.local == local &&
        other.motivo == motivo &&
        other.instituicao == instituicao;
  }

  @override
  int get hashCode {
    return idlancamento.hashCode ^
        valor.hashCode ^
        datahora.hashCode ^
        descricao.hashCode ^
        idconta.hashCode ^
        localid.hashCode ^
        motivoid.hashCode ^
        local.hashCode ^
        motivo.hashCode ^
        instituicao.hashCode;
  }
}
