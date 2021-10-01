import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  String message;

  NoDataWidget({this.message});

  @override
  Widget build(BuildContext context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              LocalImages.ic_amazon_logo,
              width: 180,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                message?? "",
                textAlign: TextAlign.center,
                style: CommonStyle.getAppFont(
                    color: CommonColors.black, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 90,
            ),
          ],
        ),
      );
    }
}
