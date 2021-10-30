import 'package:flutter/material.dart';
import './component/body.dart';
import '../../size_config.dart';
// import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
// import 'package:shop_app/enums.dart';
//
// import 'components/body.dart';

class HostelDetailScreen extends StatelessWidget {
  static String routeName = "/hostel_detail";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final index = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: Body(index),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
