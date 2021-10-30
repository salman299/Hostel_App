import 'package:flutter/material.dart';
import 'package:hostel_app/custom_icons_icons.dart';
import 'package:hostel_app/module/providers.dart';
import 'package:hostel_app/screens/home/component/header_title.dart';
import 'package:hostel_app/screens/home/component/hostel_list.dart';
import 'package:hostel_app/screens/home/component/search_field.dart';
import 'package:hostel_app/screens/home/component/section_title.dart';
import 'package:hostel_app/screens/home/component/special_offers.dart';
import 'package:hostel_app/screens/hostel_details/component/categories.dart';
import 'package:hostel_app/screens/hostel_details/component/facilities.dart';
import 'package:hostel_app/screens/hostel_details/component/image_header.dart';
import 'package:hostel_app/screens/hostel_details/component/title.dart';
import '../../../size_config.dart';
import 'contact.dart';
import 'rooms.dart';
import 'package:hostel_app/module/hostel.dart';
import 'package:hostel_app/module/hostels.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final index;
  Body(this.index);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Hostel? hostel;
  late ScrollController _controller;
  bool _showAppBar = false;
  List<String?> categories = [];
  List<CommonFacility> hostelFacilities = [];

  _scrollListener() {
    if (_controller.offset >= MediaQuery.of(context).size.height * 0.45)
      setState(() {
        _showAppBar = true;
      });
    else {
      setState(() {
        _showAppBar = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    hostel = Provider.of<Hostels>(context, listen: false).items[widget.index];
    categories.add(hostel!.category);
    if (hostel!.category == "Both") {
      categories.add("Male");
      categories.add("Female");
    } else {
      categories.add(hostel!.genderCategory);
    }
    hostelFacilities = Provider.of<MyFacilities>(context).chooseListById(hostel!.facilities);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageHeader(hostel!.images),
            SizedBox(height: getProportionateScreenHeight(20)),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Color(0xFF343578).withOpacity(0.27),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  "HOSTEL",
                  style: TextStyle(
                      color: Color(0xFF343578), fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            TitleTile(
                title: hostel!.name, location: hostel!.address, press: () {}),
            SizedBox(height: getProportionateScreenHeight(15)),
            Category(title: "Category", chipList: categories),
            SizedBox(height: getProportionateScreenHeight(15)),
            Facility(title: "Hostel Facilities", chipList: hostelFacilities),
            SizedBox(height: getProportionateScreenHeight(15)),
            Rooms("Rooms Type", hostel!.roomCategories),
            SizedBox(height: getProportionateScreenHeight(15)),
            Contact(facebook: hostel!.facebookUrl,phone: hostel!.phone,whatsApp: hostel!.whatsApp,),
          ],
        ),
      ),
    );
  }
}
