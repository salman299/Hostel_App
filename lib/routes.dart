import 'package:flutter/widgets.dart';
import 'package:hostel_app/screens/hostel_detail.dart';
import 'package:hostel_app/screens/hostel_details/hostel_detail_screen.dart';
import 'package:hostel_app/screens/main_screen.dart';
import 'package:hostel_app/screens/show_hostel.dart';
import 'package:hostel_app/screens/view_hostel.dart';
import './screens/home/home_screen.dart';
import './screens/add_hostel.dart';
// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  ShowHostels.routeName: (context) => ShowHostels(),
  HomeScreen.routeName: (context)=>HomeScreen(),
  HostelDetail.routeName: (context)=> HostelDetailScreen(),
  ViewHostel.routeName: (context)=>ViewHostel(),
  MainScreen.routeName: (context)=>MainScreen(),
  AddHostel.routeName : (context)=> AddHostel(),
};
