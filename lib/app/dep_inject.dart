import 'package:form_without_internet/app/app_preferences.dart';
import 'package:form_without_internet/data/data_source/recorridos_mantenimiento/recorridos_mantenimiento_data_source.dart';
import 'package:form_without_internet/data/data_source/recorridos_mantenimiento/recorridos_mantenimiento_data_source_impl.dart';
import 'package:form_without_internet/data/network/apis/recorridos_mantenimiento_api.dart';
import 'package:form_without_internet/data/network_info/network_info.dart';
import 'package:form_without_internet/data/repository/recorridos_mantenimiento_repository.dart';
import 'package:form_without_internet/data/repository/recorridos_mantenimiento_repository_impl.dart';
import 'package:form_without_internet/domain/usecases/recorridos_mantenimiento_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // Register your dependencies here
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared preferences instance
  instance.registerLazySingleton(() => sharedPrefs);

  // App preferences
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance()),
  );

  // network info
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnectionChecker()),
  );

  // dio factory
  // instance.registerLazySingleton<DioFactory>(
  //   () => DioFactory(instance()),
  // );

  // App service client
  // final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<RecorridosMantenimientoApi>(
    () => RecorridosMantenimientoApi(),
  );

  // remote data source
  instance.registerLazySingleton<RecorridosMantenimientoDataSource>(
    () => RecorridosMantenimientoDataSourceImpl(
      recorridosMantenimientoApi: instance(),
    ),
  );

  // repository
  instance.registerLazySingleton<RecorridosMantenimientoRepository>(
    () => RecorridosMantenimientoRepositoryImpl(
      networkInfo: instance(),
      recorridosMantenimientoDataSource: instance(),
    ),
  );

  // register use case
  instance.registerLazySingleton<RecorridosMantenimientoUseCase>(
    () => RecorridosMantenimientoUseCase(instance()),
  );

  instance.registerLazySingleton<ImagePicker>(
    () => ImagePicker(),
  );
}

Future<void> resetAllModules() async {
  instance.reset(dispose: false);
  await initAppModule();
}
