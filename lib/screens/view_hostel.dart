
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/custom_icons_icons.dart';
import 'package:hostel_app/screens/add_screen.dart';
import 'package:hostel_app/screens/show_hostel.dart';
import 'package:hostel_app/widgets/hostel_tile.dart';
import '../widgets/hostel_tile.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class ViewHostel extends StatefulWidget {
  static const routeName = '/view_hostels';
  @override
  _ViewHostelState createState() => _ViewHostelState();
}

class _ViewHostelState extends State<ViewHostel> {
  @override
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            ShowHostels(),
            Container(color: Colors.red,),
            AddHostelScreen(),
            Container(color: Colors.blue,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        showElevation: true,
        backgroundColor: Colors.white,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController!.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Color(0xFF9F9F9F),
              title: Text('Home'),
              icon: Icon(CustomIcons.home)
          ),
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Color(0xFF9F9F9F),
              title: Text('Liked'),
              icon: Icon(CustomIcons.heart1)
          ),
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Color(0xFF9F9F9F),
              title: Text('User'),
              icon: Icon(CustomIcons.user)
          ),
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Color(0xFF9F9F9F),
              title: Text('Setting'),
              icon: Icon(CustomIcons.settings)
          ),
        ],
      ),
    );
  }
}
