import 'package:flutter/material.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SwitchLanguageItem extends StatelessWidget {
  String title;
  int selectedLanguage;
  Function onLanguageChange;
  IconData icon;

  SwitchLanguageItem(
      {this.title, this.selectedLanguage, this.onLanguageChange, this.icon});

  @override
  Widget build(BuildContext context) {
    final orderNoAndAmount = Container(
      margin: EdgeInsets.only(top: 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              title,
              style: CommonStyle.getAppFont(
                color: CommonColors.color_515c6f,
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );

    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.only(left: 12.0, right: 15.0),
//        decoration: BoxDecoration(
//            color: CommonColors.primaryWhite,
//            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.only(left: 0.0),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  clipBehavior: Clip.antiAlias,
                  child: Icon(
                    icon,
                    size: 25.0,
                    color: CommonColors.primaryColor,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 16.0, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            orderNoAndAmount,
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Container(
              height: 35,
              width: 147,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(17.5)),
                  border:
                      Border.all(color: CommonColors.color_f3f3f3, width: 1)),
              child: ToggleSwitch(
                cornerRadius: 17.5,
                initialLabelIndex: selectedLanguage,
                activeBgColor: CommonColors.primaryColor,
                inactiveBgColor: Colors.white,
                labels: ['English', 'العربية'],
                onToggle: (index) {
                  print('switched to: $index');
                  onLanguageChange(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
