import 'package:chatmoi/helperfunctions/sharedpref_helper.dart';
import 'package:chatmoi/services/database.dart';
import 'package:chatmoi/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentUser() {
    return auth.currentUser;
  }

  signInWithGoole(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    final AuthCredential? credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    if (credential == null) {
      print('login error');
    } //TODO error handling
    UserCredential result = await auth.signInWithCredential(credential!);
    if (result.user == null) {
      print('login error');
    } //TODO error handling
    User userDetail = result.user!;
    SharedPreferenceHelper().saveUserEmail(userDetail.email!);
    SharedPreferenceHelper().saveUserId(userDetail.uid);
    SharedPreferenceHelper().saveDisplayName(userDetail.displayName!);
    SharedPreferenceHelper().saveUserProfileUrl(userDetail.photoURL!);
    Map<String, dynamic> userInfoMap = {
      'email': userDetail.email,
      'username': userDetail.email!.replaceAll('@gmail.com', 'replace'),
      'name': userDetail.displayName,
      'imageUrl': userDetail.photoURL,
    };
    DatabaseMethodes()
        .addUserInfoToDb(userDetail.uid, userInfoMap)
        .then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    });
  }
}
