import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/form_view/form_view_model/form_view_model.dart';

import 'components.dart';

class ExpandedContainerComponent extends ConsumerWidget {
  final int index;

  const ExpandedContainerComponent({super.key, required this.index});

  static const double height = 100;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (isExpanded, value) = ref.watch(
      formViewModelProvider.select(
        (value) => (value.isExpanded[index], value.questions[index].value),
      ),
    );
    return Card(
      elevation: !isExpanded ? 1 : 2,
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        side: !isExpanded && value != 'No aplica'
            ? BorderSide(
                color: Theme.of(context).primaryColor,
                width: 3,
              )
            : BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        height: (!isExpanded) ? height : 300,
        child: Column(
          children: [
            SizedBox(
              height: height,
              child: ExpandedHeaderComponent(
                indexItem: index,
              ),
            ),
            if (isExpanded)
              Expanded(
                child: ExpandedBodyComponent(
                  index: index,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
