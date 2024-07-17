class StringsManager {
  static const String appName = 'Rutas de reparto';
  static const realizarCheckList = 'Realizar checklist de mantenimiento';
  static const continuarCheckList = 'Continuar checklist de mantenimiento';
  static const verResumenCheckList = 'Ver resumen del checklist';

  static const List<String> columnNames = [
    'sem',
    'Inicio',
    'Fin',
    // 'Responsable',
    'Recorrido sucursales',
    'Estatus',
    // 'Fecha registro',
    'Op.',
  ];

  static const List<String> sucursalesColumn = [
    'Pendientes',
    'En curso',
    'Completados',
    'Totales',
  ];

  static const List<List<String>> dataSection = [
    [
      'areas',
      'áreas',
    ],
    [
      'sanitarios',
      'sanitarios',
    ],
    [
      'servicios',
      'servicios',
    ],
    [
      'miscelaneos',
      'misceláneos',
    ],
  ];
}
