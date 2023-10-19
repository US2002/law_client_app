import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:law_client_app/Services/user_info.dart';

import 'login.dart'; // Import your UserInfoService

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final user = FirebaseAuth.instance.currentUser!;
  final userInfoService = UserInfoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: FutureBuilder<String>(
            future: userInfoService
                .getNameFromFirestore(), // Call the getNameFromFirestore method
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...");
              } else if (snapshot.hasData) {
                return Text("Logout as: ${snapshot.data}");
              } else {
                return Text("Error: ${snapshot.error}");
              }
            },
          ),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              print("Signed Out");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyLogin()));
            });
          },
        ),
      ),
    );
  }
}
