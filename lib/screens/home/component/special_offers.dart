import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Trending Hostels",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/img1.jpg",
                category: "Smartphone",
                numOfBrands: 18,
                press: () {},
              ),
              SpecialOfferCard(
                image: "assets/img2.jpg",
                category: "Fashion",
                numOfBrands: 24,
                press: () {},
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: getProportionateScreenWidth(300),
            height: getProportionateScreenHeight(155),
            decoration: BoxDecoration(
              color: Color(0xFFF4F5F7),
              image: DecorationImage(
                image: AssetImage(
                  image,
                ),
                fit: BoxFit.cover,
              ),
            ),

            child: Stack(
              children: [
                // Image.asset(
                //   image,
                //   fit: BoxFit.fill,
                // ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF000000).withOpacity(0.54),
                        Color(0xFF2D2B2B).withOpacity(0.05),
                      ],
                    ),
                  ),
               ),
                Positioned(
                  bottom: getProportionateScreenWidth(10.0),
                  left: getProportionateScreenWidth(15.0),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(10.0),
                  right: getProportionateScreenWidth(15.0),
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.50),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("Boys",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,)),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
