import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/screens/home/component/app_bar.dart';
import 'package:hostel_app/screens/home/component/header_title.dart';
import 'package:hostel_app/screens/home/component/hostel_list.dart';
import 'package:hostel_app/screens/home/component/search_field.dart';
import 'package:hostel_app/screens/home/component/section_title.dart';
import 'package:hostel_app/screens/home/component/special_offers.dart';
import 'package:shimmer/shimmer.dart';
import '../../../size_config.dart';
class ShimmerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          Header(),
          SizedBox(height: getProportionateScreenHeight(20)),
          HeaderTitle(),
          SizedBox(height: getProportionateScreenHeight(20)),
          SearchField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SectionTitle(
              title: "Trending Hostels",
              press: () {},
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
          Container(
            margin: EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(15) ),
            width: double.infinity,
            height: getProportionateScreenHeight(155),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFFF4F5F7),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: getProportionateScreenWidth(150),
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),

                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: getProportionateScreenWidth(100),
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),

                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SectionTitle(
              title: "Near You",
              press: () {},
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          for (int i=0;i<3;i++)
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF4F5F7),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),

                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: getProportionateScreenWidth(100),
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //HostelTile(image: "assets/images/img1.jpg",name: "Bob's Hostel",location: "hyderabad, Pakistan",price: 500,press: (){}),
        ],
      ),
    );
  }
}
