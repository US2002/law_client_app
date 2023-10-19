// ignore_for_file: non_constant_identifier_names

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

TextField LoginTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, bool submitted) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      errorText: submitted ? _errorMessage(controller, isPasswordType) : null,
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      fillColor: Colors.grey.shade100,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

TextField SignupTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, TextInputType type, bool submitted) {
  bool isEmail = false;
  if (type == TextInputType.emailAddress) {
    isEmail = true;
  }
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      errorText: submitted
          ? _errorMessage2(controller, isPasswordType, isEmail)
          : null,
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.white,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.blueGrey,
        ),
      ),
    ),
    keyboardType: type,
  );
}

String? _errorMessage(TextEditingController controller, bool isPasswordType) {
  final text = controller.value.text;

  if (text.isEmpty) {
    return 'Can\'t be empty';
  }
  if (!isPasswordType) {
    if (validate(text)) {
      return 'Enter correct mail ID';
    }
  }
  // return null if the text is valid
  return null;
}

String? _errorMessage2(
    TextEditingController controller, bool isPasswordType, bool isEmail) {
  final text = controller.value.text;

  if (text.isEmpty) {
    return 'Can\'t be empty';
  }
  if (isEmail && !isPasswordType) {
    if (validate(text)) {
      return 'Enter valid email ID';
    }
  }
  if (!isEmail && isPasswordType) {
    if (text.length < 10) {
      return 'Password less than 10 characters';
    }
  }
  // return null if the text is valid
  return null;
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
