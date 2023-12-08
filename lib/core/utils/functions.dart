import 'dart:async';
import 'dart:io';

bool isEmailValid(String email) {
  Pattern emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(emailPattern.toString());
  return regex.hasMatch(email);
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }

  final phoneNumber = value.replaceAll(RegExp(r'[^0-9]'), '');

  const maxLength = 15;

  if (phoneNumber.length > maxLength) {
    return 'Phone number is too long';
  }

  return null;
}

String toTitleCase(String text) {
  if (text.isEmpty) {
    return '';
  }

  final words = text.split(' ');
  final titleCaseWords = words.map((word) {
    final firstLetter = word.substring(0, 1).toUpperCase();
    final restOfWord = word.substring(1).toLowerCase();
    return '$firstLetter$restOfWord';
  });

  return titleCaseWords.join(' ');
}

void handleException(
    {required dynamic e, required void Function(String message) action}) {
  if (e is TimeoutException) {
    action('Request timed out. Please try again later.');
  } else if (e is SocketException) {
    action('No internet connection. Please check your network.');
  } else {
    action('An unexpected error occurred.');
  }
}
