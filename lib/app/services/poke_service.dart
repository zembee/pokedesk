import 'package:dio/dio.dart';
import 'package:pokedesk/app/models/poke_data_model.dart';
import 'package:pokedesk/app/models/poke_list_model.dart';
import 'package:pokedesk/base/api_service.dart';

class PokeService {
  static Future<PokeList> list({required int offset}) async {
    String url = 'pokemon?limit=10&offset=$offset';
    Response res = await DioClient.dio.get(url);
    if (res.statusCode == 200) {
      return pokeListFromJson(res.data);
    } else {
      throw Exception();
    }
  }

  static Future<PokeData> pokemon({required String name}) async {
    String url = 'pokemon/$name';
    Response res = await DioClient.dio.get(url);
    if (res.statusCode == 200) {
      return pokeDataFromJson(res.data);
    } else {
      throw Exception();
    }
  }
}
