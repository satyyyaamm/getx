import 'package:http/http.dart' as http;

class ApiServices {
  //static common client
  static var client = http.Client();

  // function for uri.parse
  static dynamic uriparser(String url) {
    Uri parsedUrl = Uri.parse(url);
    return parsedUrl;
  }

  // get request used in a common way!
  static Future getApi(String apiUrl) async {
    var url = uriparser(apiUrl);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonString;
    } else if (response.statusCode != 200) {
      return null;
    }
  }

  // post request used in a common way!
  static Future postApi(String apiUrl, body) async {
    var url = uriparser(apiUrl);

    var response = await client.post(
      url,
      body: body,
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      var jsonString = response.body;
      return jsonString;
    } else if (response.statusCode != 200) {
      return null;
    }
  }

// put request used in a common way!
  static Future putApi(String apiUrl, body) async {
    var url = uriparser(apiUrl);
    var response = await client.put(url, body: body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonString;
    } else if (response.statusCode != 200) {
      return null;
    }
  }

  // delete request used in a common way!
  static Future deleteApi(String apiUrl) async {
    var url = uriparser(apiUrl);
    var response = await client.delete(url);
    if (response.statusCode == 204) {
      print(' delete api request ${response.statusCode}');
      var jsonString = response.body;
      return jsonString;
    } else if (response.statusCode != 204) {
      return null;
    }
  }
}
