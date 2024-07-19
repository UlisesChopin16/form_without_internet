import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_without_internet/constants/icons_manager.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:form_without_internet/presentation/common/components/marker_card_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/components/text_inactive_section_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:form_without_internet/presentation/screens/image_full_view/image_full_view.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/components/label_content_component.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListResumsComponent extends HookConsumerWidget {
  const ListResumsComponent({
    super.key,
    required this.forms,
  });

  final List<SectionResponseModel> forms;

  static const TextStyle style = TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    return ListView.builder(
      controller: scrollController,
      itemCount: forms.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 65,
      ),
      itemBuilder: (context, index) {
        final form = forms[index];
        final [completeds, notCompleteds] =
            ref.read(listFormsViewModelProvider.notifier).getCompletedsAndNot(index);
        return Card(
          color: Colors.grey[350],
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LabelContentComponent(
                      label: 'Nombre:',
                      content: Text(
                        form.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    LabelContentComponent(
                      label: 'Pendientes:',
                      content: Row(
                        children: [
                          const Icon(IconsManager.pendingAssigment, color: Colors.red),
                          const Gap(5),
                          Text(
                            notCompleteds.toString(),
                            style: style.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    LabelContentComponent(
                      label: 'Completados:',
                      content: Row(
                        children: [
                          const Icon(IconsManager.completedAssigment, color: Colors.green),
                          const Gap(5),
                          Text(
                            completeds.toString(),
                            style: style.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    LabelContentComponent(
                      label: 'Totales:',
                      content: Row(
                        children: [
                          const Icon(IconsManager.totalAssigments, color: Colors.black),
                          const Gap(5),
                          Text(
                            form.questionsResponseModel.length.toString(),
                            style: style.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                const SizedBox(height: 15),
                if (form.active)
                  ...form.questionsResponseModel.map(
                    (question) {
                      bool isNotAnswered = question.value.isEmpty;
                      bool isRed = question.value == 'Malo' || question.value == 'Pésimo';
                      return MarkerCardComponent(
                        color: isRed ? Colors.red : Colors.black,
                        markerChild: isNotAnswered
                            ? null
                            : const Icon(IconsManager.circleCheck, color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: LabelContentComponent(
                                  label: 'Concepto:',
                                  content: Text(
                                    question.name,
                                    style: style.copyWith(
                                      color: isRed ? Colors.red : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: LabelContentComponent(
                                  label: 'Evaluación:',
                                  content: Text(
                                    question.value.isEmpty ? 'Indefinido' : question.value,
                                    style: style.copyWith(
                                      color: isRed ? Colors.red : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: question.description.isEmpty ? 1 : 3,
                                child: LabelContentComponent(
                                  label: 'Comentarios:',
                                  content: Text(
                                    question.description.isEmpty
                                        // ? 'Sin comentarios aaaaasssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssaaaaasssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'
                                        ? 'Sin comentarios'
                                        : question.description,
                                    maxLines: 4,
                                    style: style.copyWith(
                                      color: isRed ? Colors.red : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Center(
                                  child: InkWell(
                                    onTap: question.images.isNotEmpty
                                        ? () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => ImageFullView(
                                                  images: question.images,
                                                  index: 0,
                                                  isDelete: false,
                                                ),
                                              ),
                                            );
                                          }
                                        : null,
                                    child: LabelContentComponent(
                                      label: 'Evidencia:',
                                      content: SizedBox(
                                        height: 105,
                                        width: 100,
                                        child: Card(
                                          elevation: 3,
                                          color: isRed ? Colors.red : Colors.grey,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                const Icon(
                                                  Icons.image,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                                const Gap(5),
                                                Text(
                                                  question.images.isEmpty
                                                      ? 'Sin evidencia'
                                                      : '${question.images.length.toString()} imágenes',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: isRed ? Colors.white : Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                else
                  const TextInactiveSectionComponent(),
              ],
            ),
          ),
        );
      },
    );
  }
}
