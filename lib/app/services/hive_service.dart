import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

String myBox = 'myBox';

class HiveService {
  static Future<Box> openHiveBox() async {
    if (!Hive.isBoxOpen(myBox)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    return await Hive.openBox(myBox);
  }

  static Future<Map<String, dynamic>?> get(String txt) async {
    var box = await openHiveBox();
    Map<String, dynamic> data = {};
    // try {
    var f = box.get(txt);
    var d = json.encode(f, toEncodable: myEncode);
    data = json.decode(d);
    // } catch (e) {
    //   return null;
    // }

    return data;
  }

  static Future getKey() async {
    var box = await openHiveBox();
    var data = box.keys;
    return data;
  }

  static Future put(
      {required String key, required Map<String, dynamic> data}) async {
    var box = await openHiveBox();
    box.put(key, data);
  }

  static Future clear() async {
    var box = await openHiveBox();
    await box.clear();
  }
}



dynamic myEncode(dynamic item) {
  if(item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}