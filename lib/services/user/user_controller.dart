import 'package:firebase_auth/firebase_auth.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  final String USER_EMAIL_KEY = "user_email";
  final String USER_UID_KEY = "user_uid";

  Future<FirebaseUser> getUserAuthenticated() {
    return FirebaseAuth.instance.currentUser();
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      // Error doing logout
      return false;
    }
    return true;
  }

  /*Future saveUserData(FirebaseUser user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_EMAIL_KEY, user.email);
    prefs.setString(USER_UID_KEY, user.uid);
  }

  Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(USER_EMAIL_KEY) ?? null;
    return value;
  }

    Future<String> getUserUID() async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(USER_UID_KEY) ?? null;
    return value;
  }
  */
}
