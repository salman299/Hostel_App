import 'package:flutter/material.dart';
import 'package:hostel_app/screens/hostel_form/components/drop_down.dart';
import 'package:hostel_app/screens/hostel_form/components/text_field.dart';
class Page1 extends StatelessWidget {
  final TextEditingController name, phone, email, whatsapp, facebookUrl, gender, hostelType;
  const Page1(
      {
        Key? key,
        required this.name,
        required this.phone,
        required this.email,
        required this.whatsapp,
        required this.facebookUrl,
        required this.gender,
        required this.hostelType}
        ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        runSpacing: 10,
        children: [
          CustomTextField(
            label: "Name",
            controller: name,
            validator: (text) {
              if (text == '')
                return null;
              if (text!.length < 3)
                return "Name is very short";
              else if (text == null) return "Field is required";
              return null;
            },
          ),
          CustomTextField(
            label: "phone",
            controller: phone,
            validator: (text) {
              if (text!.length < 9 || int.tryParse(text) == null)
                return "Invalid Phone";
              else if (text == null) return "Field is required";
              return null;
            },
          ),
          CustomTextField(
            label: "whatsapp",
            controller: whatsapp,
            validator: (text) {
              if (text!.length < 9 || int.tryParse(text) == null)
                return "Invalid Phone";
              else if (text == null) return "Field is required";
              return null;
            },
          ),
          CustomTextField(
            label: "facebookUrl",
            controller: facebookUrl,
            validator: (text) {
              if (text != "" &&
                  !RegExp(r"(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-]*)?")
                      .hasMatch(text!)) {
                return 'This is not Facebook URL';
              }
              return null;
            },
          ),
          CustomDropDown(
            valueController: gender,
            choices: ['Male', 'Female', 'Both'],
          ),
          CustomDropDown(
            valueController: hostelType,
            choices: ['Public', 'Private'],
          ),
        ],
      ),
    );
  }
}
