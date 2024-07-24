import 'package:flutter/material.dart';
import 'package:form_without_internet/constants/icons_manager.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/checklist_mantenimiento_view_model/checklist_mantenimiento_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/resume_forms_view/resume_forms_view_model/resume_forms_view_model.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/components/components.dart';
import 'package:form_without_internet/types/status_recorrido_sucursal_type.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HeaderResumeFormComponen extends ConsumerWidget {
  final SectionResponseModel form;
  final int index;
  const HeaderResumeFormComponen({super.key, required this.form, required this.index});

  static const TextStyle style = TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final [completeds, notCompleteds] =
        ref.read(listFormsViewModelProvider.notifier).getCompletedsAndNot(index);
    final isExpanded =
        ref.watch(resumeFormsViewModelProvider.select((value) => value.listExpandeds[index]));
    final checkList = ref.watch(checklistMantenimientoViewModelProvider.select((value) => value.recorrido!.checklist));
    final bool isCompleted = checkList == StatusRecorridoSucursalType.completado;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LabelContentComponent(
          label: 'Nombre:',
          content: Text(
            form.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        if (form.active && !isCompleted)
          LabelContentComponent(
            label: 'Pendientes:',
            content: Row(
              children: [
                const Icon(IconsManager.pendingAssigment, color: Colors.red),
                const Gap(5),
                Text(
                  notCompleteds.toString(),
                  style: style.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        if (form.active) const Gap(20),
        if (form.active && !isCompleted)
          LabelContentComponent(
            label: 'Completados:',
            content: Row(
              children: [
                const Icon(IconsManager.completedAssigment, color: Colors.green),
                const Gap(5),
                Text(
                  completeds.toString(),
                  style: style.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        if (form.active) const Gap(20),
        if (form.active)
          LabelContentComponent(
            label: 'Totales:',
            content: Row(
              children: [
                const Icon(IconsManager.totalAssigments, color: Colors.black),
                const Gap(5),
                Text(
                  form.questionsResponseModel.length.toString(),
                  style: style.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        if (form.active)
          // icon button to expand or collapse the form
          IconButton(
            icon: Icon(
              isExpanded ? IconsManager.expandIcon : IconsManager.compressIcon,
              color: Colors.black,
            ),
            onPressed: () {
              ref.read(resumeFormsViewModelProvider.notifier).changeExpanded(index);
            },
          ),
      ],
    );
  }
}
