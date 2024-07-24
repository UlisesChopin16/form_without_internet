import 'package:flutter/material.dart';
import 'package:form_without_internet/constants/icons_manager.dart';
import 'package:form_without_internet/constants/strings_manager.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/checklist_mantenimiento_view.dart';
import 'package:form_without_internet/types/status_recorrido_sucursal_type.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ButtonPopupDetalleSucursalComponent extends StatelessWidget {
  const ButtonPopupDetalleSucursalComponent({
    super.key,
    required this.recorrido,
  });
  final RecorridoSucursalModel recorrido;

  @override
  Widget build(BuildContext context) {
    final isCompleted = recorrido.checklist == StatusRecorridoSucursalType.completado;
    final isProgress = recorrido.checklist == StatusRecorridoSucursalType.enCurso;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        // backgroundColor: isCompleted ? Colors.green[900] : Colors.grey[800],
        backgroundColor: isCompleted
            ? Colors.green[900]
            : isProgress
                ? Colors.orange
                : Colors.grey[800],
        iconColor: Colors.white,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      ),
      onPressed: () {
        Map<String, RecorridoSucursalModel> extra = {
          'recorrido': recorrido,
        };
        if (isCompleted) {
          context.push(
            ChecklistMantenimientoView.resumeRoute,
            extra: extra,
          );
          return;
        }
        context.push(
          ChecklistMantenimientoView.route,
          extra: extra,
        );
      },
      child: Row(
        children: [
          Icon(
            isCompleted
                ? IconsManager.resumeAssigment
                : isProgress
                    ? IconsManager.inProgressAssigment
                    : IconsManager.realizeAssigment,
          ),
          const Gap(5),
          Text(
            isCompleted
                ? StringsManager.verResumenCheckList
                : isProgress
                    ? StringsManager.continuarCheckList
                    : StringsManager.realizarCheckList,
          ),
        ],
      ),
    );
  }
}
