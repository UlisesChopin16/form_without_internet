import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:form_without_internet/data/responses/list_form_response/list_forms_response.dart';
import 'package:form_without_internet/data/responses/recorrido_mantenimiento_response.dart/recorridos_mantenimiento_response.dart';

class RecorridosMantenimientoApi {
  static const String recorridosMantenimientoRoot =
      'assets/jsons/lista_recorridos_mantenimiento.json';
  static const String listForms = 'assets/jsons/list_forms.json';
  // static const String recorridosMantenimientoRoot2 = 'assets/json/lista_recorridos_mantenimiento2.json';

  Future<RecorridosMantenimientoResponse> getRecorridosMantenimiento() async {
    // Lógica para obtener los recorridos de mantenimiento
    // Se obtiene el json de assets
    final Map<String, dynamic> json = await getMapFromJson(recorridosMantenimientoRoot);

    // Se convierte el json a un objeto RecorridoMantenimientoResponse
    return RecorridosMantenimientoResponse.fromJson(json);
  }

  Future<ListFormsResponse> getListForms() async {
    // Lógica para obtener los recorridos de mantenimiento
    // Se obtiene el json de assets
    final Map<String, dynamic> json = await getMapFromJson(listForms);

    // Se convierte el json a un objeto RecorridoMantenimientoResponse
    return ListFormsResponse.fromJson(json);
  }
}

Future<Map<String, dynamic>> getMapFromJson(String jsonRoot) async {
  // primero leemos el json que esta en assets
  String data = await rootBundle.loadString(jsonRoot);

  // luego lo decodificamos
  return json.decode(data) as Map<String, dynamic>;
}
