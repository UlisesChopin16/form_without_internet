import 'package:flutter/material.dart';
import 'package:form_without_internet/constants/icons_manager.dart';
import 'package:form_without_internet/constants/strings_manager.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/resume_forms_view/components/list_resums_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/resume_forms_view/resume_forms_view_model/resume_forms_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResumeFormsView extends HookConsumerWidget {
  final String section;
  final String listOf;
  final String folio;

  const ResumeFormsView({
    super.key,
    required this.listOf,
    required this.folio,
    required this.section,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    useLaunchEffect(() async {
      await ref.read(listFormsViewModelProvider.notifier).getForms([listOf, folio, 'true']);
      final forms = ref.read(listFormsViewModelProvider.select((value) => value.data));
      ref.read(resumeFormsViewModelProvider.notifier).generateListExpandeds(forms.length);
    });

    final (forms, isLoading) = ref.watch(
      listFormsViewModelProvider.select(
        (value) => (value.data, value.isLoading),
      ),
    );
    final (listExpandeds) =
        ref.watch(resumeFormsViewModelProvider.select((value) => value.listExpandeds));
    bool isExpanded = true;
    for (final expanded in listExpandeds) {
      if (expanded) {
        isExpanded = false;
        break;
      }
    }
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : forms.isEmpty || listExpandeds.isEmpty
              ? const Center(
                  child: Text('No hay resumenes disponibles'),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
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
                    ),
                    const Expanded(
                      child: ListResumsComponent(),
                    ),
                  ],
                ),
    );
  }
}
