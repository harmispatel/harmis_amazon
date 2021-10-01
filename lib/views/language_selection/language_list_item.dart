import 'package:big_mart/models/language_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';

class LanguageListItemView extends StatelessWidget {
  LanguageMaster language;
  Function onClick;

  LanguageListItemView({this.language, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){
      onClick();
    },
    child: Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: CommonColors.white,
                    border: Border.all(color: CommonColors.color_515c6f, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: Text(
                    language.languageCode.toUpperCase(),
                    style: CommonStyle.getAppFont(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CommonColors.color_515c6f),
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        language.language.toString(),
                        style: CommonStyle.getAppFont(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: CommonColors.color_515c6f),
                      ),
                    ),
                    language.isSelected ? Container(
                      height: 40, width: 40,
                      child: Icon(
                        Icons.check,
                        color: Colors.orangeAccent,
                      ),
                    ) : Container(),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 1,
            color: CommonColors.color_c4c4c4,
          )
        ],
      ),
    ),);
  }
}
