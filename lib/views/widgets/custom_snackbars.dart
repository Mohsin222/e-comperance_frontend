//Custom class in project directory
import 'package:flutter/material.dart';

class CustomSnackBar {
  CustomSnackBar._();
  // show Error SnackBar
  static buildErrorSnackbar(BuildContext context, String message,
      {int snackbarDisplayDurationSeconds = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: snackbarDisplayDurationSeconds),
      ),
    );
  }

  // show Success SnackBar
  static buildSuccessSnackbar(BuildContext context, String message,
      {int snackbarDisplayDurationSeconds = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: snackbarDisplayDurationSeconds),
      ),
    );
  }

  // show Warning SnackBar
  static buildWarningSnackbar(BuildContext context, String message,
      {int snackbarDisplayDurationSeconds = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.yellow,
        duration: Duration(seconds: snackbarDisplayDurationSeconds),
      ),
    );
  }

  // show Info SnackBar
  static buildInfoSnackbar(BuildContext context, String message,
      {int snackbarDisplayDurationSeconds = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: snackbarDisplayDurationSeconds),
      ),
    );
  }
}
