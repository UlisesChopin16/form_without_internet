import 'package:flutter/material.dart';
import 'package:form_without_internet/constants/icons_manager.dart';

enum StatusRecorridoSucursalType {
  todos(value: 'Todos', color: Colors.blue, icon: IconsManager.totalAssigments),
  pendiente(value: 'Pendiente', color: Colors.red, icon: IconsManager.pendingAssigment),
  enCurso(value: 'En curso', color: Colors.orange, icon: IconsManager.inProgressAssigment),
  completado(value: 'Completado', color: Colors.green, icon: IconsManager.completedAssigment);

  final String value;
  final IconData icon;
  final Color color;

  const StatusRecorridoSucursalType({
    required this.value,
    required this.color,
    required this.icon,
  });

  static StatusRecorridoSucursalType getType(String? value) {
    switch (value) {
      case 'Pendiente':
        return StatusRecorridoSucursalType.pendiente;
      case 'En curso':
        return StatusRecorridoSucursalType.enCurso;
      case 'Completado':
        return StatusRecorridoSucursalType.completado;
      default:
        return StatusRecorridoSucursalType.pendiente;
    }
  }
}
