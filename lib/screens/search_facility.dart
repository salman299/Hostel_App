import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:hostel_app/module/hostel.dart';
import 'package:provider/provider.dart';
import '../module/providers.dart';

class SearchFacility extends StatelessWidget {
  static const routeName = '/search';
  final SearchBarController<CommonFacility> _searchBarController = SearchBarController();
  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    final List<CommonFacility> facilities = Provider.of<MyFacilities>(context, listen: false).items;
    Future<List<CommonFacility>> _getALlPosts(String text) async {
      await Future.delayed(Duration(seconds: text.length == 5 ? 2 : 1));
      List<CommonFacility> prods = await Provider.of<MyFacilities>(context, listen: false).getBuyName(text);
      return prods;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Theme(
          data: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              border: InputBorder.none
            ),
          ),
          child: Stack(
            children: <Widget>[
              Consumer<MyFacilities>(
                builder: (context,mf,ch)=>SearchBar<CommonFacility>(
                  searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
                  searchBarStyle: SearchBarStyle(
                    borderRadius: BorderRadius.circular(10),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    backgroundColor: Colors.black.withOpacity(0.06),
                  ),
                  //headerPadding: EdgeInsets.symmetric(horizontal: 10),
                  iconActiveColor: Colors.black,
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.50),
                  ),
                  shrinkWrap: true,
                  hintText: 'Search Facilities',
                  onSearch: _getALlPosts,
                  //searchBarStyle: SearchBarStyle(backgroundColor: Theme.of(context).primaryColorLight),
                  icon: Icon(
                    Icons.search,
                    color: Colors.black.withOpacity(0.50),
                  ),
                  searchBarController: _searchBarController,
                  placeHolder:  GridView.count(
                    //physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(right: 10,left: 10,bottom: 80,top: 10),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: <Widget>[
                      ...List.generate(facilities.length, (index) {
                        return GestureDetector(
                          onTap: (){
                            mf.addItems(facilities[index].id);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: mf.chooseItems[index] ? Color(0xFFEA3755): Colors.black.withOpacity(0.50),
                                )
                            ),
                            child: GridTile(
                              footer: Text(facilities[index].name,textAlign: TextAlign.center,),
                              child: Icon(facilities[index].icon),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  cancellationWidget: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  emptyWidget: Center(),
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                  onCancelled: () {
                    print("Cancelled triggered");
                  },
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  onItemFound: (CommonFacility post, int index) {
                    return SearchTile(post: post,check: true,);
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                right: 20,
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.center,
                   // height: dSize.height*0.075,
                    padding: EdgeInsets.symmetric(vertical: 10),
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
                    child: Text("Save", style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: dSize.height*0.025),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final check;
  final CommonFacility post;
  SearchTile({this.post,this.check});

  void dialogExecute(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    final fontRatio = dSize.height / 737.456;
    return Container(
      alignment: Alignment.center,
      height: dSize.height * 0.095,
      width: dSize.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      // color: Theme.of(context).primaryColor,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 30),
        leading: Icon(post.icon),
        trailing: Icon(
          check ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: check? Color(0xFFEA3755) : Colors.black,
        ),
        title: Text(
          post.name,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onTap: (){},
      ),
    );
  }
}
