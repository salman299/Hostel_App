import 'package:flutter/material.dart';

import '../../../size_config.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Function validator;
  final TextEditingController controller;
  const CustomTextField({Key? key,required this.controller,required this.label,required this.validator,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        labelText: label,
        hintStyle: TextStyle(
          fontSize: getProportionateScreenHeight(2.0),
        ),
      ),
      validator: (text) => validator(text),
    );
  }
}
