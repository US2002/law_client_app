// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login.dart';

class lawyerSignUp extends StatefulWidget {
  const lawyerSignUp({super.key});

  @override
  State<lawyerSignUp> createState() => _lawyerSignUpState();
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Upload documents to authenticate."),
    // content: Text("This is an alert message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _lawyerSignUpState extends State<lawyerSignUp> {
  PlatformFile? aadhar;
  PlatformFile? bar;
  UploadTask? uploadaadhar;
  UploadTask? uploadbar;

  Future selectAadhar() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result == null) return;

    setState(() {
      aadhar = result.files.first;
    });
  }

  Future selectBar() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result == null) return;

    setState(() {
      bar = result.files.first;
    });
  }

  bool _submitted = false;

  final textAadhar = TextEditingController();
  final textBar = TextEditingController();

  String? get _errorTextAadhar {
    // at any time, we can get the text from _controller.value.text
    final text = textAadhar.value.text;

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length <= 13) {
      return 'Enter complete number';
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextBar {
    final text = textBar.value.text;

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length <= 13) {
      return 'Enter complete number';
    }
    // return null if the text is valid
    return null;
  }

  void _submit() {
    setState(() => _submitted = true);
    uploadFile();
    if (_errorTextAadhar == null && _errorTextBar == null) {
      if (aadhar != null && bar != null) {
        navigateToLoginPage(context);
      } else {
        showAlertDialog(context);
      }
    }
  }

  Future navigateToLoginPage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MyLogin();
      }),
    );
  }

  Future uploadFile() async {
    final user = FirebaseAuth.instance.currentUser!;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final path = '${user.uid}/${aadhar!.name}';
    final path2 = '${user.uid}/${bar!.name}';

    final file = File(aadhar!.path!);
    final file2 = File(bar!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    final ref2 = FirebaseStorage.instance.ref().child(path2);

    uploadaadhar = ref.putFile(file);
    uploadbar = ref2.putFile(file2);

    aadhar = null;

    final snapshot = await uploadaadhar!.whenComplete(() {});
    final snapshot2 = await uploadbar!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    final urlDownload2 = await snapshot2.ref.getDownloadURL();

    print('Download URL: $urlDownload');
    print('Download URL: $urlDownload2');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadaadhar?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;

            return SizedBox(
              height: 20,
              width: width * 0.5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return SizedBox(
              height: 10,
            );
          }
        });
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
              image: AssetImage('assets/login.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(),
              Container(
                padding: EdgeInsets.only(left: 30, top: height * 0.2),
                child: Text(
                  'Lawyer\nAuthorisation',
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
                            TextField(
                              controller: textAadhar,
                              maxLength: 14,
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                new CustomInputFormatter()
                              ],
                              decoration: InputDecoration(
                                  counterText: " ",
                                  errorText:
                                      _submitted ? _errorTextAadhar : null,
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Aadhaar Number",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                              onPressed: selectAadhar,
                              child: Text("Select File"),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            if (aadhar != null) Text(aadhar!.name),
                            SizedBox(
                              height: 8,
                            ),
                            buildProgress(),
                            SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: textBar,
                              maxLength: 14,
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CustomInputFormatter()
                              ],
                              decoration: InputDecoration(
                                  counterText: " ",
                                  errorText: _submitted ? _errorTextBar : null,
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "BAR Registration Number",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                              onPressed: selectBar,
                              child: Text("Select File"),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            if (bar != null) Text(bar!.name),
                            SizedBox(
                              height: 8,
                            ),
                            buildProgress(),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed:
                                          textAadhar.value.text.isNotEmpty &&
                                                  textBar.value.text.isNotEmpty
                                              ? _submit
                                              : null,
                                      icon: Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
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
