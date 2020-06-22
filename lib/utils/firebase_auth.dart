import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

/*Future CreateUser({
String email,
 String password,
  String name,
})async {
  try {
      var u = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          UserUpdateInfo info = UserUpdateInfo();
      //FirebaseUser user = u.user;
      info.displayName ='$name';
      await u.user.updateProfile(info);
      //notifyListners();
      return u.user;
}catch(e){
  throw AuthException(e.code, e.message);
}

}
*/

  Future<bool> signUpWithEmail(
      String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _auth.currentUser();
    return user.isEmailVerified;
  }
}
