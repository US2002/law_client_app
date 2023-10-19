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
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userEmail, password: userPassword)
        .then((value) {
      addClientDetails(userName, userEmail, phoneNumber);
      print("Client added");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Client Added!!"),
            );
          });
      navigateToLoginPage(context);
    });
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
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userEmail, password: userPassword)
        .then((value) {
      navigateToHomePage(context);
    });
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
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userEmail, password: userPassword)
        .then((value) {
      addLawyerDetails(userName, userEmail, phoneNumber);
      print("Lawyer added");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Lawyer Added!!"),
            );
          });
      navigateToLawyerPage(context);
    });
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
  await FirebaseFirestore.instance.collection('Lawyer').add({
    'name': name,
    'email': email,
    'phonenumber': phoneNumber,
    'timestamp': Timestamp.now(),
  });
  print("Details Added");
}

Future addClientDetails(String name, String email, String phoneNumber) async {
  await FirebaseFirestore.instance.collection('Client').add({
    'name': name,
    'email': email,
    'phonenumber': phoneNumber,
    'timestamp': Timestamp.now(),
  });
  print("Details Added");
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
