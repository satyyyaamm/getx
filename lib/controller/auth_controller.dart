// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_practice/screens/home_screen.dart';
import 'package:getx_practice/screens/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _codeController = TextEditingController();
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
      final googleSignInAccount = await _googleSignIn.signIn();
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
  Future loginWithFacebook() async {}

// Phone number authentication
  Future phoneAuthentication(String phoneNumber, BuildContext context) async {
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        UserCredential result = await _auth.signInWithCredential(credential);
        _firebaseUser.value = result.user;
        if (_firebaseUser.value != null) {
          Get.offAll(() => const HomeScreen());
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String verificationID, int? forceResendToken) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                  title: const Text('Give us the code!'),
                  content: Column(
                    children: [
                      TextField(
                        controller: _codeController,
                      ),
                      TextButton(
                          onPressed: () async {
                            final code = _codeController.text.trim();
                            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                                verificationId: verificationID, smsCode: code);
                            UserCredential result = await _auth.signInWithCredential(credential);
                            _firebaseUser.value = result.user;
                            if (_firebaseUser.value != null) {
                              Get.offAll(() => const HomeScreen());
                            }
                          },
                          child: const Text('Confrim'))
                    ],
                  ));
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

// sign out
  Future signout() async {
    await _auth.signOut().then((value) => Get.offAll(() => LoginScreen()));
  }
}
