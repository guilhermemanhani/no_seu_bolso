import 'dart:convert';

class LocalModel {
  final int id;
  final String local;
  LocalModel({
    required this.id,
    required this.local,
  });

  LocalModel copyWith({
    int? id,
    String? local,
  }) {
    return LocalModel(
      id: id ?? this.id,
      local: local ?? this.local,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'local': local,
    };
  }

  factory LocalModel.fromMap(Map<String, dynamic> map) {
    return LocalModel(
      id: map['id'],
      local: map['local'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalModel.fromJson(String source) =>
      LocalModel.fromMap(json.decode(source));

  @override
  String toString() => 'LocalModel(id: $id, local: $local)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocalModel && other.id == id && other.local == local;
  }

  @override
  int get hashCode => id.hashCode ^ local.hashCode;
}
