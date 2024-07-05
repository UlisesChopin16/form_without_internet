import 'package:form_without_internet/data/data_source/recorridos_mantenimiento/recorridos_mantenimiento_data_source.dart';
import 'package:form_without_internet/data/mapper/recorridos_mantenimiento_mapper.dart';
import 'package:form_without_internet/data/network_info/network_info.dart';
import 'package:form_without_internet/data/repository/recorridos_mantenimiento_repository.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model.dart';

class RecorridosMantenimientoRepositoryImpl implements RecorridosMantenimientoRepository {
  final RecorridosMantenimientoDataSource recorridosMantenimientoDataSource;
  final NetworkInfo networkInfo;

  RecorridosMantenimientoRepositoryImpl(
      {required this.recorridosMantenimientoDataSource, required this.networkInfo});

  @override
  Future<RecorridosMantenimientoResponseModel> getRecorridosMantenimientoRep() async {
    final response = await recorridosMantenimientoDataSource.getRecorridosMantenimientoDS();
    return response.toDomain();
  }
}
