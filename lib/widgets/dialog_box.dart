import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_app/module/providers.dart';
import 'package:provider/provider.dart';

//import '../screen/setting_screen.dart';
class DialogBox extends StatefulWidget {
  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  GlobalKey<FormState>? _formKey;
  List<String> types=["Boys", "Girls"];
  List<String> classes=["Private", "Public"];
  double _value=0;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String?> facilities=Provider.of<MyFacilities>(context,listen: false).getNames;
    bool? checkedValue = true;
    final dSize = MediaQuery.of(context).size;
    final _hintStyle = TextStyle(
      fontSize: dSize.height * 0.020,
      color: Color(0xFF191C3D),
    );
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      contentPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 6,
      backgroundColor: Colors.white,
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 10,
            children: <Widget>[
              //titleBar("Select Filters", dSize),
              Text("Distance",style: TextStyle(fontWeight: FontWeight.w500),),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.red[700],
                  inactiveTrackColor: Colors.red[100],
                  trackShape: RectangularSliderTrackShape(),
                  trackHeight: 4.0,
                  thumbColor: Colors.redAccent,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                ),
                child: Slider(
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              ),
              Text("Type",style: TextStyle(fontWeight: FontWeight.w500)),
              Container(
                width: dSize.width,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 6 / 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: types.length,
                  itemBuilder: (ctx, index) => CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(types[index]),
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ),
              Text("Class",style: TextStyle(fontWeight: FontWeight.w500)),
              Container(
                width: dSize.width,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 6 / 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: classes.length,
                  itemBuilder: (ctx, index) => CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(classes[index]),
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ),
              Text("Facilities",style: TextStyle(fontWeight: FontWeight.w500)),
              Container(
                width: dSize.width,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 6 / 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: facilities.length,
                  itemBuilder: (ctx, index) => CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(facilities[index]!),
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: dSize.height * 0.06,
                        width: dSize.width * 0.35,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Color(0xFFFE7262),
                            ),
                            borderRadius:
                                BorderRadius.circular(dSize.height * 0.03)),
                        child: Center(
                            child: Text(
                          "Back",
                          style: TextStyle(
                            fontSize: dSize.height * 0.020,
                            color: Color(0xFF191C3D),
                          ),
                        )),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: dSize.width * 0.30,
                      height: dSize.height * 0.06,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFA665F),
                              Color(0xFFE93354),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius:
                              BorderRadius.circular(dSize.height * 0.03)),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: dSize.height * 0.02,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.16),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget titleBar(String title, Size dSize) {
  return Container(
    width: dSize.width,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Color(0xFFF6F6F6),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      title,
      style: TextStyle(fontSize: dSize.height * 0.023),
    ),
  );
}
