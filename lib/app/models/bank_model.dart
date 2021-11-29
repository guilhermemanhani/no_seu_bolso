import 'dart:convert';

class BankModel {
  final int id;
  final String instituicao;
  BankModel({
    required this.id,
    required this.instituicao,
  });

  BankModel copyWith({
    int? id,
    String? instituicao,
  }) {
    return BankModel(
      id: id ?? this.id,
      instituicao: instituicao ?? this.instituicao,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'instituicao': instituicao,
    };
  }

  factory BankModel.fromMap(Map<String, dynamic> map) {
    return BankModel(
      id: map['id'],
      instituicao: map['instituicao'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BankModel.fromJson(String source) =>
      BankModel.fromMap(json.decode(source));

  @override
  String toString() => 'BankModel(id: $id, instituicao: $instituicao)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BankModel &&
        other.id == id &&
        other.instituicao == instituicao;
  }

  @override
  int get hashCode => id.hashCode ^ instituicao.hashCode;
}
