import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: "Hi Ali\n", style: Theme.of(context).textTheme.subtitle1),
            TextSpan(
              text: "Find Your Hostel",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
