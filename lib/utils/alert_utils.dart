import 'package:flutter/material.dart';

///
/// AlertUtils
///

class AlertUtils {
  static twoButtonsDialog({
    required BuildContext context,
    String title = "",
    String message = "",
    String positiveButtonLabel = "Yes",
    String negativeButtonLabel = "No",
    void Function()? onPositiveClick,
    void Function()? onNegativeClick,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                onPositiveClick?.call();
                Navigator.of(context).pop();
              },
              child: Text(positiveButtonLabel),
            ),
            ElevatedButton(
              onPressed: () {
                onNegativeClick?.call();
                Navigator.of(context).pop();
              },
              child: Text(negativeButtonLabel),
            ),
          ],
        );
      },
    );
  }

  static oneButtonsDialog({
    required BuildContext context,
    String title = "",
    String message = "",
    String buttonLabel = "Ok",
    void Function()? onButtonClick,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text(title), content: Text(message), actions: [
          ElevatedButton(
            onPressed: () {
              onButtonClick?.call();
              Navigator.of(context).pop();
            },
            child: Text(buttonLabel),
          )
        ]);
      },
    );
  }

  static snackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
