import 'dart:convert';

class ExpenseByLocalModel {
  final int contador;
  final double soma;
  final double media;
  final String local;

  ExpenseByLocalModel({
    required this.contador,
    required this.soma,
    required this.media,
    required this.local,
  });

  ExpenseByLocalModel copyWith({
    int? contador,
    double? soma,
    double? media,
    String? local,
  }) {
    return ExpenseByLocalModel(
      contador: contador ?? this.contador,
      soma: soma ?? this.soma,
      media: media ?? this.media,
      local: local ?? this.local,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contador': contador,
      'soma': soma,
      'media': media,
      'local': local,
    };
  }

  factory ExpenseByLocalModel.fromMap(Map<String, dynamic> map) {
    return ExpenseByLocalModel(
      contador: map['contador']?.toInt() ?? 0,
      soma: map['soma']?.toDouble() ?? 0.0,
      media: map['media']?.toDouble() ?? 0.0,
      local: map['local'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseByLocalModel.fromJson(String source) =>
      ExpenseByLocalModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpenseByLocalModel(contador: $contador, soma: $soma, media: $media, local: $local)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseByLocalModel &&
        other.contador == contador &&
        other.soma == soma &&
        other.media == media &&
        other.local == local;
  }

  @override
  int get hashCode {
    return contador.hashCode ^ soma.hashCode ^ media.hashCode ^ local.hashCode;
  }
}
