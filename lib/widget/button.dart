import 'package:flutter/material.dart';

Widget buildElevatedButton(
  final BuildContext context,
  final Function() onTap,
  final String text,
) {
  return ElevatedButton(
    onPressed: onTap,
    style: ButtonStyle(
      elevation: const MaterialStatePropertyAll(3),
      backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(vertical: 5),
      ),
      fixedSize: const MaterialStatePropertyAll(Size.fromWidth(125)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
  );
}

Widget buttonWithIcon(
  final BuildContext context,
  final String text,
  final Icon icon,
  final Function() ontap,
) {
  return ElevatedButton.icon(
    onPressed: ontap,
    icon: icon,
    label: Text(
      text,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    style: ButtonStyle(
      elevation: const MaterialStatePropertyAll(3),
      padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 15, vertical: 12.5)),
      backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
    ),
  );
}

Widget buttonKeluar(
  final BuildContext context,
  final Function() onTap,
  final String text,
) {
  return ElevatedButton(
    onPressed: onTap,
    style: ButtonStyle(
      elevation: const MaterialStatePropertyAll(0),
      backgroundColor: MaterialStatePropertyAll(
        Theme.of(context).primaryColor.withOpacity(0.15),
      ),
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(vertical: 15),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
            width: 1,
            color: Theme.of(context).primaryColor.withOpacity(0.5),
          ),
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    ),
  );
}
