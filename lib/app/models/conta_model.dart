import 'dart:convert';

class ContaModel {
  final int id;
  final int conta;
  final double saldo;
  final int idbanco;
  ContaModel({
    required this.id,
    required this.conta,
    required this.saldo,
    required this.idbanco,
  });

  ContaModel copyWith({
    int? id,
    int? conta,
    double? saldo,
    int? idbanco,
  }) {
    return ContaModel(
      id: id ?? this.id,
      conta: conta ?? this.conta,
      saldo: saldo ?? this.saldo,
      idbanco: idbanco ?? this.idbanco,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conta': conta,
      'saldo': saldo,
      'idbanco': idbanco,
    };
  }

  factory ContaModel.fromMap(Map<String, dynamic> map) {
    return ContaModel(
      id: map['id'],
      conta: map['conta'],
      saldo: map['saldo'],
      idbanco: map['idbanco'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContaModel.fromJson(String source) =>
      ContaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContaModel(id: $id, conta: $conta, saldo: $saldo, idbanco: $idbanco)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContaModel &&
        other.id == id &&
        other.conta == conta &&
        other.saldo == saldo &&
        other.idbanco == idbanco;
  }

  @override
  int get hashCode {
    return id.hashCode ^ conta.hashCode ^ saldo.hashCode ^ idbanco.hashCode;
  }
}
