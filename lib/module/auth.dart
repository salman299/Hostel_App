import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
class Auth with ChangeNotifier {
  String _udi;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String get userId {
    return _udi;
  }

  Future<bool> handleSignIn(String type) async {
    switch (type) {
      case "FB":
        FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
        final accessToken = facebookLoginResult.accessToken.token;
        if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
          final facebookAuthCred = FacebookAuthProvider.credential(accessToken);
          final user = await _firebaseAuth.signInWithCredential(facebookAuthCred);
          print("User : " + user.toString());
          _udi=user.toString();
          return true;
        } else
          return false;
        break;
      case "G":
        try {
          GoogleSignInAccount googleSignInAccount = await _handleGoogleSignIn();
          final googleAuth = await googleSignInAccount.authentication;
          final googleAuthCred = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
          final user = await _firebaseAuth.signInWithCredential(googleAuthCred);
          print("User : " + user.toString());
          _udi=user.toString();
          return true;
        } catch (error) {
          return false;
        }
    }
    notifyListeners();
    return false;
  }

  Future<FacebookLoginResult> _handleFBSignIn() async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult facebookLoginResult =
    await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled");
        break;
      case FacebookLoginStatus.error:
        print("error");
        break;
      case FacebookLoginStatus.loggedIn:
        print("Logged In");
        break;
    }
    return facebookLoginResult;
  }

  Future<GoogleSignInAccount> _handleGoogleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    return googleSignInAccount;
  }

  Future<bool> signIn(String email, String password) async {
    try{
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (await isEmailVerified())
      {
        final user = result.user;
        _udi = user.uid;
        notifyListeners();
        return true;
      }
    }catch(error){
      throw(error);
    }
    return false;
  }
  Future<void> signUp(String email, String password) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      //await sendEmailVerification();
      //await _firebaseAuth.signOut();
      return result.user.uid;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return false;
      }
      _udi = user.uid;
      notifyListeners();
    } catch (error) {
      throw(error);
    }
    return true;
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      _udi=null;
     notifyListeners();
    }catch(error) {
      throw(error);
    }
  }

  Future<void> passwordReset(String _email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: _email);
    }catch(error){
      throw (error);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user.sendEmailVerification();
    }catch(error){
      throw (error);
    }
  }

  Future<bool> isEmailVerified() async {
    try{
      final user = _firebaseAuth.currentUser;
      return user.emailVerified;
    }catch(error){
      throw(error);
    }
    return false;
  }
}
