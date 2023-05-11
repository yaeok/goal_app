import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// ログイン中のFirebaseUserを返す
  User? get signInUser => _auth.currentUser;

  bool get isSignedIn => _auth.currentUser != null;

  bool get isNotSignedIn => _auth.currentUser == null;

  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('versions')
      .doc('0.0.1')
      .collection('users');

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
    // Sign in with the credential
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Store user data in Firestore
    await storeUserData(userCredential);

    // Once signed in, return the UserCredential
    return userCredential;
  }

  Future<void> storeUserData(UserCredential userCredential) async {
    final user = userCredential.user;
    final userData = {
      'uid': user?.uid,
      'name': user?.displayName,
      'email': user?.email,
    };

    try {
      await usersCollection.doc(user?.uid).set(userData);
      print('User data stored in Firestore.');
    } catch (e) {
      print('Failed to store user data: $e');
    }
  }
}
