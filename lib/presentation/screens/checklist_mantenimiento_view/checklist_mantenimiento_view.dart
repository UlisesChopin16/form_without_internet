import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/common/components/label_text_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/checklist_mantenimiento_view_model/checklist_mantenimiento_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';

class ChecklistMantenimientoView extends ConsumerWidget {
  final String folio;
  const ChecklistMantenimientoView({super.key, required this.folio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (tabs, currentTab) = ref.watch(
      checklistMantenimientoViewModelProvider.select(
        (value) => (value.tabs, value.currentTabIndex),
      ),
    );
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('Fachada de la sucursal: CONSTITUYENTES'),
          title: const LabelTextComponent(
            label: 'Fachada de la sucursal',
            text: 'CONSTITUYENTES',
            fontSize: 20,
          ),
          bottom: TabBar(
            onTap: (index) {
              if (index == currentTab) return;
              ref.read(listFormsViewModelProvider.notifier).putInloading();
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
            ),
            ListFormsView(
              folio: folio,
              listOf: 'areas',
              // section is the correct name
              section: 'áreas',
            ),
            ListFormsView(
              folio: folio,
              listOf: 'sanitarios',
              section: 'sanitarios',
            ),
            ListFormsView(
              folio: folio,
              listOf: 'servicios',
              section: 'servicios',
            ),
            ListFormsView(
              folio: folio,
              listOf: 'miscelaneos',
              section: 'misceláneos',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.check),
        ),
      ),
    );
  }
}
