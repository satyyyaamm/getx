import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_practice/controller/notification_controller.dart';
import 'package:getx_practice/model/product_model.dart';
import 'package:getx_practice/model/user_update_model.dart';
import 'package:getx_practice/model/usermodel.dart';
import 'package:getx_practice/services/api_services.dart';

class ApiController extends GetxController {
  var product = <Product>[].obs;
  var loading = false.obs;
  late final usermodel = UserModel().obs;
  late final userUpdateModel = UserUpdateModel().obs;
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController jobtitlecontroller = TextEditingController();
  @override
  void onInit() {
    fetchdata();
    super.onInit();
  }

  //  get request function
  Future fetchdata() async {
    loading(true);
    String apiurl = 'http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline';
    var dataToGet = await ApiServices.getApi(apiurl);
    if (dataToGet != null) {
      product.value = productFromJson(dataToGet);
      loading(false);
    } else if (dataToGet == null) {
      Get.snackbar("Error", "Error while loading data!");
      loading(false);
    }
  }

// post request
  Future postdata() async {
    loading(true);
    String apiUrl = 'https://reqres.in/api/users';
    Map<String, dynamic> dataToPost = {'name': namecontroller.text, 'job': jobtitlecontroller.text};
    var dataToGet = await ApiServices.postApi(apiUrl, dataToPost);
    if (dataToGet != null) {
      usermodel.value = userModelFromJson(dataToGet);
      NotificationController.httpPostFCMNotification(namecontroller.text, jobtitlecontroller.text);
      loading(false);
    } else if (dataToGet == null) {
      Get.snackbar('Error', 'Error posting the data');
      loading(false);
    }
  }

// put request
  Future putdata() async {
    // loading(true);
    String apiUrl = 'https://reqres.in/api/users/2';
    Map<String, dynamic> dataToPost = {'name': namecontroller.text, 'job': jobtitlecontroller.text};
    var dataToGet = await ApiServices.putApi(apiUrl, dataToPost);
    if (dataToGet != null) {
      print('printing name without the usermodel class ${json.decode(dataToGet)['name']}');
      userUpdateModel.value = userUpdateModelFromJson(dataToGet);
      print(userUpdateModel.value.name);
      loading(false);
    } else if (dataToGet == null) {
      Get.snackbar('Error', 'Error posting the data');
      loading(false);
    }
  }

// delete request
  Future deletedata() async {
    String apiUrl = 'https://reqres.in/api/users/2';
    var dataToGet = await ApiServices.deleteApi(apiUrl);
    print('delete data  $dataToGet');
    if (dataToGet != null) {
      print('in null');
      Get.snackbar('Successful', 'Successfully deleted your data as per request!');
    } else {
      print('in not null');
    }
  }
}
