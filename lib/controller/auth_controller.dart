import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_practice/screens/home_screen.dart';
import 'package:getx_practice/screens/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  final GoogleSignIn googleSignIn = GoogleSignIn();

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

// Login with google
  Future loginWithGoogle() async {
    try {
      final googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);
      final User? currentUser = _auth.currentUser;
      assert(user!.uid == currentUser!.uid);
      Get.offAll(() => const HomeScreen()); // navigate to your wanted page
      return;
    } catch (error) {
      Get.snackbar('Error while signing in with google', error.toString());
    }
  }

// Login with facebook
  Future loginWithFacebook() async {
    
  }

  Future signout() async {
    await _auth.signOut().then((value) => Get.offAll(() => LoginScreen()));
  }
}
