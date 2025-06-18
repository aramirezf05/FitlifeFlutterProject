import 'package:fitlife/utils/number_constants.dart';
import 'package:flutter/material.dart';

final greenColor = Colors.green;
final orangeColor = Colors.orange;
final greyColor = Colors.grey;

Widget fitLifeTextField({
  required BuildContext context,
  required TextEditingController controller,
  required String labelText,
  IconData? prefixIcon,
}) {
  var primaryColor = Theme.of(context).colorScheme.primary;

  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: sizeDouble_2),
        borderRadius: BorderRadius.circular(sizeDouble_12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: greenColor, width: sizeDouble_2),
        borderRadius: BorderRadius.circular(sizeDouble_12),
      ),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: greyColor) : null,
    ),
  );
}

Widget fitLifePasswordTextField({
  required BuildContext context,
  required TextEditingController controller,
  required String labelText,
  IconData? prefixIcon,
}) {
  var primaryColor = Theme.of(context).colorScheme.primary;

  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: sizeDouble_2),
        borderRadius: BorderRadius.circular(sizeDouble_12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: orangeColor, width: sizeDouble_2),
        borderRadius: BorderRadius.circular(sizeDouble_12),
      ),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: greyColor) : null,
    ),
    obscureText: true,
  );
}

Widget fitLifeEmailTextField({
  required BuildContext context,
  required TextEditingController controller,
  required String labelText,
  IconData? prefixIcon,
}) {
  var primaryColor = Theme.of(context).colorScheme.primary;

  return TextField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: sizeDouble_2),
        borderRadius: BorderRadius.circular(sizeDouble_12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: greenColor, width: sizeDouble_2),
        borderRadius: BorderRadius.circular(sizeDouble_12),
      ),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: greyColor) : null,
    ),
  );
}

Widget fitLifeNumberTextField({
  required BuildContext context,
  required TextEditingController controller,
  required String labelText,
  IconData? prefixIcon,
}) {
  var primaryColor = Theme.of(context).colorScheme.primary;

  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: sizeDouble_2),
        borderRadius: BorderRadius.circular(sizeDouble_12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: greenColor, width: sizeDouble_2),
        borderRadius: BorderRadius.circular(sizeDouble_12),
      ),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: greyColor) : null,
    ),
  );
}