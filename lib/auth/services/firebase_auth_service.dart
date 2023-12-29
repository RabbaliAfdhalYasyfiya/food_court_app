import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    final scaffoldM = ScaffoldMessenger.of(context);
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.email)
          .set({'username': email.split('@')[0]});
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        scaffoldM.showSnackBar(
          SnackBar(
            showCloseIcon: true,
            backgroundColor: Colors.yellowAccent,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            behavior: SnackBarBehavior.floating,
            content: const Text(
              'Email address is already in use',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      } else {
        scaffoldM.showSnackBar(
          SnackBar(
            showCloseIcon: true,
            backgroundColor: Colors.orangeAccent,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'An error occurred: ${e.code}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      }
    }
    return null;
  }

  Future<User?> signInEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    final scaffoldM = ScaffoldMessenger.of(context);

    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        scaffoldM.showSnackBar(
          SnackBar(
            showCloseIcon: true,
            backgroundColor: Colors.redAccent,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            behavior: SnackBarBehavior.floating,
            content: const Text(
              'Invalid email or password',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      } else {
        scaffoldM.showSnackBar(
          SnackBar(
            showCloseIcon: true,
            backgroundColor: Colors.orangeAccent,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'An error occurred: ${e.code}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      }
    }
    return null;
  }

  Future<User?> signInWithGoogleAccount(
    BuildContext context,
  ) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final scaffoldM = ScaffoldMessenger.of(context);
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _auth.signInWithCredential(credential);
      }

      FirebaseFirestore.instance
          .collection('users')
          .doc(googleSignInAccount!.email)
          .set({
        'username': googleSignInAccount.displayName,
        'image': googleSignInAccount.photoUrl
      });
    } catch (e) {
      scaffoldM.showSnackBar(
        SnackBar(
          showCloseIcon: true,
          backgroundColor: Colors.orangeAccent,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Some error occurred: $e',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      );
    }
    return null;
  }
}
