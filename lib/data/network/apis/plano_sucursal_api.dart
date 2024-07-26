import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PlanoSucursalApi {
  final Dio dio;

  PlanoSucursalApi(this.dio);

  Future<File> getPlanoSucursal() async {
    final random = Random();
    final uri = Uri.parse(dio.options.baseUrl);
    final response = await http.get(uri);

    final dir = await getTemporaryDirectory();

    var fileName = '${dir.path}/SaveImage${random.nextInt(100)}.png';

    final file = File(fileName);
    await file.writeAsBytes(response.bodyBytes);

    return file;
  }
}
