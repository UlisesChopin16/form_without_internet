import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/components/orientations_popup_sucursales/landscape_popup_component.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/components/orientations_popup_sucursales/portrait_popup_component.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PopupSucursalesComponent extends ConsumerWidget {
  final int index;
  final Color color;

  const PopupSucursalesComponent({
    super.key,
    required this.index,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      return PortraitPopupComponent(
        index: index,
        color: color,
      );
    } else {
      return LandscapePopupComponent(
        index: index,
        color: color,
      );
    }
  }
}
