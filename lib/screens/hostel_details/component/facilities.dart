
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/constants.dart';
import 'package:hostel_app/module/hostel.dart';
import 'package:hostel_app/size_config.dart';

import '../../../custom_icons_icons.dart';

class Facility extends StatelessWidget {
  final title;
  final List<CommonFacility>? chipList;
  Facility({this.title,this.chipList});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(15),),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w600,color: kTextPrimaryColor ,fontSize: getProportionateScreenWidth(18)),),
          // SizedBox(height: getProportionateScreenHeight(10)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Wrap(
              spacing: 8,
              runSpacing: -8,
              children: [
                for (int i=0; i<chipList!.length;i++)
                  Chip(avatar: Icon(chipList![i].icon,color: kTextColor,size: getProportionateScreenWidth(15)),label: Text(chipList![i].name!),backgroundColor: Color(0xFFF0F1F5),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



