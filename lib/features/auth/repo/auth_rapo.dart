import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/student_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> signUp(String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Error signing up: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Error signing in: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Error signing out: $e');
    }
  }

  Future<void> updateUserInfo(StudentModel studentModel) async {
    try {
      await _firebaseFirestore
          .collection('student')
          .doc(studentModel.userId)
          .set(studentModel.toMap());
    } catch (e) {
      throw Exception('Error updating user info: $e');
    }
  }

  Future<StudentModel?> getUserInfo() async {
    //try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      if (userId == null) {
        final user = _firebaseAuth.currentUser;
        if (user == null) {
          // User is not signed in
          return null;
        }
        userId = user.uid;
      }

      final snapshot =
          await _firebaseFirestore.collection('student').doc(userId).get();
      if (snapshot.exists) {
        return StudentModel.fromMap(snapshot.data()!);
      }
      return null;
    // } catch (e) {
    //   throw Exception('Error getting user info: $e');
    // }
  }
}
