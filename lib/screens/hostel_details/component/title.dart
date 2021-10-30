import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class TitleTile extends StatelessWidget {
  const TitleTile({
    Key? key,
    required this.title,
    required this.location,
    required this.press,
  }) : super(key: key);

  final String? title;
  final String? location;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      color: kTextPrimaryColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(location!, style: TextStyle(color: kTextPrimaryColor,fontSize: getProportionateScreenWidth(12)),)
                )
              ]),
          GestureDetector(
            onTap: press,
            child: Text(
              "On Map",
              style: TextStyle(color: Colors.pinkAccent,),
            ),
          ),
        ],
      ),
    );
  }
}
