import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/image_full_view/image_full_view.dart';
import 'package:form_without_internet/types/status_recorrido_mantenimiento_type.dart';
import 'package:form_without_internet/types/status_recorrido_sucursal_type.dart';

const empty = '';
const zero = 0;

// extension on String
extension NonNullString on String? {
  /// This extension is used to return an empty string if the value is null
  String orEmpty() {
    /// if the value is null, return an empty string
    return this ?? empty;
  }

  StatusRecorridoMantenimientoType orPending() {
    return this == null
        ? StatusRecorridoMantenimientoType.pendiente
        : StatusRecorridoMantenimientoType.getType(this!);
  }

  StatusRecorridoSucursalType orPendingSucursal() {
    return this == null
        ? StatusRecorridoSucursalType.pendiente
        : StatusRecorridoSucursalType.getType(this!);
  }
}

// extension on Integer
extension NonNullInt on int? {
  /// This extension is used to return 0 if the value is null
  int orZero() {
    return this ?? zero;
  }
}

extension ShowFullImage on BuildContext {
  Future<void> showFullImage({
    String image = '',
    List<String> images = const [],
    int index = 0,
    void Function(int)? onDelete,
    bool isDelete = true,
  }) async {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => ImageFullView(
          image: image,
          images: images,
          index: index,
          isDelete: isDelete,
          onDelete: onDelete,
        ),
      ),
    );
  }
}
