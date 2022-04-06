import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  auth.User? _user(auth.User? user) {
    if (user == null) {
      return null;
    }
    return user;
  }

  Stream<auth.User?>? get user {
    return _firebaseAuth.authStateChanges().map(_user);
  }

  Future<auth.User?> SignInWithEmail(
      {String email = '', String password = ''}) async {
    auth.UserCredential? credentials;
    try {
      credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == "weak_password") {
        print("Weak Password");
      } else if (e.code == "email-already-in-use") {
        print("Email is already in user");
      }
    } catch (e) {
      print(e);
    }

    return _user(credentials?.user);
  }

  Future<auth.User?> SignUpWithEmail(
      {String email = '', String password = ''}) async {
    final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return _user(credentials.user);
  }

  Future<void> SignOut() async {
    return await _firebaseAuth.signOut();
  }
}
