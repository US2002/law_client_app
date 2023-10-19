// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_is_not_empty
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:law_client_app/pages/home.dart';
import 'package:law_client_app/pages/register.dart';
import 'package:law_client_app/pages/resetPassword.dart';
import 'package:law_client_app/widgets/widgets.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final email = TextEditingController();
  final password = TextEditingController();

  bool _submitted = false;

  void _submit() {
    setState(() => _submitted = true);
    if (_errorTextEmail == null && _errorTextPwd == null) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        navigateToHomePage(context);
      }).catchError((e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Login failed. ${e.toString().trim()}"),
              );
            });
      });
    }
  }

  String? get _errorTextEmail {
    final text = email.value.text;

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (validate(text)) {
      return 'Enter correct mail ID';
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextPwd {
    final text = password.value.text;

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }

    return null;
  }

  Future navigateToRegisterPage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const MyRegister();
      }),
    );
  }

  Future navigateToResetPage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const forgotPassword();
      }),
    );
  }

  Future navigateToHomePage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const homepage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(),
              Container(
                padding: EdgeInsets.only(left: 35, top: height * 0.2),
                child: Text(
                  'Welcome\nBack',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: height * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            LoginTextField("Email", Icons.email_outlined, false,
                                email, _submitted),
                            SizedBox(
                              height: 30,
                            ),
                            LoginTextField("Password", Icons.password_outlined,
                                true, password, _submitted),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: email.value.text.isNotEmpty &&
                                              password.value.text.isNotEmpty
                                          ? _submit
                                          : null,
                                      icon: Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    navigateToRegisterPage(context);
                                  },
                                  style: ButtonStyle(),
                                  child: const Text(
                                    'Sign Up',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      navigateToResetPage(context);
                                    },
                                    child: const Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
