import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioFactory {
  final SharedPreferences sharedPreferences;

  const DioFactory(this.sharedPreferences);

  Future<Dio> getDio() async {
    final dio = Dio();

    const Duration timeout = Duration(minutes: 1);

    final headers = {
      'Content-Type': 'application/json',
    };

    

    dio.options = BaseOptions(
      headers: headers,
      baseUrl: 'https://dosomthings.com/wp-content/uploads/2022/07/dc0a7e44e96647848177c8afd4bdabdd.png',
      connectTimeout: timeout,
      receiveTimeout: timeout,
      sendTimeout: timeout,
    );

    return dio;
  }
}