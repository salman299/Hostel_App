import 'package:flutter/material.dart';
import 'package:hostel_app/screens/home/component/app_bar.dart';
import 'package:hostel_app/screens/home/component/header_title.dart';
import 'package:hostel_app/screens/home/component/hostel_list.dart';
import 'package:hostel_app/screens/home/component/search_field.dart';
import 'package:hostel_app/screens/home/component/section_title.dart';
import 'package:hostel_app/screens/home/component/special_offers.dart';
import '../../../size_config.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Header(),
            SizedBox(height: getProportionateScreenHeight(20)),
            HeaderTitle(),
            SizedBox(height: getProportionateScreenHeight(20)),
            SearchField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenHeight(20)),
            HostelList(),
            //HostelTile(image: "assets/images/img1.jpg",name: "Bob's Hostel",location: "hyderabad, Pakistan",price: 500,press: (){}),
          ],
        ),
      ),
    );
  }
}
