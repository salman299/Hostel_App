import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hostel_app/module/hostel.dart';
import 'package:hostel_app/widgets/room_category_tile.dart';
import 'package:provider/provider.dart';
import '../module/providers.dart';
class HostelCategoryList extends StatefulWidget {
  @override
  _HostelCategoryListState createState() => _HostelCategoryListState();
}

class _HostelCategoryListState extends State<HostelCategoryList> {
  List<RoomCategoryTile> roomCategoryList=[];
  bool limit=true;
  bool isNotAdded=false;
  @override
  void initState() {
    // TODO: implement initState
    final rows=Provider.of<RoomCategories>(context,listen: false).items.length;
    //int rows=0;
    // if (roomsData.length!=0)
    //   rows=roomsData.length;
    roomCategoryList = List.generate(
        rows,
            (index) => new RoomCategoryTile(index, removeItem));
    super.initState();
  }
  void _addItem() {
    final len = roomCategoryList.length;
    if (len <= 15)
      setState(() {
        roomCategoryList.add(RoomCategoryTile(len,removeItem));
        Provider.of<RoomCategories>(context,listen: false).addRoom(RoomCategory(id: "$len"));
        //limit = true;
        //isNotAdded = false;
      });
    else {
      setState(() {
        limit = false;
      });
    }
  }
  void removeItem(index) {
    setState(() {
      roomCategoryList.removeAt(index);
    });
    Provider.of<RoomCategories>(context,listen: false).deleteRoom(index);
    print(roomCategoryList.length);
  }

  @override
  Widget build(BuildContext context) {
    return  Wrap(
      runSpacing: 10,
      children: <Widget>[
        ...roomCategoryList,
        ListTile(
            onTap: limit ? _addItem : null,
            title: !limit
                ? Text("Limit Exceed",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold))
                : Icon(
              Icons.add,
            ))
      ],
    );
  }
}
