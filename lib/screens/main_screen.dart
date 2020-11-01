import 'package:flutter/material.dart';
import 'package:hostel_app/screens/add_hostel.dart';
import 'package:hostel_app/screens/show_hostel.dart';
import 'package:hostel_app/screens/view_hostel.dart';
import '../screens/auth_screen.dart';
class MainScreen extends StatelessWidget {
  static const routeName = '/main_screen';
  @override
  Widget build(BuildContext context) {
    final dSize=MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: dSize.height,
            width: dSize.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/hostel_back.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: dSize.height*0.15,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.30),
                borderRadius: BorderRadius.circular(41),
              ),
              width: dSize.width*0.40,
              height: dSize.width*0.40,
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: dSize.height*0.15,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(ViewHostel.routeName);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: dSize.height*0.075,
                    width: dSize.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          colors: [
                          Color(0xFFC82C12),
                          Color(0xFFC72C10),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight
                      ),
                    ),
                    child: Text("View Hostels", style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: dSize.height*0.025),),
                  ),
                ),
                SizedBox(
                  height: dSize.height*0.02,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(AuthScreen.routeName);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: dSize.height*0.075,
                    width: dSize.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFFE7262),
                    ),
                    child: Text("Add Hostel", style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: dSize.height*0.025),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
