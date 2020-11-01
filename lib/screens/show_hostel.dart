import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/module/hostels.dart';
import 'package:provider/provider.dart';
import '../custom_icons_icons.dart';
import '../widgets/hostel_tile.dart';
import '../widgets/dialog_box.dart';
class ShowHostels extends StatelessWidget {
  static const routeName = '/show_hostel';
  @override
  Widget build(BuildContext context) {

    final dSize=MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: dSize.height,
          width: dSize.width,
        ),
        Positioned(
          width: dSize.width,
          height: dSize.height*0.37,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/upHostel.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).padding.top+10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                      ),
                      padding: EdgeInsets.all(5),
                      height: dSize.height*0.045,
                      width: dSize.height*0.045,
                      child: Icon(CustomIcons.search,color: Colors.white,size: dSize.height*0.025,),
                    ),
                    Icon(CustomIcons.logout1),
                  ],
                ),
                SizedBox(
                  height: dSize.height*0.02,
                ),
                Row(
                  children: <Widget>[
                    Text("Hostels in ",style: TextStyle(color: Colors.white,fontSize: dSize.height*0.035,fontWeight: FontWeight.w300),),
                    Text("Karachi",style: TextStyle(color: Colors.white,fontSize: dSize.height*0.035,fontWeight: FontWeight.w700)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                      margin: EdgeInsets.all(7.5),
                      child: Text("Boys",style: TextStyle(color: Color(0xFF7B7E84),fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                      margin: EdgeInsets.all(7.5),
                      child: Text("Bed: 2",style: TextStyle(color: Color(0xFF7B7E84),fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                      margin: EdgeInsets.all(7.5),
                      child: Text("Bath: Y",style: TextStyle(color: Color(0xFF7B7E84),fontWeight: FontWeight.w500),),
                    ),
                    Padding(
                        padding: EdgeInsets.all(7.5),
                        child: IconButton(icon: Icon(CustomIcons.filter,color: Colors.white,),onPressed: (){
                          showDialog(context: context,builder: (ctx) =>DialogBox());
                        },)
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          height: dSize.height*0.63+51-60,
          bottom: 0,
          width: dSize.width,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft:Radius.circular(51),topRight: Radius.circular(51)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(51),topRight: Radius.circular(51)),
              ),
              child: FutureBuilder(
                future: Provider.of<Hostels>(context,listen: false).fetchAllHostel(),
                builder: (context,snap)=>snap.connectionState==ConnectionState.waiting ? Center(child: CircularProgressIndicator()): Consumer<Hostels>(
                  builder: (ctx,data,ch)=> ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    itemCount: data.items.length,
                    itemBuilder: (ctx,index)=>HostelTile(data.items[index],index),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
