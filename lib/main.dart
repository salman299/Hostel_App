import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/screens/add_hostel.dart';
import 'package:hostel_app/screens/auth_screen.dart';
import 'package:hostel_app/screens/geo_flutter_screen.dart';
import 'package:hostel_app/screens/home/home_screen.dart';
import 'package:hostel_app/screens/hostel_details/hostel_detail_screen.dart';
import 'package:hostel_app/screens/hostel_form/hostel_form_screen.dart';
import 'package:hostel_app/screens/main_screen.dart';
import 'package:hostel_app/screens/my_map.dart';
import 'package:hostel_app/screens/show_hostel.dart';
import 'package:hostel_app/screens/splashScreen1.dart';
import 'package:hostel_app/screens/view_hostel.dart';
import 'package:provider/provider.dart';
import 'module/auth.dart';
import 'module/hostels.dart';
import 'module/providers.dart';
import 'routes.dart';
import './theme.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: MyFacilities(),
        ),
        ChangeNotifierProvider.value(
          value: RoomCategories(),
        ),
        ChangeNotifierProvider.value(
          value: Hostels(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        home: HomeScreen(),
        // We use routeName so that we dont need to remember the name
        //initialRoute: HomeScreen.routeName,
        routes: routes,
      ),
    );
  }
}