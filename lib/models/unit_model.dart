class Unit {
  final int unitId;
  final String unitName;
  final DateTime createdAt;
  final DateTime updatedAt;

  Unit({
    required this.unitId,
    required this.unitName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Unit.fromMap(Map<String, dynamic> json) => Unit(
        unitId: json["unit_id"],
        unitName: json["unit_name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "unit_id": unitId,
        "unit_name": unitName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
