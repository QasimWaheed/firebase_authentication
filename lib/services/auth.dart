import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:testing_app/ui/widget/toaster.dart';

class UserAuthentication extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  FirebaseAuth auth() => _auth;

  verifyPhoneNumber(String phone) async {
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign the user in (or link) with the auto-generated credential
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        } else {
          print("Error ::: $e");
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await _auth.signInWithCredential(credential);
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password).then((user) async {
        if (user.user != null && !user.user!.emailVerified) {
          await user.user!.sendEmailVerification();
        }
        authStateChange();
        return user.user;
      }).catchError((error) {
        print(error);
        if (error.code == 'user-not-found') {
          MyToaster.showToaster(error.message);
          print('No user found for that email.');
        } else if (error.code == 'wrong-password') {
          MyToaster.showToaster(error.message);
          print('Wrong password provided for that user.');
        }
      });
      return result;
    } catch (e) {
      print("Error::: ${e.toString()}");
      return null;
    }
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password, String phone, String name) async {
    try {
     final result = await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user) async {
        if (user.user != null && !user.user!.emailVerified) {
          await user.user!.sendEmailVerification();
        }
        authStateChange();
        return user.user;
      }).catchError((error) {
        print(error.toString());
        if (error.code == 'weak-password') {
          MyToaster.showToaster(error.message);
          print('The password provided is too weak.');
        } else if (error.code == 'email-already-in-use') {
          MyToaster.showToaster(error.message);
          print('The account already exists for that email.');
        }
      });
     return result;
    } catch (e) {
      print("Error ::: ${e.toString()}");
    }
    return null;
  }

  Stream<User> authStateChange() async* {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        MyToaster.showToaster('User is currently signed out!');
      } else {
        MyToaster.showToaster('User is signed in!');
      }
    });
    notifyListeners();
  }

  idTokenChanges() {
    _auth.idTokenChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    notifyListeners();
  }

  userChanges() {
    _auth.userChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  logout() {
    _auth.signOut();
    notifyListeners();
  }
}