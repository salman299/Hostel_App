import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final TextEditingController valueController;
  final List<String> choices;

  const CustomDropDown(
      {Key? key, required this.valueController, required this.choices})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(0xFF252A59).withOpacity(0.30),
          width: 0.5,
        ),
      ),
      child: DropdownButtonFormField<String>(
        //style: _hintStyle,
        elevation: 0,
        value: valueController.text =="" ? choices[0] : valueController.text,
        //isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down,
        ),
        decoration: InputDecoration.collapsed(
          enabled: false,
          hintText: null,
        ),
        onChanged: (val) {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        items: choices.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        // onSaved: (val)=>creditType=val,
      ),
    );
  }
}
