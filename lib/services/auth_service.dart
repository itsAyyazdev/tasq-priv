import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<User> signInWithGoogle();
  Future<User> getCurrentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<User> getCurrentUser() async {
    var user = _firebaseAuth.currentUser;
    return user;
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      var _auth = await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: _auth.idToken,
        accessToken: _auth.accessToken,
      );
      // var data = (await _firebaseAuth.signInWithCredential(credential)).user;

      return (await _firebaseAuth.signInWithCredential(credential)).user;
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
