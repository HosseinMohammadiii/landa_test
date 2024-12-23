import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextfieldWidget extends StatelessWidget {
  TextfieldWidget({
    super.key,
    required this.hint,
    this.isShowPassword = false,
    required this.txtController,
    required this.txtFocusNode,
    required this.txtInputType,
    required this.txtInputAction,
  });
  String hint;
  bool? isShowPassword;
  TextEditingController txtController;
  FocusNode txtFocusNode;
  TextInputType txtInputType;
  TextInputAction txtInputAction;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[300],
      ),
      child: TextField(
        keyboardType: txtInputType,
        textInputAction: txtInputAction,
        focusNode: txtFocusNode,
        controller: txtController,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey[500],
        ),
        obscuringCharacter: '*',
        obscureText: isShowPassword ?? false,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.grey[500],
          ),
        ),
        onTapOutside: (event) {
          txtFocusNode.unfocus();
        },
      ),
    );
  }
}
