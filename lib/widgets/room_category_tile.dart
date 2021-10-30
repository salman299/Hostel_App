import 'package:flutter/material.dart';
import 'package:hostel_app/module/hostel.dart';
import 'package:provider/provider.dart';
import '../module/providers.dart';

class RoomCategoryTile extends StatefulWidget {
  final index;
  final removeItem;

  RoomCategoryTile(this.index, this.removeItem);

  @override
  _RoomCategoryTileState createState() => _RoomCategoryTileState();
}

class _RoomCategoryTileState extends State<RoomCategoryTile> {
  bool isExpended = false;
  String? bed;
  String? bath;
  String? ac;
  String? fridge;
  String? description;
  String? rent;

  @override
  Widget build(BuildContext context) {
    final creditList = ['Yes', 'No'];
    final bedList = ['1', '2', '3', '4', '5', '6'];
    return Consumer<RoomCategories>(
      builder: (context,data,ch)=> Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              offset: Offset(0, 3),
              blurRadius: 6,
            )
          ],
        ),
        child: Wrap(
          runSpacing: 10,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
//                width: dSize.width*0.50-22.5,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF5F5F5),
                    ),
                    child: DropdownButtonFormField<String>(
                      //style: _hintStyle,
                      elevation: 0,
                      value: data.items[widget.index].bed ?? "1",
                      //isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      decoration: InputDecoration.collapsed(
                        enabled: false,
                        hintText: null,
                      ),
                      onChanged: (val) {
                        bed = val;
                        data.items[widget.index].bed=val;
                        //Provider.of<RoomCategories>(context,listen: false).items[widget.index].bed=val;
                      },
                      items:
                          bedList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      // onSaved: (val)=>creditType=val,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
//                width: dSize.width*0.50-22.5,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF5F5F5),
                    ),
                    child: DropdownButtonFormField<String>(
                      //style: _hintStyle,
                      elevation: 0,
                      value: data.items[widget.index].isBath ?? "Yes",
                      //isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      decoration: InputDecoration.collapsed(
                        enabled: false,
                        hintText: null,
                      ),
                      onChanged: (val) {
                        bath = val;
                        data.items[widget.index].isBath=val;
                        // Provider.of<RoomCategories>(context, listen: false)
                        //     .items[widget.index]
                        //     .isBath = val;
                      },
                      items: creditList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      // onSaved: (val)=>creditType=val,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
//                width: dSize.width*0.50-22.5,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF5F5F5),
                    ),
                    child: DropdownButtonFormField<String>(
                      //style: _hintStyle,
                      elevation: 0,
                      value: data.items[widget.index].isAC ?? "Yes",
                      //isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      decoration: InputDecoration.collapsed(
                        enabled: false,
                        hintText: null,
                      ),
                      onChanged: (val) {
                        ac = val;
                        data.items[widget.index].isAC=val;
                        //Provider.of<RoomCategories>(context, listen: false).items[widget.index].isAC = val;
                      },
                      items: creditList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      // onSaved: (val)=>creditType=val,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
//                width: dSize.width*0.50-22.5,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF5F5F5),
                    ),
                    child: DropdownButtonFormField<String>(
                      elevation: 0,
                      value: data.items[widget.index].isFridge ?? "Yes",
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      decoration: InputDecoration.collapsed(
                        enabled: false,
                        hintText: null,
                      ),
                      onChanged: (val) {
                        fridge = val;
                        data.items[widget.index].isFridge=val;
                        //Provider.of<RoomCategories>(context, listen: false).items[widget.index].isFridge = val;
                      },
                      items: creditList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      // onSaved: (val)=>creditType=val,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    //style: _hintStyle,
                    initialValue:  data.items[widget.index].rent.toString(),
                    cursorColor: Theme.of(context).primaryColor,
                    onChanged: (val){
                      rent = val;
                      data.items[widget.index].rent=double.parse(val);
                      //Provider.of<RoomCategories>(context,listen: false).items[widget.index].rent=double.parse(val);
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      labelText: "Rent",
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => widget.removeItem(widget.index),
                        ),
                        IconButton(
                          icon: Icon(isExpended
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down),
                          onPressed: () {
                            setState(() {
                              isExpended = !isExpended;
                            });
                          },
                        ),
                      ],
                    ))
              ],
            ),
            if (isExpended)
              TextFormField(
                maxLines: 4,
                //style: _hintStyle,
                cursorColor: Theme.of(context).primaryColor,
                initialValue: data.items[widget.index].description ?? null,
                onChanged: (val){
                  description=val;
                  data.items[widget.index].description=val;
                  //Provider.of<RoomCategories>(context,listen: false).items[widget.index].description=val;
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  labelText: "Description",
                ),
              ),
          ],
        ),
      ),
    );
  }
}
