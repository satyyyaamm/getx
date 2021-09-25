import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_practice/screens/home_screen.dart';
import 'package:getx_practice/screens/login_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();

  // getter to get the user value
  get user => _firebaseUser.value?.email;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  // create account
  Future createAccount({
    String? firstName,
    String? lastName,
    required String email,
    required String password,
  }) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
          (value) => Get.offAll(() => const HomeScreen()),
        )
        .catchError((error) {
      Get.snackbar('Error while creating account', error.message);
    });
  }

  // Login
  Future login({
    required String email,
    required String password,
  }) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
          (value) => Get.offAll(() => const HomeScreen()),
        )
        .catchError((error) {
      Get.snackbar('Error Logging In ', error.message);
    });
  }

  Future signout() async {
    await _auth.signOut().then((value) => Get.offAll(() => LoginScreen()));
  }
}
