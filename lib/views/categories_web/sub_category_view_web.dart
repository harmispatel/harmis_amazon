import 'package:big_mart/models/category.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/views/categories/sub_category_view_model.dart';
import 'package:big_mart/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'sub_category_item_web.dart';

class SubCategoryView extends StatefulWidget {
  String categoryId;
  Function onSubCategoryClick;

  SubCategoryView({this.categoryId, this.onSubCategoryClick});

  @override
  _SubCategoryViewState createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  SubCategoryViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<SubCategoryViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      if (!mViewModel.isApiLoading)
        mViewModel.initSubCategoryList(widget.categoryId);
      print("initState ..........");
    });
  }

  @override
  void didUpdateWidget(covariant SubCategoryView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      mViewModel.initSubCategoryList(widget.categoryId);
      print("didUpdateWidget ..........");
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SubCategoryViewModel>(context);
    return mViewModel.isApiLoading
        ? Center(
            child: SpinKitRing(
              color: CommonColors.primaryColor,
              size: 40,
              lineWidth: 4,
            ),
          )
        : mViewModel.subCategoryList.length > 0
            ? Container(
                margin: EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: mViewModel.subCategoryList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                        onTap: () {
                          widget.onSubCategoryClick(mViewModel
                              .subCategoryList[index].categoriesId
                              .toString());
                        },
                        child: SubCategoryItemView(
                          subCategory: mViewModel.subCategoryList[index],
                        ),
                      );
                    }),
              )
            : NoDataWidget(
                message: mViewModel.message,
              );
  }
}
