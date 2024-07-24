import 'package:flutter/material.dart';
import 'package:form_without_internet/app/extensions.dart';
import 'package:form_without_internet/constants/icons_manager.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:form_without_internet/presentation/common/components/marker_card_component.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/components/components.dart';
import 'package:gap/gap.dart';

class CardQuestionComponent extends StatelessWidget {
  final QuestionsResponseModel question;
  final TextStyle style;

  const CardQuestionComponent({
    super.key,
    required this.question,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNotAnswered = question.value.isEmpty;
    final bool isRed = question.value == 'Malo' || question.value == 'Pésimo';

    return InkWell(
      onTap: () {},
      child: MarkerCardComponent(
        color: isRed ? Colors.red : Colors.black,
        markerChild: isNotAnswered
            ? null
            : const Icon(
                IconsManager.circleCheck,
                color: Colors.white,
              ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
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
                            context.showFullImage(
                              images: question.images,
                              index: 0,
                              isDelete: false,
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
      ),
    );
  }
}
