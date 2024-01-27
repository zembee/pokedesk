import "package:dio/dio.dart";

class DioClient {
  static const String _baseUrl = "https://pokeapi.co/api/v2/";
  static Dio dio = Dio(BaseOptions(baseUrl: _baseUrl));
}
