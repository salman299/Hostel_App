import 'package:flutter/material.dart';
import 'package:hostel_app/module/hostel.dart';
import 'package:hostel_app/module/providers.dart';
import 'package:hostel_app/screens/hostel_details/component/contact.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
class Rooms extends StatelessWidget {
  final title;
  final List<RoomCategory>? rooms;
  Rooms(this.title,this.rooms);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w600,color: kTextPrimaryColor ,fontSize: getProportionateScreenWidth(18)),),
          SizedBox(height: getProportionateScreenHeight(10)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xFFF0F1F5),
                borderRadius: BorderRadius.circular(10),
                // boxShadow: [
                //   BoxShadow(
                //     offset: Offset(0, 3),
                //     blurRadius: 6,
                //     color: Colors.black.withOpacity(0.16),
                //   )
                // ]
            ),
            child: Table(
              defaultVerticalAlignment:
              TableCellVerticalAlignment.middle,
              textBaseline: TextBaseline.alphabetic,
              children: [
                TableRow(
                  children: [
                    Text('Beds',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w600)),
                    Text('Bath',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w600)),
                    Text('AC',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w600)),
                    Text('Fridge',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w600)),
                    Text('Rent',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                for (int i = 0; i < rooms!.length; i++)
                  TableRow(
                    children: [
                      Text(rooms![i].bed,style: TextStyle(fontSize: getProportionateScreenWidth(14))),
                      Text(rooms![i].isBath,style: TextStyle(fontSize: getProportionateScreenWidth(14))),
                      Text(rooms![i].isAC,style: TextStyle(fontSize: getProportionateScreenWidth(14))),
                      Text(rooms![i].isFridge,style: TextStyle(fontSize: getProportionateScreenWidth(14))),
                      Text(
                        rooms![i].rent.toString(),
                        style: TextStyle(fontSize: getProportionateScreenWidth(14),color: kTextPrimaryColor),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
