// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:hostel_app/module/hostel.dart';
// import 'package:hostel_app/module/hostels.dart';
// import 'package:hostel_app/screens/auth_screen.dart';
// import 'package:hostel_app/screens/hostel_detail.dart';
// import 'package:hostel_app/screens/main_screen.dart';
// import 'package:hostel_app/screens/mapTry.dart';
// import 'package:hostel_app/screens/map_picker.dart';
// import 'package:hostel_app/screens/search_facility.dart';
// import 'package:hostel_app/screens/splashScreen1.dart';
// import './screens/add_hostel.dart';
// import 'package:hostel_app/screens/show_hostel.dart';
// import 'package:hostel_app/screens/view_hostel.dart';
// import 'package:provider/provider.dart';
// import './module/auth.dart';
// import './module/providers.dart';
// import './screens/my_map.dart';
// //import 'package:firebase/firebase.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//           ChangeNotifierProvider.value(
//           value: Auth(),
//           ),
//           ChangeNotifierProvider.value(
//             value: MyFacilities(),
//           ),
//           ChangeNotifierProvider.value(
//             value: RoomCategories(),
//           ),
//           ChangeNotifierProvider.value(
//             value: Hostels(),
//           ),
//       ],
//       child: MaterialApp(
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             primaryColor: Color(0xFFFE7262),
//             iconTheme:  IconThemeData(color: Color(0xFFC42B0B)),
//             backgroundColor: Colors.white,
//             accentColor: Color(0xFFFE7262),
//             fontFamily: 'Poppins',
//             inputDecorationTheme: InputDecorationTheme(
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5),
//                 borderSide: BorderSide(
//                   width: 0.5,
//                   color: Color(0xFF252A59).withOpacity(0.30),
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5),
//                 borderSide: BorderSide(
//                   width: 1,
//                   color: Color(0xFFFE7262),
//                 ),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5),
//                 borderSide: BorderSide(
//                   width: 1,
//                   color: Color(0xFFFE7262),
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5),
//                 borderSide: BorderSide(
//                   width: 1,
//                   color: Colors.redAccent,
//                 ),
//               ),
//             ),
//             textTheme: TextTheme(
//               bodyText1: TextStyle(),
//               bodyText2: TextStyle(),
//             ).apply(
//               bodyColor: Color(0xFF191C3D),
//               displayColor: Color(0xFF191C3D),
//             ),
//           ),
//           home: MainScreen(),
// //    Consumer<Auth>(
// //            builder: (context,data,ch)=>data.userId!=null ? ViewHostel() : SplashScreen(),
// //          ),
//           routes: {
//             SearchFacility.routeName: (ctx)=>SearchFacility(),
//             AuthScreen.routeName: (ctx)=>AuthScreen(),
//             ShowHostels.routeName: (ctx)=>ShowHostels(),
//             HostelDetail.routeName: (ctx)=>HostelDetail(),
//             AddHostel.routeName: (ctx)=>AddHostel(),
//             MainScreen.routeName: (ctx)=>MainScreen(),
//             ViewHostel.routeName: (ctx)=>ViewHostel(),
//            // MyMap.routeName: (ctx)=>MyMap(),
//           },
//         ),
//     );
//   }
// }
