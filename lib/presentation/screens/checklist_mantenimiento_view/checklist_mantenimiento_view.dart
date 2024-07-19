import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/constants/icons_manager.dart';
import 'package:form_without_internet/constants/strings_manager.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:form_without_internet/presentation/common/components/saving_data_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/checklist_mantenimiento_view_model/checklist_mantenimiento_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/resume_forms_view/resume_forms_view.dart';
import 'package:gap/gap.dart';

class ChecklistMantenimientoView extends ConsumerWidget {
  final RecorridoSucursalModel recorrido;
  final bool isResume;
  final int index;

  const ChecklistMantenimientoView({
    super.key,
    required this.recorrido,
    this.isResume = false,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    final (isSaving, isSaved) = ref.watch(
      fachadaViewModelProvider.select(
        (value) => (value.isSaving, value.isSaved),
      ),
    );
    final (tabs, currentTab) = ref.watch(
      checklistMantenimientoViewModelProvider.select(
        (value) => (value.tabs, value.currentTabIndex),
      ),
    );
    return DefaultTabController(
      initialIndex: index,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // title: const Text('Fachada de la sucursal: CONSTITUYENTES'),
          title: Text(
            isResume
                ? 'Resume of: ${recorrido.nombre.toUpperCase()}'
                : recorrido.nombre.toUpperCase(),
            maxLines: 1,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            SavingDataComponent(
              isSaving: isSaving,
              isSaved: isSaved,
            ),
            const Gap(10),
            Text(
              recorrido.folio,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
                color: Colors.blue,
              ),
            ),
            const Gap(10),
          ],
          bottom: TabBar(
            onTap: (index) {
              if (index == currentTab) return;
              ref.read(listFormsViewModelProvider.notifier).putInloading();
              if (isResume) {
                ref
                    .read(checklistMantenimientoViewModelProvider.notifier)
                    .changeResumeTabIndex(index);
                return;
              }
              ref.read(checklistMantenimientoViewModelProvider.notifier).changeTabIndex(index);
            },
            tabs: tabs.map((tab) => Tab(text: tab)).toList(),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            FachadaView(
              recorrido: recorrido,
              isResume: isResume,
              viewInsets: viewInsets,
            ),
            ...StringsManager.dataSection.map(
              (section) => !isResume
                  ? ListFormsView(
                      folio: recorrido.folio,
                      listOf: section[0],
                      section: section[1],
                    )
                  : ResumeFormsView(
                      folio: recorrido.folio,
                      listOf: section[0],
                      section: section[1],
                    ),
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!isResume)
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChecklistMantenimientoView(
                        recorrido: recorrido,
                        isResume: true,
                        index: currentTab,
                      ),
                    ),
                  );
                  
                  if (currentTab == 0) {
                    ref.read(fachadaViewModelProvider.notifier).setIsResume();
                    return;
                  }

                  ref.read(listFormsViewModelProvider.notifier).getForms([
                    StringsManager.dataSection[currentTab - 1][0],
                    recorrido.folio,
                  ]);
                },
                child: const Icon(IconsManager.realizeAssigment),
              ),
            if (!isResume) const Gap(10),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {},
              child: const Icon(Icons.check),
            ),
          ],
        ),
      ),
    );
  }
}
