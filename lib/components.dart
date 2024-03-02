import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

void navigateTo({
  required Widget screenToView,
  required BuildContext context,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screenToView,
    ),
  );
}

// context.navigateTo();
extension NavigatorExtension on BuildContext {
  void navigatePush({
    required Widget screenToView,
  }) async {
    await Navigator.push(
      this,
      // this keyWord refers to context that call this function (navigateTo)
      MaterialPageRoute(
        builder: (context) => screenToView,
      ),
    );
  }

  void navigatePushReplacement({
    required Widget screenToView,
  }) async {
    await Navigator.pushReplacement(
        this,
        // this keyWord refers to context that call this function (navigateTo)
        MaterialPageRoute(
          builder: (context) => screenToView,
        ));
  }
}

Widget defaultButton({
  double width = double.infinity,
  Color? background,
  double radius = 20.0,
  bool isUpperCase = true,
  required String text,
  required Function() onPressedFunction,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        color: background ?? defaultColor,
      ),
      child: MaterialButton(
        onPressed: onPressedFunction,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType boardType,
  required String label,
  required IconData prefix,
  required String? Function(String?)? validate,
  void Function(String)? onChange,
  void Function(String)? onSubmit,
  void Function()? onTap,
  IconData? suffix,
  bool obscure = false,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: boardType,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate!,
      decoration: InputDecoration(
        //contentPadding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: defaultColor!),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: defaultColor!),
        ),
        labelText: label,
        //enabled: false,

        prefixIcon: Icon(
          prefix,
          color: defaultColor,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
                color: defaultColor,
              )
            : null,
      ),
    );

void showToast({
  required String msg,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      // المده اللي هتظهرها في الاندرويد
      gravity: ToastGravity.BOTTOM,
      // هتظهر فين
      timeInSecForIosWeb: 5,
      // المده اللي هتظهرها في الويب و ال ios
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { success, error, warning }

Color toastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.yellow;
      break;
  }
  return color;
}
