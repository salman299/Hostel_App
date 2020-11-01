import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:hostel_app/custom_icons_icons.dart';
import 'package:hostel_app/module/hostels.dart';
import 'package:hostel_app/module/providers.dart';
import 'package:provider/provider.dart';
import '../module/hostel.dart';
import '../screens/add_hostel.dart';

class HostelDetail extends StatefulWidget {
  static const routeName = '/hostel_detail';

  @override
  _HostelDetailState createState() => _HostelDetailState();
}

class _HostelDetailState extends State<HostelDetail> {
  int currentIndexPage = 0;
  ScrollController _controller;
  bool _showAppBar = false;
  static const List<String> fileNames = [
    'assets/demo.jpg',
    'assets/demo.jpg',
    'assets/demo.jpg',
    'assets/demo.jpg',
    //'assets/eat_sydney_sm.jpg',
  ];

  _scrollListener() {
    if (_controller.offset >= MediaQuery.of(context).size.height * 0.45)
      setState(() {
        _showAppBar = true;
      });
    else {
      setState(() {
        _showAppBar = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context).settings.arguments;
    final Hostel hostel =
        Provider.of<Hostels>(context, listen: false).items[index];
    final dSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: !_showAppBar
          ? null
          : AppBar(
              title: Text(hostel.name),
              elevation: 5,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              actions: <Widget>[
                IconButton(icon: Icon(CustomIcons.heart)),
              ],
            ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: <Widget>[
            Container(
              height: dSize.height * 0.45,
              width: dSize.width,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  if (hostel.images.length == 0)
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: dSize.height * 0.45,
                      width: dSize.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF707070),
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 10.0,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(52),
                          bottomLeft: Radius.circular(52),
                        ),
                        image: DecorationImage(
                            image: ExactAssetImage("assets/hotel.png"),
                            fit: BoxFit.cover),
                      ),
                      // child: Image.asset(fileNames[index],height: dSize.height * 0.55,fit: BoxFit.cover,width: dSize.width+50,),
                    ),
                  if (hostel.images.length != 0)
                    Container(
                      height: dSize.height * 0.45,
                      width: dSize.width,
                      child: PageView.builder(
                        itemCount: hostel.images.length,
                        onPageChanged: (val) {
                          setState(() {
                            currentIndexPage = val;
                          });
                        },
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(52),
                              bottomLeft: Radius.circular(52),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: dSize.height * 0.45,
                              width: dSize.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF707070),
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                               child: CachedNetworkImage(
                                 imageUrl: hostel.images[index],
                                 placeholderFadeInDuration: Duration(seconds: 2),
                                 placeholder:(context,url)=>Opacity(child: Image.asset("assets/hotel-1.png"), opacity: 0.5,),
                                 fit: BoxFit.cover,
                               ),
                            ),
                          );
                        },
//                      aspectRatio: 1,
//                      child: Carousel(itemBuilder: widgetBuilder),
                      ),
                    ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 5,
                    right: 15,
                    left: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        Icon(
                          CustomIcons.heart,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(hostel.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: dSize.height * 0.027)),
                        Text("370000",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: dSize.height * 0.025)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.50),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(hostel.genderCategory,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: dSize.height * 0.023)),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    child: hostel.images.length == 0
                        ? Container()
                        : Container(
                            alignment: Alignment.center,
                            width: dSize.width,
                            child: DotsIndicator(
                              dotsCount: hostel.images.length,
                              position: currentIndexPage.roundToDouble(),
                              decorator: DotsDecorator(
                                spacing: EdgeInsets.all(3),
                                color: Color(0xFFFF9D00),
                                activeColor: Colors.white,
                                size: const Size.square(12.0),
                                activeSize: const Size(12.0, 12.0),
//                          activeShape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(5.0)),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: dSize.width - 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: dSize.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        hostel.name,
                        style: TextStyle(
                            fontSize: dSize.height * 0.03,
                            color: Color(0xFFC42B0B),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(hostel.category)
                    ],
                  ),
                  Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: dSize.height * 0.025,
                        color: Color(0xFFC42B0B),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "    The Categories are based on individual person",
                    style: TextStyle(
                        fontSize: dSize.height * 0.018,
                        color: Color(0xFFC42B0B)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.16),
                          )
                        ]),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        TableRow(
                          children: [
                            Text('Beds',
                                style: TextStyle(
                                    fontSize: dSize.height * 0.020,
                                    fontWeight: FontWeight.w600)),
                            Text('Bath',
                                style: TextStyle(
                                    fontSize: dSize.height * 0.020,
                                    fontWeight: FontWeight.w600)),
                            Text('AC',
                                style: TextStyle(
                                    fontSize: dSize.height * 0.020,
                                    fontWeight: FontWeight.w600)),
                            Text('Fridge',
                                style: TextStyle(
                                    fontSize: dSize.height * 0.020,
                                    fontWeight: FontWeight.w600)),
                            Text('Rent',
                                style: TextStyle(
                                    fontSize: dSize.height * 0.020,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        for (int i = 0; i < hostel.roomCategories.length; i++)
                          TableRow(
                            children: [
                              Text(hostel.roomCategories[i].bed),
                              Text(hostel.roomCategories[i].isBath),
                              Text(hostel.roomCategories[i].isAC),
                              Text(hostel.roomCategories[i].isFridge),
                              Text(
                                hostel.roomCategories[i].rent.toString(),
                                style: TextStyle(color: Color(0xFFC42B0B)),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Text(
                    "Common Facilities",
                    style: TextStyle(
                        fontSize: dSize.height * 0.025,
                        color: Color(0xFFC42B0B),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "    Available for all students",
                    style: TextStyle(
                        fontSize: dSize.height * 0.018,
                        color: Color(0xFFC42B0B)),
                  ),
                  Container(
                    //height: dSize.height*0.50,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.16),
                          )
                        ]),
                    child: Consumer<MyFacilities>(builder: (context, mf, ch) {
                      final myList = mf.chooseListById(hostel.facilities);
                      return GridView.count(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        childAspectRatio: 3 / 2,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        children: <Widget>[
                          ...List.generate(myList.length, (index) {
                            return gridWidget(index, myList[index]);
                          }),
                        ],
                        //itemBuilder: (ctx, index) => index==4? gridAddWidget("Images"): gridImage("assets/demo.jpg")
                      );
                    }),
                   ),
                  Text(
                    "Contact",
                    style: TextStyle(
                        fontSize: dSize.height * 0.025,
                        color: Color(0xFFC42B0B),
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.16),
                          )
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "Phone",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(hostel.phone),
                          trailing: Icon(
                            Icons.phone,
                            color: Theme.of(context).primaryColor,
                          ),
                          contentPadding: EdgeInsets.only(left: 15, right: 15),
                        ),
                        ListTile(
                          title: Text("WhatsApp",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          subtitle: Text(hostel.whatsApp),
                          trailing: Icon(
                            Icons.message,
                            color: Color(0xFF4FCE5D),
                          ),
                          contentPadding: EdgeInsets.only(left: 15, right: 15),
                        ),
                        if (hostel.facebookUrl != null)
                          ListTile(
                            title: Text("Facebook Page",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text(
                              hostel.facebookUrl,
                              maxLines: 1,
                            ),
                            trailing: Icon(
                              Icons.link,
                              color: Colors.blue,
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 15, right: 15),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Address",
                        style: TextStyle(
                            fontSize: dSize.height * 0.025,
                            color: Color(0xFFC42B0B),
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.20),
                              offset: Offset(0, 3),
                              blurRadius: 6)
                        ]),
                        child: Icon(Icons.my_location),
                      ),
                    ],
                  ),
                  Container(
                    height: dSize.height * 0.25,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.16),
                          )
                        ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
