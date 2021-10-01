import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/filter_dialog/filter_category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'filter_view_model.dart';
import 'filter_brand_item.dart';

class FilterView extends StatefulWidget {
  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  FilterViewModel mViewModel;
  bool isCategoryHidden = true;
  bool isBrandHidden = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<FilterViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getCategoryList();
      mViewModel.getBrandList();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<FilterViewModel>(context);

    final topIcon = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 2,
          color: CommonColors.color_dcdcdc,
          margin: EdgeInsets.only(top: 5, bottom: 5),
        )
      ],
    );

    final layoutFilterBy = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: Text(
              S.of(context).filterBy,
              style: CommonStyle.getAppFont(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: CommonColors.dark_6060),
            ),
          ),
          Container(
            color: CommonColors.color_dcdcdc,
            height: 1,
          )
        ],
      ),
    );

    final layoutCategory = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 10, left: 20, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).categoryName,
                  style: CommonStyle.getAppFont(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: CommonColors.dark_6060),
                ),
                InkWell(
                    onTap: () {
                      isCategoryHidden = !isCategoryHidden;
                      mViewModel.notifyListeners();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Icon(
                        isCategoryHidden
                            ? Icons.keyboard_arrow_down_sharp
                            : Icons.keyboard_arrow_up_sharp,
                        color: CommonColors.color_515c6f,
                      ),
                    ))
              ],
            ),
          ),
          isCategoryHidden || mViewModel.categoryList.length == 0 ? Container() : ListView.builder(
              padding: EdgeInsets.only(top: 6, bottom: 6),
              shrinkWrap: true,
              itemCount: mViewModel.categoryList.length,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext ctxt, int index) {
                return InkWell(
                  onTap: () {
                    mViewModel.selectCategory(index);
                  },
                  child: FilterCategoryItemView(
                    categoryDetails: mViewModel.categoryList[index],
                  ),
                );
              }),
          Container(
            margin: EdgeInsets.only(top: 4),
            color: CommonColors.color_dcdcdc,
            height: 1,
          ),
        ],
      ),
    );

    final layoutBrand = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 10, left: 20, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).brandName,
                  style: CommonStyle.getAppFont(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: CommonColors.dark_6060),
                ),
                InkWell(
                    onTap: () {
                      isBrandHidden = !isBrandHidden;
                      mViewModel.notifyListeners();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Icon(
                        isBrandHidden
                            ? Icons.keyboard_arrow_down_sharp
                            : Icons.keyboard_arrow_up_sharp,
                        color: CommonColors.color_515c6f,
                      ),
                    ))
              ],
            ),
          ),
          isBrandHidden || mViewModel.brandList.length == 0
              ? Container()
              : GridView.count(
                  shrinkWrap: true,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 15.0,
                  crossAxisCount: 2,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 8),
                  childAspectRatio:
                      MediaQuery.of(context).size.shortestSide < 600
                          ? 3.5
                          : 4.0,
                  primary: false,
                  children: List.generate(
                      mViewModel.brandList.length,
                      (index) => InkWell(
                          onTap: () {
                            mViewModel.selectOrUnselectBrand(index);
                          },
                          child: FilterBrandItemView(
                            brandDetails: mViewModel.brandList[index],
                          ))),
                ),
          Container(
            margin: EdgeInsets.only(top: 4),
            color: CommonColors.color_dcdcdc,
            height: 1,
          ),
        ],
      ),
    );

    final layoutBottom = Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        children: [
          Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  AppPreferences().setFilter(null);
                  Navigator.pop(context, {AppConstants.FILTERS: "1"});
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: CommonColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(
                          width: 1, color: Colors.orangeAccent.withOpacity(.9))),
                  child: Center(
                    child: Text(
                      S.of(context).clearFilters.toUpperCase(),
                      style: CommonStyle.getAppFont(
                          color: Colors.orangeAccent.withOpacity(.9),
                          fontSize: 13,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )),
          SizedBox(width: 20,),
          Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  mViewModel.applyFilter(
                      onApplyFilter: () {
                        Navigator.pop(context, {AppConstants.FILTERS: "1"});
                      });
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent.withOpacity(.9),
                      borderRadius: BorderRadius.all(Radius.circular(4)),),
                  child: Center(
                    child: Text(
                      S.of(context).showResults.toUpperCase(),
                      style: CommonStyle.getAppFont(
                          color: CommonColors.white,
                          fontSize: 13,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 12, bottom: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topIcon,
                layoutFilterBy,
                layoutCategory,
                layoutBrand,
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: layoutBottom,
          )
        ],
      ),
    );
  }
}
