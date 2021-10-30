
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/size_config.dart';

import '../../../constants.dart';
class Contact extends StatelessWidget {
  final whatsApp;
  final facebook;
  final phone;
  Contact({this.facebook,this.phone,this.whatsApp});
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Contact", style: TextStyle(fontWeight: FontWeight.w600,color: kTextPrimaryColor ,fontSize: getProportionateScreenWidth(18)),),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (whatsApp!=null && whatsApp.length!=0)
                  ContactTile(icon: "assets/whatsapp.png",text: whatsApp,color: Color(0xFF4CAF50),),
                if (phone!=null && phone.length!=0)
                  ContactTile(icon: "assets/telephone.png",text: phone,color: Color(0xFF2196F3),),
                if (facebook!=null && facebook.length!=0)
                  ContactTile(icon: "assets/facebook_circle.png",text: facebook,color: Color(0xFF3B5998),),

              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ContactTile extends StatelessWidget {
  final icon;
  final text;
  final color;
  ContactTile({this.icon,this.text,this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.27),
              offset: Offset(0,3),
            ),
          ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
          tileColor: Color(0xFFF0F1F5),
          leading: Tab(icon: Image.asset(icon, height: getProportionateScreenWidth(25),),),
          title: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: color,
          ),
        ),
      ),
    );
  }
}


