import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/image_full_view/image_full_view.dart';
import 'package:form_without_internet/types/status_recorrido_mantenimiento_type.dart';
import 'package:form_without_internet/types/status_recorrido_sucursal_type.dart';
import 'package:form_without_internet/types/tipo_sucursal_type.dart';

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
    return StatusRecorridoMantenimientoType.getType(this);
  }

  StatusRecorridoSucursalType orPendingSucursal() {
    return StatusRecorridoSucursalType.getType(this);
  }

  TipoSucursalType tipoSucursal() {
    return TipoSucursalType.getType(this);
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

    /// if isDelete is true, the image can be deleted and is necessary to pass the onDelete function
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
