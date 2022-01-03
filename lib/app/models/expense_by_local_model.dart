import 'dart:convert';

class ExpenseByLocalModel {
  final int contador;
  final double soma;
  final int tpagamento;
  final String local;
  ExpenseByLocalModel({
    required this.contador,
    required this.soma,
    required this.tpagamento,
    required this.local,
  });

  ExpenseByLocalModel copyWith({
    int? contador,
    double? soma,
    int? tpagamento,
    String? local,
  }) {
    return ExpenseByLocalModel(
      contador: contador ?? this.contador,
      soma: soma ?? this.soma,
      tpagamento: tpagamento ?? this.tpagamento,
      local: local ?? this.local,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contador': contador,
      'soma': soma,
      'tpagamento': tpagamento,
      'local': local,
    };
  }

  factory ExpenseByLocalModel.fromMap(Map<String, dynamic> map) {
    return ExpenseByLocalModel(
      contador: map['contador']?.toInt() ?? 0,
      soma: map['soma']?.toDouble() ?? 0.0,
      tpagamento: map['tpagamento']?.toInt() ?? 0,
      local: map['local'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseByLocalModel.fromJson(String source) =>
      ExpenseByLocalModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpenseByLocalModel(contador: $contador, soma: $soma, tpagamento: $tpagamento, local: $local)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseByLocalModel &&
        other.contador == contador &&
        other.soma == soma &&
        other.tpagamento == tpagamento &&
        other.local == local;
  }

  @override
  int get hashCode {
    return contador.hashCode ^
        soma.hashCode ^
        tpagamento.hashCode ^
        local.hashCode;
  }
}
