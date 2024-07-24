import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:go_router/go_router.dart';

import '../screens/camera_view/camera_view.dart';
import '../screens/checklist_mantenimiento_view/checklist_mantenimiento_view.dart';
import '../screens/checklist_mantenimiento_view/screens/form_view/form_view.dart';
import '../screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view.dart';
import '/types/photo_type.dart';

class AppRoutes {
  static const String home = '/';
  static const String notFound = '/not-found';

  static final routes = <GoRoute>[
    GoRoute(
      path: home,
      name: RecorridosMantenimientoView.name,
      builder: (context, state) => const RecorridosMantenimientoView(),
    ),
    GoRoute(
      path: CameraView.route,
      name: CameraView.name,
      builder: (context, state) {
        final {
          'images': images as List<String>,
          'index': index as int?,
          'photoType': photoType as PhotoType,
        } = state.extra as Map<String, Object>;

        return CameraView(
          images: images,
          index: index ?? 0,
          photoType: photoType,
        );
      },
    ),
    GoRoute(
      path: ChecklistMantenimientoView.route,
      name: ChecklistMantenimientoView.name,
      builder: (context, state) {
        if (state.extra is Map<String, RecorridoSucursalModel>){
          final {'recorrido': recorrido} = state.extra as Map<String, RecorridoSucursalModel>;
          return ChecklistMantenimientoView(
            recorrido: recorrido,
          );
        }

        final {
          'recorrido': recorrido as RecorridoSucursalModel,
          'index': index  as int?,
        } = state.extra! as Map<String, Object>;

        return ChecklistMantenimientoView(
          recorrido: recorrido,
          index: index ?? 0,
        );
      },
    ),
    GoRoute(
      path: ChecklistMantenimientoView.resumeRoute,
      name: ChecklistMantenimientoView.resumeName,
      builder: (context, state) {
        if (state.extra is Map<String, RecorridoSucursalModel>){
          final {'recorrido': recorrido} = state.extra as Map<String, RecorridoSucursalModel>;
          return ChecklistMantenimientoView(
            recorrido: recorrido,
            isResume: true,
          );
        }

        final {
          'recorrido': recorrido as RecorridoSucursalModel,
          'index': index as int?,
        } = state.extra as Map<String, Object>;

        return ChecklistMantenimientoView(
          recorrido: recorrido,
          isResume: true,
          index: index ?? 0,
        );
      },
    ),
    GoRoute(
      path: FormView.route,
      name: FormView.name,
      builder: (context, state) {
        final {
          'questions': questions as List<QuestionsResponseModel>,
          'title': title as String,
          'formIndex': formIndex as int,
        } = state.extra as Map<String, Object>;

        return FormView(
          questions: questions,
          title: title,
          formIndex: formIndex,
        );
      },
    ),
  ];
}
