import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/models/loginData.dart';
import 'package:onregardequoicesoir/models/registerData.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Firestore _db = Firestore.instance;

  Stream<FirebaseUser> user;
  Future<FirebaseUser> userLogged;

  AuthService() {
    user = _auth.onAuthStateChanged;
    userLogged = _auth.currentUser();
  }

  Future<FirebaseUser> registerUser(RegisterData data) async {
    
      _auth.createUserWithEmailAndPassword(
          email: data.email.toLowerCase(), password: data.password);

    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
            email: data.email.toLowerCase(), password: data.password))
        .user;

    setUserData(data, user);

    return user;
  }

  Future<FirebaseUser> signIn(LoginData data) async {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
            email: data.email.toLowerCase(), password: data.password))
        .user;

    updateUserData(user);

    return user;
  }

  Future<FirebaseUser> googleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

    updateUserData(user);

    print("sign in " + user.displayName);

    return user;
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);
    String surname = user.displayName.split(" ")[0];

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'surname': surname,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  void signOut() {
    _auth.signOut();
  }

  void setUserData(RegisterData data, FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);
    String surname = data.name.split(" ")[0];
    String photoUrl = data.photoUrl;

    if (data.photoUrl == null || data.photoUrl.isEmpty) {
      photoUrl =
          "https://framapiaf.s3.framasoft.org/framapiaf/accounts/avatars/000/073/197/original/15d78f8e53a8ce2b.jpg";
    }

    return ref.setData({
      'uid': user.uid,
      'email': data.email.toLowerCase(),
      'photoUrl': photoUrl,
      'surname': surname.toLowerCase(),
      'displayName': data.name.toLowerCase(),
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  Future<bool> isEmailAlreadyExists(String email) async {
    final QuerySnapshot result = await _db
        .collection('users')
        .where('email', isEqualTo: email.toLowerCase())
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }
}

final AuthService authService = AuthService();
