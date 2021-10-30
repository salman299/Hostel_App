import 'package:flutter/material.dart';
import 'package:hostel_app/module/hostels.dart';
import 'package:hostel_app/screens/home/component/shimmer.dart';
import 'package:provider/provider.dart';
import './component/body.dart';
import '../../size_config.dart';
// import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
// import 'package:shop_app/enums.dart';
//
// import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<Hostels>(context,listen: false).fetchAllHostel(),
        builder: (ctx,snap)=>snap.connectionState==ConnectionState.waiting? ShimmerBody():Body(),
      ),
    );
  }
}
