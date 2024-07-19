import 'dart:convert';

import 'package:form_without_internet/app/app_preferences.dart';
import 'package:form_without_internet/data/data_source/recorridos_mantenimiento/recorridos_mantenimiento_data_source.dart';
import 'package:form_without_internet/data/mapper/list_forms_mapper.dart';
import 'package:form_without_internet/data/mapper/recorridos_mantenimiento_mapper.dart';
import 'package:form_without_internet/data/network_info/network_info.dart';
import 'package:form_without_internet/data/repository/recorridos_mantenimiento_repository.dart';
import 'package:form_without_internet/data/responses/list_form_response/list_forms_response.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';

class RecorridosMantenimientoRepositoryImpl implements RecorridosMantenimientoRepository {
  final RecorridosMantenimientoDataSource recorridosMantenimientoDataSource;
  final AppPreferences appPreferences;
  final NetworkInfo networkInfo;

  RecorridosMantenimientoRepositoryImpl({
    required this.recorridosMantenimientoDataSource,
    required this.networkInfo,
    required this.appPreferences,
  });

  @override
  Future<RecorridosMantenimientoResponseModel> getRecorridosMantenimientoRep() async {
    final response = await recorridosMantenimientoDataSource.getRecorridosMantenimientoDS();
    return response.toDomain();
  }

  @override
  Future<ListFormsResponseModel> getListFormsRep(String section, String folio) async {
    // final response = await recorridosMantenimientoDataSource.getListFormsDS();
    // return response.toDomain();

    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      final String data = appPreferences.getSection(sectionP: section, folio: folio);
      if (data.isNotEmpty) {
        final jsonData = json.decode(data);
        return ListFormsResponse.fromJson(jsonData).toDomain();
      }
      return const ListFormsResponse().toDomain();
    }

    // verify if we have data in the local storage
    final String data = appPreferences.getSection(sectionP: section, folio: folio);
    if (data.isNotEmpty) {
      print('I have data');
      final jsonData = json.decode(data);
      final dataStorage = ListFormsResponse.fromJson(jsonData).toDomain();
      await sendFormRep(body: dataStorage, folio: folio, section: section);
      print('Data sent');
    }

    final response = await recorridosMantenimientoDataSource.getListFormsDS();
    appPreferences.setSection(
      sectionP: section,
      folio: folio,
      value: json.encode(response.toJson()),
    );
    return response.toDomain();
  }

  @override
  Future<void> sendFormRep(
      {required ListFormsResponseModel body,
      required String folio,
      required String section}) async {
    final bool isConnected = await networkInfo.isConnected;
    await appPreferences.setSection(folio: folio, sectionP: section, value: body.toEncoded());
    if (!isConnected) {
      return;
    }
    await recorridosMantenimientoDataSource.sendFormDS(body);
  }
}
