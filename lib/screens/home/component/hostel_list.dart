import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/module/hostel.dart';

import 'package:hostel_app/module/hostels.dart';
import 'package:hostel_app/screens/hostel_details/hostel_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'section_title.dart';
class HostelList extends StatelessWidget {
  const HostelList({
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
            title: "Near You",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Consumer<Hostels>(
          builder: (context,hostels,ch){
            List<Hostel> myItem=hostels.items;
            return Column(
            children: [
              for (int i=0;i<myItem.length;i++)
                HostelTile(image: myItem[i].images!.length==0? null: myItem[i].images![0],name: myItem[i].name,location: myItem[i].address,price: 500,press: (){
                  Navigator.of(context).pushNamed(HostelDetailScreen.routeName,arguments: i);
                }),
            ],
          );
          }
        ),
      ],
    );
  }
}

// class HostelCard extends StatelessWidget {
//   const HostelCard({
//     Key key,
//     @required this.hostel,
//   }) : super(key: key);
//
//   final Hostel hostel;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 88,
//           child: AspectRatio(
//             aspectRatio: 0.88,
//             child: Container(
//               padding: EdgeInsets.all(getProportionateScreenWidth(10)),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF5F6F9),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Image.asset(hostel.images[0]),
//             ),
//           ),
//         ),
//         SizedBox(width: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               hostel.name,
//               style: TextStyle(color: Colors.black, fontSize: 16),
//               maxLines: 2,
//             ),
//             SizedBox(height: 10),
//             Text.rich(
//               TextSpan(
//                 text: "\$${hostel.address}",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600, color: kPrimaryColor),
//                 children: [
//                   TextSpan(
//                       text: " x${hostel.phone}",
//                       style: Theme.of(context).textTheme.bodyText1),
//                 ],
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
// }


class HostelTile extends StatelessWidget {
  const HostelTile({
    Key? key,
    required this.name,
    required this.location,
    required this.image,
    required this.price,
    required this.press,
  }) : super(key: key);
  final String? name,location,image;
  final double price;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF4F5F7),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
       child: Row(
          children: <Widget>[
            SizedBox(
              height: 100,
              width: 100,
              child: AspectRatio(
                aspectRatio: 0.100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: image==null ? Image.asset("assets/hotel.png"): CachedNetworkImage(
                      imageUrl: image!,
                      placeholderFadeInDuration: Duration(seconds: 2),
                      placeholder:(context,url)=>Opacity(child: Image.asset("assets/hotel-1.png"), opacity: 0.5,),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(name!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: getProportionateScreenWidth(18))),
                      Icon(Icons.phone)
                    ],
                  ),
                  Text(location!,style: TextStyle(fontWeight: FontWeight.w400,color: kTextLightColor,fontSize: getProportionateScreenWidth(12))),
                  Text("Start From: $price",style: TextStyle(fontWeight: FontWeight.w400,color: kTextLightColor,fontSize: getProportionateScreenWidth(12))),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      //mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(flex: 1,child: bottomIcon(Icons.filter, "No")),
                        Flexible(flex: 1,child: bottomIcon(Icons.grade, "Yes")),
                        Flexible(flex: 1,child: bottomIcon(Icons.gradient, "No"))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget bottomIcon(icon,text){
  return Row(
    children: <Widget>[
      Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(icon,color: kTextLightColor,)
      ),
      Text(text,style: TextStyle(color: kTextLightColor,fontWeight: FontWeight.w700),)
    ],
  );
}