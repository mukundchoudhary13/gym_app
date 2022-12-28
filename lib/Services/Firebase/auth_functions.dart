import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_app/Services/Firebase/auth_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  late AuthResultStatus _status;
  Future<AuthResultStatus> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        _status = AuthResultStatus.successful;
        if (!userCredential.user!.emailVerified) {
          userCredential.user!.sendEmailVerification();
        }
      } else {
        _status = AuthResultStatus.undefined;
      }

      // print('///////// Success ///////');
    } catch (e) {
      // print(e);
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> signIn(String email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          _status = AuthResultStatus.successful;
        } else {
          _status = AuthResultStatus.emailIsNotVerified;
        }
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      // print(e);
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<AuthResultStatus> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _status = AuthResultStatus.successful;
    } catch (e) {
      // TODO
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<void> verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    // print("User Signout");
  }
}
