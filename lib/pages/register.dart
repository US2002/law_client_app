// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:law_client_app/pages/lawyer.dart';
import 'package:law_client_app/pages/login.dart';

import 'home.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  bool _submitted = false;

  void _submit() {
    setState(() => _submitted = true);
    if (_errorTextName == null &&
        _errorTextEmail == null &&
        _errorTextPwd == null) {
      if (newValue == 'Lawyer') {
        navigateToLawyerPage(context);
      } else {
        navigateToLoginPage(context);
      }
    }
  }

  bool validate(String email) {
    bool isvalid = EmailValidator.validate(email);
    if (isvalid == false) {
      return true;
    } else {
      return false;
    }
    // print(isvalid);
  }

  String? get _errorTextName {
    // at any time, we can get the text from _controller.value.text
    final text = name.value.text;

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextEmail {
    final text = email.value.text;

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (validate(text)) {
      return 'Enter valid email ID';
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextPwd {
    final text = password.value.text;

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 10) {
      return 'Password less than 10 characters';
    }
    return null;
  }

  Future navigateToLawyerPage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return lawyerSignUp();
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

  Future navigateToLoginPage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MyLogin();
      }),
    );
  }

  String? newValue;

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
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/register.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: height * 0.05),
                child: Text(
                  'Create\nAccount',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: height * 0.28),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            TextField(
                              controller: name,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  errorText: _submitted ? _errorTextName : null,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Name",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 1), //border of dropdown button
                                  borderRadius: BorderRadius.circular(
                                      50), //border raiuds of dropdown button
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        color:
                                            Colors.blueGrey, //shadow for button
                                        blurRadius: 5) //blur radius of shadow
                                  ]),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text('Choose'),
                                        onChanged: (String? changedValue) {
                                          newValue = changedValue;
                                          setState(() {
                                            newValue;
                                            // print(newValue);
                                          });
                                        },
                                        value: newValue,
                                        items: <String>[
                                          'Lawyer',
                                          'Client',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextField(
                              controller: email,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  errorText:
                                      _submitted ? _errorTextEmail : null,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextField(
                              controller: password,
                              style: TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                  errorText: _submitted ? _errorTextPwd : null,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            IntlPhoneField(
                              // focusNode: focusNode,
                              decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              languageCode: "en",
                              initialCountryCode: 'IN',
                              onChanged: (phone) {
                                print(phone.completeNumber);
                              },
                              onCountryChanged: (country) {
                                print('Country changed to: ' + country.name);
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (newValue == 'Lawyer')
                                  Text(
                                    'Authenticate',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  )
                                else
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: name.value.text.isNotEmpty &&
                                              email.value.text.isNotEmpty &&
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
                                    navigateToLoginPage(context);
                                  },
                                  style: ButtonStyle(),
                                  child: Text(
                                    'Sign In',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                ),
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
