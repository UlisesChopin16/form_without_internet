import 'package:flutter/material.dart';
import 'package:form_without_internet/constants/icons_manager.dart';
import 'package:form_without_internet/constants/strings_manager.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/resume_forms_view/resume_forms_view_model/resume_forms_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonExpandedComponent extends ConsumerWidget {
  const ButtonExpandedComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (listExpandeds) = ref.watch(resumeFormsViewModelProvider.select((value) => value.listExpandeds));
    bool isExpanded = true;
    for (final expanded in listExpandeds) {
      if (expanded) {
        isExpanded = false;
        break;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.black,
        elevation: 5,
        onPressed: () {
          ref.read(resumeFormsViewModelProvider.notifier).compressAll(isExpanded);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isExpanded ? StringsManager.expandir : StringsManager.contraer,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Icon(
              isExpanded ? IconsManager.expandIcon : IconsManager.compressIcon,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
