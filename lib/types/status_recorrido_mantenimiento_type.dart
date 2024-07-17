import 'package:flutter/material.dart';

enum StatusRecorridoMantenimientoType {
  pendiente(value: 'Pendiente', color: Colors.red),
  enCurso(value: 'En curso', color: Colors.orange),
  completado(value: 'Completado', color: Colors.green);

  final String value;
  final Color color;

  const StatusRecorridoMantenimientoType({
    required this.value,
    required this.color,
  });

  static StatusRecorridoMantenimientoType getType(String value) {
    switch (value) {
      case 'Pendiente':
        return StatusRecorridoMantenimientoType.pendiente;
      case 'En curso':
        return StatusRecorridoMantenimientoType.enCurso;
      case 'Completado':
        return StatusRecorridoMantenimientoType.completado;
      default:
        return StatusRecorridoMantenimientoType.pendiente;
    }
  }
}
