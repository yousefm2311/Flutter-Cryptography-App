import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void defaultToast({required String message}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 14.0);

Widget defaultTextFormField(
        {required var controllder,
        String? Function(String?)? validator,
        ValueChanged<String>? submit,
        IconData? perfix,
        required String text}) =>
    TextFormField(
      onFieldSubmitted: submit,
      validator: validator,
      cursorColor: Colors.black,
      controller: controllder,
      decoration: InputDecoration(
        prefixIcon: Icon(perfix),
        // prefixIconColor: Colors.black,
        prefixIconColor: Colors.white,
        focusColor: Colors.black,
        contentPadding: const EdgeInsets.fromLTRB(20, 12, 15, 12),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.4),
          borderRadius: BorderRadius.circular(9.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black87, width: 1.3),
          borderRadius: BorderRadius.circular(9.0),
        ),
        floatingLabelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(9.0),
        ),
        hintText: text,
      ),
    );

void defalutNavigator(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void defalutNavigatorReplacement(context, widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget),
        (Route<dynamic> route) => false);

Widget defaultContainer(
        {Color? color,
        required String text,
        required VoidCallback ontap,
        required Color colorText,
        required Color colorBorder}) =>
    GestureDetector(
      onTap: ontap,
      child: Container(
        width: 167,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            color: color,
            border: Border(
              bottom: BorderSide(color: colorBorder, width: 1.2),
              top: BorderSide(color: colorBorder, width: 1.2),
              right: BorderSide(color: colorBorder, width: 1.2),
              left: BorderSide(color: colorBorder, width: 1.2),
            )),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: colorText, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
