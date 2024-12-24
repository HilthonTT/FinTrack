import 'package:fintrack_app/core/common/toasts/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(FToast fToast, String message, IconData icon) {
  fToast.showToast(
    child: CustomToast(message: message, icon: icon),
    gravity: ToastGravity.BOTTOM_RIGHT,
    toastDuration: Duration(seconds: 2),
  );
}
