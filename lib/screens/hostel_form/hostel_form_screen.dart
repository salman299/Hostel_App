import 'package:flutter/material.dart';
import '../../size_config.dart';
import './components/body.dart';

class HostelFormScreen extends StatelessWidget {
  static String routeName = "/hostel_form_screen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(),
      body: Body(),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
