import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActiveContainerHeaderComponent extends ConsumerWidget {
  const ActiveContainerHeaderComponent({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(
      listFormsViewModelProvider.select(
        (value) => value.data[index],
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            form.title,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Gap(10),
        Switch(
          value: form.active,
          onChanged: (value) {
            ref.read(listFormsViewModelProvider.notifier).changeState(value, index);
          },
        )
      ],
    );
  }
}
