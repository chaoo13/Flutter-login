import 'package:building/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userFromFirebaseUser(User user, {String username}) {
    String uname = username ?? "";
    return user != null
        ? MyUser(
            uid: user.uid,
            email: user.email,
            // displayName: user.displayName,
            // photoUrl: user.photoURL,
            // userName: uname
          )
        : null;
  }

  // sign in ano
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password

  // register with email & password

  // sign out
}
