import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget fieldFormEmail(
  BuildContext context,
  String hintText,
  TextEditingController controller,
  IconData icon,
  TextInputType inputType,
) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: TextFormField(
        onChanged: (value) {
          controller.text = value;
        },
        controller: controller,
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        keyboardType: inputType,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          letterSpacing: 1,
          fontWeight: FontWeight.w500,
        ),
        selectionControls: EmptyTextSelectionControls(),
        enableInteractiveSelection: true,
        canRequestFocus: true,
        showCursor: false,
        cursorColor: Colors.black,
        obscureText: false,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              icon,
              color: Colors.grey.shade600,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: BorderSide(
              width: 1,
              style: BorderStyle.solid,
              color: Colors.grey.shade600,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: BorderSide(
              width: 2,
              style: BorderStyle.solid,
              color: Theme.of(context).primaryColor,
            ),
          ),
          contentPadding: const EdgeInsets.all(17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade600,
            fontSize: 15,
            letterSpacing: 0.5,
          ),
        ),
      ),
    ),
  );
}

Widget fieldFormPassword(
  GestureTapCallback onTap,
  bool obscure,
  BuildContext context,
  String hintText,
  TextEditingController controller,
) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: TextFormField(
        onChanged: (value) {
          controller.text = value;
        },
        controller: controller,
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        keyboardType: TextInputType.visiblePassword,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          letterSpacing: 1,
          fontWeight: FontWeight.w500,
        ),
        selectionControls: EmptyTextSelectionControls(),
        enableInteractiveSelection: true,
        canRequestFocus: true,
        showCursor: false,
        cursorColor: Colors.black,
        obscureText: !obscure,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              CupertinoIcons.lock,
              color: Colors.grey.shade600,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: onTap,
              visualDensity: VisualDensity.comfortable,
              icon: Icon(
                obscure ? CupertinoIcons.eye : CupertinoIcons.eye_slash_fill,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: BorderSide(
              width: 1,
              style: BorderStyle.solid,
              color: Colors.grey.shade600,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: BorderSide(
              width: 1.5,
              style: BorderStyle.solid,
              color: Theme.of(context).primaryColor,
            ),
          ),
          contentPadding: const EdgeInsets.all(17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade600,
            fontSize: 15,
            letterSpacing: 0.5,
          ),
        ),
      ),
    ),
  );
}
