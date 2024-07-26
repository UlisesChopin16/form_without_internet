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

  static final routerConfig = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: home,
    routes: routes,
  );

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
        final extra = state.extra as Map<String, Object>;
        final images = extra['images'] as List<String>;
        final index = extra['index'] as int?;
        final photoType = extra['photoType'] as PhotoType;
        
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
        final extra = state.extra as Map<String, Object>;
        final recorrido = extra['recorrido'] as RecorridoSucursalModel;
        final index = extra['index'] as int?;

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

        final extra = state.extra as Map<String, Object>;
        final recorrido = extra['recorrido'] as RecorridoSucursalModel;
        final index = extra['index'] as int?;

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
