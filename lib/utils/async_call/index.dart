import "package:coffee_base_app/constants.dart";
import "package:coffee_base_app/utils/alert_utils.dart";
import "package:flutter/material.dart";

import "async_call_debug_environment.dart" as async_call_debug_environment;
import "async_call.dart" as async_call;

///
/// Typedefs
///

typedef AsyncCall = async_call.AsyncCall;
typedef AsyncCallDebugEnvironment = async_call_debug_environment.AsyncCallDebugEnvironment;

///
/// handleResponseBody
///

handleResponseBody({
  required BuildContext context,
  required Map<String, dynamic> response,
  void Function(Map<String, dynamic>)? callback,
  void Function()? onDismiss,
}) {
  switch (response) {
    case {"http_success": true, "body": final body as Map<String, dynamic>}:
      {
        callback?.call(body);
      }

    case {"http_success": false, "body": final body}:
      {
        AlertUtils.oneButtonsDialog(
          context: context,
          title: "Error",
          message: body?["message"] ?? defaultErrorMessage,
          buttonLabel: "Ok",
          onButtonClick: onDismiss,
        );
      }
  }
}

///
/// handleResponse
///

handleResponse({
  required BuildContext context,
  required Map<String, dynamic> response,
  void Function(dynamic)? callback,
  void Function()? onDismiss,
}) {
  switch (response) {
    case {"http_success": true, "body": final body}:
      {
        callback?.call(body);
      }

    case {"http_success": false, "body": final body}:
      {
        AlertUtils.oneButtonsDialog(
          context: context,
          title: "Error",
          message: body?["message"] ?? defaultErrorMessage,
          buttonLabel: "Ok",
          onButtonClick: onDismiss,
        );
      }
  }
}
