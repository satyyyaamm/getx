import 'package:get/get.dart';
import 'package:getx_practice/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiServcies {
  static Future getApi(String apiUrl) async {
    var client = http.Client();
    var url = Uri.parse(apiUrl);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonString;
    } else if (response.statusCode != 200) {
      return null;
    }
  }
}
