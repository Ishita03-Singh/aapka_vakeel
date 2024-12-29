import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<void> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      MySharedPreferences.instance.RemoveUserLoggedIn();
      print('User signed out successfully');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
