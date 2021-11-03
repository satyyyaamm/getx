import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_practice/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  var product = <Product>[].obs;
  var loading = false.obs;

  var client = http.Client();
  @override
  void onInit() {
    fetchdata();
    super.onInit();
  }

  Future fetchdata() async {
    loading.value = true;
    String apiurl = 'http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline';
    var url = Uri.parse(apiurl);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      loading.value = false;
      var jsonString = response.body;
      product.value = productFromJson(jsonString);
    } else if (response.statusCode != 200) {
      loading.value = false;
      Get.snackbar('Error', 'Error while loading data!');
      print(product);
    }
  }
}
