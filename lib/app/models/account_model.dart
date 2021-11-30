import 'dart:convert';

class AccountModel {
  final int id;
  final int conta;
  final double saldo;
  final int idbanco;
  final String? instituicao;

  AccountModel({
    required this.id,
    required this.conta,
    required this.saldo,
    required this.idbanco,
    this.instituicao,
  });

  AccountModel copyWith({
    int? id,
    int? conta,
    double? saldo,
    int? idbanco,
    String? instituicao,
  }) {
    return AccountModel(
      id: id ?? this.id,
      conta: conta ?? this.conta,
      saldo: saldo ?? this.saldo,
      idbanco: idbanco ?? this.idbanco,
      instituicao: instituicao ?? this.instituicao,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conta': conta,
      'saldo': saldo,
      'idbanco': idbanco,
      'instituicao': instituicao,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'],
      conta: map['conta'],
      saldo: map['saldo'],
      idbanco: map['idbanco'],
      instituicao: map['instituicao'] != null ? map['instituicao'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AccountModel(id: $id, conta: $conta, saldo: $saldo, idbanco: $idbanco, instituicao: $instituicao)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountModel &&
        other.id == id &&
        other.conta == conta &&
        other.saldo == saldo &&
        other.idbanco == idbanco &&
        other.instituicao == instituicao;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        conta.hashCode ^
        saldo.hashCode ^
        idbanco.hashCode ^
        instituicao.hashCode;
  }
}
