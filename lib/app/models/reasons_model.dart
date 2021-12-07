import 'dart:convert';

class ReasonsModel {
  final int id;
  final String motivo;
  ReasonsModel({
    required this.id,
    required this.motivo,
  });

  ReasonsModel copyWith({
    int? id,
    String? motivo,
  }) {
    return ReasonsModel(
      id: id ?? this.id,
      motivo: motivo ?? this.motivo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'motivo': motivo,
    };
  }

  factory ReasonsModel.fromMap(Map<String, dynamic> map) {
    return ReasonsModel(
      id: map['id'],
      motivo: map['motivo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReasonsModel.fromJson(String source) =>
      ReasonsModel.fromMap(json.decode(source));

  @override
  String toString() => 'ReasonsModel(id: $id, motivo: $motivo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReasonsModel && other.id == id && other.motivo == motivo;
  }

  @override
  int get hashCode => id.hashCode ^ motivo.hashCode;
}
