import 'package:flutter/material.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/resume_forms_view/components/card_question_component.dart';

class BodyResumeFormComponent extends StatelessWidget {
  final List<QuestionsResponseModel> questionsResponseModel;
  const BodyResumeFormComponent({super.key, required this.questionsResponseModel});

  static const TextStyle style = TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: questionsResponseModel.map(
        (question) {
          return CardQuestionComponent(
            question: question,
            style: style,
          );
        },
      ).toList(),
    );
  }
}
