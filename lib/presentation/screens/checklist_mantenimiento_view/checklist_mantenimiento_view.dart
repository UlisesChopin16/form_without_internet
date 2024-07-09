import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/common/components/label_text_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/checklist_mantenimiento_view_model/checklist_mantenimiento_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class ChecklistMantenimientoView extends ConsumerWidget {
  const ChecklistMantenimientoView({super.key});

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
            onTap: ref.read(checklistMantenimientoViewModelProvider.notifier).changeTabIndex,
            tabs: tabs.map((tab) => Tab(text: tab)).toList(),
          ),
        ),
        body: LazyLoadIndexedStack(
          index: currentTab,
          children: const [
            FachadaView(),
            ListFormsView(
              listOf: 'areas',
            ),
            ListFormsView(
              listOf: 'sanitarios',
            ),
            ListFormsView(
              listOf: 'servicios',
            ),
            ListFormsView(
              listOf: 'miscelaneo',
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
