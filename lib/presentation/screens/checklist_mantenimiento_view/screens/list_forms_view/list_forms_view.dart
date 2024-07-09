import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/form_view/form_view.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListFormsView extends HookConsumerWidget {
  final String listOf;
  const ListFormsView({super.key, required this.listOf});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orientation = MediaQuery.of(context).orientation;
    useLaunchEffect(
      () => ref.read(listFormsViewModelProvider.notifier).getForms(listOf),
    );

    final (forms) = ref.watch(
      listFormsViewModelProvider.select(
        (value) => (value.data),
      ),
    );
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 25.0,
        ),
        child: GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 4 : 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(
            forms.length,
            (index) {
              return Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: !forms[index].active ? null : () => onTap(ref, context, index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                forms[index].title,
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
                              value: forms[index].active,
                              onChanged: (value) {
                                ref
                                    .read(listFormsViewModelProvider.notifier)
                                    .changeState(value, index);
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
