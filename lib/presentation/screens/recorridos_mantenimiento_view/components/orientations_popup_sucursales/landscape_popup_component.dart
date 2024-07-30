import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/components.dart';

class LandscapePopupComponent extends ConsumerWidget {
  final int index;
  final Color color;
  const LandscapePopupComponent({super.key, required this.index, required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: HeaderPopupComponent(
        index: index,
        color: color,
      ),
      content: Row(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SearchTextFieldComponent(),
                  Gap(20),
                  Expanded(
                    child: ExpandedFiltersSComponent(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListSucursalesComponent(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
