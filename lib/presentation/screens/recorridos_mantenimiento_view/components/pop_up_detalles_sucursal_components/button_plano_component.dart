import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_without_internet/app/extensions.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:form_without_internet/types/status_recorrido_sucursal_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonPlanoComponent extends ConsumerWidget {
  final StatusRecorridoSucursalType statusRecorrido;
  final String folio;
  const ButtonPlanoComponent({super.key, required this.statusRecorrido, required this.folio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = statusRecorrido == StatusRecorridoSucursalType.completado;
    final isProgress = statusRecorrido == StatusRecorridoSucursalType.enCurso;
    return SizedBox(
      height: 150,
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: isCompleted
              ? Colors.green[900]
              : isProgress
                  ? Colors.orange
                  : Colors.grey[800],
          iconColor: Colors.white,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        ),
        onPressed: () async {
          final plano = await ref
              .read(recorridosMantenimientoViewModelProvider.notifier)
              .getPlanoSucursal(folio);

          if (!context.mounted) return;
          context.showFullImage(image: plano.path, isDelete: false);
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              size: 50,
            ),
            Text(
              'Ver plano de la sucursal',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
