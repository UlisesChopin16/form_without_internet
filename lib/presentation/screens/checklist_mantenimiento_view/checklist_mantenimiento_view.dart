import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/constants/icons_manager.dart';
import 'package:form_without_internet/constants/strings_manager.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/checklist_mantenimiento_view_model/checklist_mantenimiento_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/resume_forms_view/resume_forms_view.dart';
import 'package:gap/gap.dart';

class ChecklistMantenimientoView extends ConsumerWidget {
  final String folio;
  final bool isResume;
  final int index;
  const ChecklistMantenimientoView(
      {super.key, required this.folio, this.isResume = false, this.index = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          // title: const Text('Fachada de la sucursal: CONSTITUYENTES'),
          title: const Text(
            'CONSTITUYENTES',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
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
              folio: folio,
              isResume: isResume,
            ),
            ...StringsManager.dataSection.map(
              (section) => !isResume
                  ? ListFormsView(
                      folio: folio,
                      listOf: section[0],
                      section: section[1],
                    )
                  : ResumeFormsView(
                      folio: folio,
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
                        folio: folio,
                        isResume: true,
                        index: currentTab,
                      ),
                    ),
                  );

                  if (currentTab == 0) {
                    return;
                  }
                  ref.read(fachadaViewModelProvider.notifier).setIsResume(isResume);
                  ref.read(listFormsViewModelProvider.notifier).getForms([
                    StringsManager.dataSection[currentTab - 1][0],
                    folio,
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
