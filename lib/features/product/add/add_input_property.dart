import 'package:flutter/widgets.dart';

class AddInputProperty {
  final String label;
  final String field;
  final TextEditingController controller;
  AddInputProperty({
    required this.label,
    required this.field,
    required this.controller,
  });

  AddInputProperty copyWith({
    String? label,
    String? field,
    TextEditingController? controller,
  }) {
    return AddInputProperty(
      label: label ?? this.label,
      field: field ?? this.field,
      controller: controller ?? this.controller,
    );
  }

  @override
  String toString() => 'AddInputProperty(label: $label, field: $field, controller: $controller)';

  @override
  bool operator ==(covariant AddInputProperty other) {
    if (identical(this, other)) return true;
  
    return 
      other.label == label &&
      other.field == field &&
      other.controller == controller;
  }

  @override
  int get hashCode => label.hashCode ^ field.hashCode ^ controller.hashCode;
}
