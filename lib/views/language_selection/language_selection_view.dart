import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/language_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/language_selection/language_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'language_selection_view_model.dart';

class LanguageSelectionView extends StatefulWidget {
  bool from;
  LanguageSelectionView({this.from});
  @override
  _LanguageSelectionViewState createState() => _LanguageSelectionViewState();
}

class _LanguageSelectionViewState extends State<LanguageSelectionView> {
  final globalKey = new GlobalKey();
  LanguageSelectionViewModel mViewModel;
  bool ishidden = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<LanguageSelectionViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.addLanguages();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<LanguageSelectionViewModel>(context);
    final tvPreferredLanguage = Padding(
      padding: EdgeInsets.all(0),
      child: Text(
        S.of(context).yourPreferredLanguage,
        style: CommonStyle.getAppFont(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: CommonColors.color_515c6f),
      ),
    );

    final layoutLanguages = ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: mViewModel.languageList.length,
        itemBuilder: (_context, index) {
          return LanguageListItemView(
            language: mViewModel.languageList[index],
            onClick: () {
              for (int i = 0; i < mViewModel.languageList.length; i++) {
                mViewModel.languageList[i].isSelected = false;
              }
              mViewModel.languageList[index].isSelected = true;
              mViewModel.selectedLanguageCode = mViewModel.languageList[index].languageCode;
              mViewModel.notifyListeners();
            },
          );
        });

    final btnConfirm = InkWell(
      onTap: () {
        mViewModel.changeLanguageCode();
        print("dnndn");
      },
      child: Container(
        margin: EdgeInsets.only(top: 12),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.orangeAccent.withOpacity(.9),
            borderRadius: BorderRadius.all(Radius.circular(4)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Center(
          child: Text(
            S.of(context).confirm,
            style: CommonStyle.getAppFont(
                color: CommonColors.white,
                fontSize: 18,
                letterSpacing: 1,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );

    return Scaffold(
      key: globalKey,
      backgroundColor: CommonColors.white,
      appBar: AppBar(
        backgroundColor: CommonColors.dark_6060,
        elevation: 0.0,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.only(left: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: widget.from,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      height: 17,
                      child: Image.asset(LocalImages.ic_arrow_back,color: Colors.white,),
                    ),
                  ),
              ),
              Flexible(
                child: Padding(
                  padding: widget.from
                      ? const EdgeInsets.only(left: 70, right: 110)
                  :const EdgeInsets.only(left: 115, right: 110),
                  child: Text(
                    S.of(context).language,
                    style: CommonStyle.getAppFont(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: CommonColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tvPreferredLanguage,
                layoutLanguages,
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: btnConfirm,
            )
          ],
        ),
      ),
    );
  }
}
