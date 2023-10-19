// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:law_client_app/pages/home.dart';

import '../pages/lawyer.dart';
import '../pages/login.dart';

Future<dynamic> signUpWithClientEmail({
  required BuildContext context,
  required String userName,
  required String userEmail,
  required String userPassword,
  required String phoneNumber,
}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );
    await addClientDetails(userName, userEmail, phoneNumber);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Client Added!!"),
          );
        });

    navigateToLoginPage(context);
  } catch (e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.toString().trim()),
          );
        });
  }
}

Future<dynamic> signInWithEmail({
  required BuildContext context,
  required String userEmail,
  required String userPassword,
}) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );

    navigateToHomePage(context);
  } catch (e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.toString().trim()),
          );
        });
  }
}

Future<dynamic> signUpWithLawyerEmail({
  required BuildContext context,
  required String userName,
  required String userEmail,
  required String userPassword,
  required String phoneNumber,
}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );
    addLawyerDetails(userName, userEmail, phoneNumber);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Lawyer Added!!"),
          );
        });

    navigateToLawyerPage(context);
  } catch (e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.toString().trim()),
          );
        });
  }
}

void addLawyerDetails(String name, String email, phoneNumber) async {
  try {
    await FirebaseFirestore.instance.collection('Lawyer').add({
      'name': name,
      'email': email,
      'phonenumber': phoneNumber,
      'timestamp': Timestamp.now(),
    });
    print("Details Added");
  } catch (e) {
    print("Error adding lawyer details: $e");
  }
}

Future addClientDetails(String name, String email, String phoneNumber) async {
  try {
    await FirebaseFirestore.instance.collection('Client').add({
      'name': name,
      'email': email,
      'phonenumber': phoneNumber,
      'timestamp': Timestamp.now(),
    });
    print("Details Added");
  } catch (e) {
    print("Error adding client details: $e");
  }
}

Future navigateToHomePage(context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return const homepage();
    }),
  );
}

Future navigateToLawyerPage(context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return lawyerSignUp();
    }),
  );
}

Future navigateToLoginPage(context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return MyLogin();
    }),
  );
}
