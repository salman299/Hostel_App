import 'package:flutter/material.dart';
import 'package:hostel_app/custom_icons_icons.dart';
import 'package:hostel_app/screens/home/component/search_filter_dialog.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                //onChanged: (value) => print(value),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical:15,),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Search product",
                    prefixIcon: Icon(Icons.search),
                  // suffixIcon: Icon(Icons.filter)
                ),
              ),
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(15),
          ),
          IconButton(icon: Icon(CustomIcons.filter,),onPressed: (){
            showDialog(context: context,builder: (ctx) =>SearchFilterDialog());
          },)
        ],
      ),
    );
  }
}
