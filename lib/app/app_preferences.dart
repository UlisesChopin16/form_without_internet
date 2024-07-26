// ignore_for_file: constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

const String FACHADA = 'fachada';
const String SECTION = 'section';
const String PLANO_SUCURSAL = 'plano_sucursal';

class AppPreferences {
  final SharedPreferences sharedPreferences;

  AppPreferences(this.sharedPreferences);

  // static const String _keyIsFirstTime = 'is_first_time';
  // static const String _keyAccessToken = 'access_token';

  Future<bool> setFachada(String folio, String value) async {
    final data = await sharedPreferences.setString('$FACHADA$folio', value);
    return data;
  }

  String getFachada(String folio) {
    return sharedPreferences.getString('$FACHADA$folio') ?? '';
  }

  Future<bool> dropFachada(String folio) async {
    final data = await sharedPreferences.remove('$FACHADA$folio');
    return data;
  }

  Future<bool> setSection({
    required String folio,
    required String sectionP,
    required String value,
  }) async {
    final String key = '$SECTION:$sectionP$folio';
    final data = await sharedPreferences.setString(key, value);
    return data;
  }

  String getSection({required String folio, required String sectionP}) {
    final String key = '$SECTION:$sectionP$folio';
    final data = sharedPreferences.getString(key) ?? '';
    return data;
  }

  Future<bool> dropSection({required String folio, required String sectionP}) async {
    final String key = '$SECTION:$sectionP$folio';
    final data = await sharedPreferences.remove(key);
    return data;
  }

  Future<bool> setPlanoSucursal(String folio, String value) async {
    final data = await sharedPreferences.setString(PLANO_SUCURSAL + folio, value);
    return data;
  }

  String getPlanoSucursal(String folio) {
    return sharedPreferences.getString(PLANO_SUCURSAL + folio) ?? '';
  }

  Future<bool> dropPlanoSucursal(String folio) async {
    final data = await sharedPreferences.remove(PLANO_SUCURSAL + folio);
    return data;
  }
}
