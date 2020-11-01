import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/screens/hostel_detail.dart';
import 'package:hostel_app/screens/view_hostel.dart';
import '../custom_icons_icons.dart';
import '../module/hostel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HostelTile extends StatefulWidget {
  Hostel hostel;
  int index;
  HostelTile(this.hostel,this.index);

  @override
  _HostelTileState createState() => _HostelTileState();
}

class _HostelTileState extends State<HostelTile> {
  double minRent=double.infinity;
  @override
  void initState() {
    widget.hostel.roomCategories.forEach((element) {
      if(element.rent!=null && element.rent<minRent)
        minRent=element.rent;
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (widget.hostel.images.length!=0)
      print(widget.hostel.images[0]);
    final dSize=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(HostelDetail.routeName,arguments: widget.index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(21),
                    child: Container(
                      width: dSize.width*0.25,
                      height: dSize.width*0.25,
                      color: Colors.white,
                      child: widget.hostel.images.length==0? Image.asset("assets/hotel.png"):
                      CachedNetworkImage(
                                  imageUrl: widget.hostel.images[0],
                                  placeholderFadeInDuration: Duration(seconds: 2),
                                  placeholder:(context,url)=>Opacity(child: Image.asset("assets/hotel-1.png"), opacity: 0.5,),
                                  fit: BoxFit.fill,
                                ),
                    ),
                  ),
                Container(
                  width: dSize.width*0.75-50,
                  height: dSize.width*0.25,
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(widget.hostel.name,style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black,fontSize: dSize.height*0.022),),
                          Icon(CustomIcons.phone,size: dSize.height*0.025,)
                        ],
                      ),
                      Text(widget.hostel.address,style: TextStyle(fontWeight: FontWeight.w300,color: Color(0xFF7B7E84),fontSize: dSize.height*0.018),),
                      Text("Start From: $minRent",style: TextStyle(fontWeight: FontWeight.w300,color: Color(0xFF7B7E84),fontSize: dSize.height*0.018),),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          //mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(flex: 1,child: bottomIcon(CustomIcons.slumber, "No")),
                            Expanded(flex: 1,child: bottomIcon(CustomIcons.food, "Yes")),
                            Expanded(flex: 1,child: bottomIcon(CustomIcons.shower, "No"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
          child: Icon(icon,color: Colors.black,)
      ),
      Text(text,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),)
    ],
  );
}