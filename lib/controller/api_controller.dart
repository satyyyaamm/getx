import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_practice/model/product_model.dart';
import 'package:getx_practice/services/api_services.dart';
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
    loading(true);
    String apiurl = 'http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline';
    var mainresponse = await ApiServcies.getApi(apiurl);
    if (mainresponse != null) {
      product.value = productFromJson(mainresponse);
      loading(false);
    } else if (mainresponse == null) {
      Get.snackbar("Error", "Error while loading data!");
    }
  }
}
