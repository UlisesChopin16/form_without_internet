import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/form_view/form_view.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'components.dart';

class ActiveContainerComponent extends ConsumerWidget {
  final int index;

  const ActiveContainerComponent({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orientation = MediaQuery.of(context).orientation;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final (isActive, form) = ref.watch(
      listFormsViewModelProvider.select(
        (value) => (
          value.data[index].active,
          value.data[index],
        ),
      ),
    );
    return Card(
      elevation: 5,
      color: isActive ? Colors.white : Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: orientation == Orientation.portrait ? width * 0.218 : width * 0.177,
        height: !isActive
            ? 80
            : orientation == Orientation.portrait
                ? height * 0.18
                : height * 0.25,
        child: InkWell(
          onTap: !form.active ? null : () => onTap(ref, context, index),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActiveContainerHeaderComponent(index: index),
                Expanded(
                  child: ActiveContainerBodyComponent(index: index),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTap(WidgetRef ref, BuildContext context, int index) async {
    final (form) = ref.watch(
      listFormsViewModelProvider.select(
        (value) => (value.data[index]),
      ),
    );
    final data = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return FormView(
            questions: form.questionsResponseModel,
            title: form.title,
          );
        },
      ),
    );

    if (data != null) {
      ref.read(listFormsViewModelProvider.notifier).changeState(data, index);
    }
    // ref.read(provider.notifier).changeTabIndex(index);
  }
}
