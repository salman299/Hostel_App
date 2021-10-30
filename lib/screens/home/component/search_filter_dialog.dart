import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_app/constants.dart';
import 'package:hostel_app/module/providers.dart';
import 'package:hostel_app/size_config.dart';
import 'package:provider/provider.dart';

//import '../screen/setting_screen.dart';
class SearchFilterDialog extends StatefulWidget {
  @override
  _SearchFilterDialogState createState() => _SearchFilterDialogState();
}

class _SearchFilterDialogState extends State<SearchFilterDialog> {
  GlobalKey<FormState>? _formKey;

  List<String> genderType = ["All", "Boys", "Girls"];
  List<String> otherCategories = [
    "All",
    "Private",
    "Public",
    "Residential",
    "Commercial"
  ];
  List<String?> facilities=[];
  List<bool> genderChoice=[];
  List<bool> facilityChoice=[];
  double _value = 0;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    facilities =
        Provider.of<MyFacilities>(context, listen: false).getNames;
    facilities.insert(0, "All");
    facilityChoice=List.filled(facilities.length, false);
    genderChoice= List.filled(genderType.length, false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: false,
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      contentPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 6,
      backgroundColor: Colors.white,
      title: Align(
          alignment: Alignment.center,
          child: Text(
            "SEARCH FILTER",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: kTextPrimaryColor),
            textAlign: TextAlign.center,
          )),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: SizeConfig.screenHeight * 0.60,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "Distance Range",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kTextPrimaryColor),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: kPrimaryColor,
                    inactiveTrackColor: kPrimaryLightColor,
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 4.0,
                    thumbColor: kTextPrimaryColor,
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
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "Distance Range",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kTextPrimaryColor),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: kPrimaryColor,
                    inactiveTrackColor: kPrimaryLightColor,
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 4.0,
                    thumbColor: kTextPrimaryColor,
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
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kTextPrimaryColor),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: -8,
                  children: [
                    for (int i = 0; i < otherCategories.length; i++)
                      GestureDetector(
                        onTap: (){},
                        child: Chip(
                          label: Text(otherCategories[i]),
                          backgroundColor: Color(0xFFF0F1F5),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "Gender Category",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kTextPrimaryColor),
                ),
                Wrap(
                  spacing: 5,
                  runSpacing: -8,
                  children: [
                    for (int i = 0; i < genderType.length; i++)
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            genderChoice[i]=!genderChoice[i];
                          });
                        },
                        child: Chip(
                          label: Text(genderType[i]),
                          backgroundColor: genderChoice[i] ? Color(0xFF158FE4) : Color(0xFFF0F1F5),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "Facilities",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kTextPrimaryColor),
                ),
                Wrap(
                  //alignment: WrapAlignment.spaceBetween,
                  spacing: 5,
                  runSpacing: -8,
                  children: [
                    for (int i = 0; i < facilities.length; i++)
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            facilityChoice[i]=!facilityChoice[i];
                          });
                        },
                        child: Chip(
                          label: Text(facilities[i]!),
                          backgroundColor: facilityChoice[i] ? Color(0xFF158FE4) : Color(0xFFF0F1F5),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      //actionsOverflowButtonSpacing: double.infinity,
      actionsPadding: EdgeInsets.all(0),
      actions: [
        // GestureDetector(
        //   onTap: (){
        //     Navigator.of(context).pop();
        //   },
        //   child: Container(
        //     padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10),horizontal: getProportionateScreenWidth(20)),
        //     decoration: BoxDecoration(
        //         border: Border.all(
        //           width: 1,
        //           color: Color(0xFF191C3D),
        //         ),
        //         borderRadius:
        //         BorderRadius.circular(100)),
        //     child: Text(
        //       "Back",
        //       style: TextStyle(
        //         color: Color(0xFF191C3D),
        //       ),
        //     ),
        //   ),
        // ),
        OutlineButton(),
        GradientButton(),
        // GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Container(
        //     padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10),horizontal: getProportionateScreenWidth(20)),
        //     decoration: BoxDecoration(
        //         gradient: LinearGradient(
        //           colors: [
        //             Color(0xFF158FE4),
        //             Color(0xFF2457C2),
        //           ],
        //           begin: Alignment.centerLeft,
        //           end: Alignment.centerRight,
        //         ),
        //         borderRadius:
        //         BorderRadius.circular(100)),
        //     child: Text(
        //       "Save",
        //       style: TextStyle(
        //           color: Colors.white,
        //           shadows: [
        //             Shadow(
        //               color: Colors.black.withOpacity(0.16),
        //               offset: Offset(0, 3),
        //               blurRadius: 6,
        //             )
        //           ]),
        //     ),
        //   ),
        // ),
        //Spacer(),
      ],
    );
  }
}

Widget OutlineButton(){
  return TextButton(
    style: TextButton.styleFrom(
      textStyle: TextStyle(
        color: Color(0xFF191C3D),
      ),
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10),horizontal: getProportionateScreenWidth(20)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(
          width: 1,
          color:  Color(0xFF191C3D),
        )
      ),
    ),
    onPressed: (){},
    child: Text("Back"),
  );
}

Widget GradientButton(){
  return ElevatedButton(
    onPressed: () {
      print('Hi there');
    },
    style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100))
    ),
    child: Ink(
      child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
              borderRadius: BorderRadius.circular(100)),
          // constraints: BoxConstraints.expand(height: 30,width: 50),
          child: Text("Hello")
      ),
    ),
  );
}

Widget GradientButton1(){
  return TextButton(
    style: TextButton.styleFrom(
      textStyle: TextStyle(
        color: Color(0xFF191C3D),
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.16),
              offset: Offset(0, 3),
              blurRadius: 6,
            )
          ],
      ),
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10),horizontal: getProportionateScreenWidth(20)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            width: 1,
            color:  Color(0xFF191C3D),
          )
      ),
    ),
    onPressed: (){},
    child: Ink(
        decoration: BoxDecoration(
          gradient: kPrimaryGradientColor,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 100,
            maxHeight: 100,
          ),
            child: Text("Save")
        )
    ),
  );
}

// Widget titleBar(String title, Size dSize) {
//   return Container(
//     width: dSize.width,
//     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//     decoration: BoxDecoration(
//       color: Color(0xFFF6F6F6),
//       borderRadius: BorderRadius.circular(5),
//     ),
//     child: Text(
//       title,
//       style: TextStyle(fontSize: dSize.height * 0.023),
//     ),
//   );
// }
