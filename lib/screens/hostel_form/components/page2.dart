import 'package:flutter/material.dart';
import 'package:hostel_app/screens/hostel_form/components/map_card.dart';
import 'package:hostel_app/screens/hostel_form/components/text_field.dart';
class Page2 extends StatelessWidget {
  final TextEditingController county, city, latitute, longitute;
  const Page2({Key? key, required this.county, required this.city,required this.latitute,required this.longitute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      children: [
        Container(
          height: 350,
            child: MapCard(latitute: latitute, longitute: longitute,)
        ),
        CustomTextField(controller: county, label: "Country", validator: (){}),
        CustomTextField(controller: city, label: "City", validator: (){}),
      ],
    );
  }
}
