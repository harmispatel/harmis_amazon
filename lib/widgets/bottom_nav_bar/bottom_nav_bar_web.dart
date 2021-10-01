import 'package:big_mart/views/cart/cart_list_view.dart';
import 'package:big_mart/views/categories/categories_view.dart';
import 'package:big_mart/views/categories_web/categories_view_web.dart';
import 'package:big_mart/views/deals/deal_list_view.dart';
import 'package:big_mart/views/deals/deal_list_view_web.dart';
import 'package:big_mart/views/home/home_view.dart';
import 'package:big_mart/views/home/home_view_web.dart';
import 'package:big_mart/views/more/more_view.dart';
import 'package:big_mart/views/more/more_view_web.dart';
import 'package:big_mart/views/search_product/search_product_view.dart';
import 'package:big_mart/views/search_product/search_product_view_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'bottom_nav_bar_view_model.dart';

class bottomNavigationBarWeb extends StatefulWidget {
  @override
  _bottomNavigationBarWebState createState() => _bottomNavigationBarWebState();
}

class _bottomNavigationBarWebState extends State<bottomNavigationBarWeb> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final mViewModel =
          Provider.of<BottomNavBarViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.setLanguageToBackend();
    });
  }

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return HomeViewWeb();
      case 1:
        return CategoriesViewWeb();
      case 2:
        return DealListViewWeb();
      case 3:
        return CartListView();
      default:
        return new Text("Home"); //Menu(); //Menu();
    }
  }

  showMenus(BuildContext context) async {
    await showMenu(
      context: context,
      position:
          RelativeRect.fromLTRB(MediaQuery.of(context).size.width, 50, 30, 0),
      items: [
        PopupMenuItem(child: MoreViewWeb()),
        // PopupMenuItem(
        //   child: Text("Edit"),
        // ),
        // PopupMenuItem(
        //   child: Text("Delete"),
        // ),
      ],
    );
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    final mViewModel = Provider.of<BottomNavBarViewModel>(context);

    final layoutAppBar = Container(
      width: MediaQuery.of(context).size.width * 0.40,
      // height: 55,
      padding: EdgeInsets.only(top: 7, bottom: 7),
      // color: CommonColors.primaryColor,
      child: Row(
        children: [
          /*SizedBox(
            width: 16,
          ),*/
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.025,
          ),
          Flexible(
              child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(seconds: 1),
                      pageBuilder: (_, __, ___) => SearchProductViewWeb()));
            },
            child: Container(
              height: 40,
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 1.5, bottom: 5),
              decoration: BoxDecoration(
                  color: CommonColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  Container(
                    height: 11,
                    width: 11,
                    child: Image.asset(LocalImages.ic_search),
                  ),
                  Flexible(
                      child: Container(
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: S.of(context).searchForProducts,
                        hintStyle: CommonStyle.getAppFont(
                            color: CommonColors.color_515c6f,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0),
                        contentPadding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 14),
                        border: InputBorder.none,
                      ),
                      style: CommonStyle.getAppFont(
                          color: CommonColors.primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0),
                      maxLines: 1,
                      autocorrect: false,
                    ),
                  ))
                ],
              ),
            ),
          )),
        ],
      ),
    );

    final layoutCategory = Container(
      width: MediaQuery.of(context).size.width * 0.15,
      // height: 55,
      padding: EdgeInsets.only(top: 7, bottom: 7),
      // color: CommonColors.primaryColor,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
          ),
          Flexible(
            child: InkWell(
              onTap: () {
                mViewModel.selectedTabWeb(1, context);
              },
              child: Text(
                S.of(context).categories,
                style: CommonStyle.getAppFont(
                  fontSize: mViewModel.currentIndex == 1 ? 16 : 13,
                  color: CommonColors.primaryWhite,
                  fontWeight: mViewModel.currentIndex == 1
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final layoutDeal = Container(
      width: MediaQuery.of(context).size.width * 0.1,
      // height: 55,
      padding: EdgeInsets.only(top: 7, bottom: 7),
      // color: CommonColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*SizedBox(
            width: MediaQuery.of(context).size.width * 0.025,
          ),*/
          Flexible(
            child: InkWell(
              onTap: () {
                mViewModel.selectedTabWeb(2, context);
              },
              child: Text(
                S.of(context).deals,
                style: CommonStyle.getAppFont(
                  fontSize: mViewModel.currentIndex == 2 ? 16 : 13,
                  color: CommonColors.primaryWhite,
                  fontWeight: mViewModel.currentIndex == 2
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final layoutCart = Container(
      width: MediaQuery.of(context).size.width * 0.1,
      // height: 55,
      padding: EdgeInsets.only(top: 7, bottom: 7),
      // color: CommonColors.primaryColor,
      child: Row(
        children: [
          /* SizedBox(
            width: MediaQuery.of(context).size.width * 0.025,
          ),*/
          Flexible(
            child: InkWell(
                onTap: () {
                  mViewModel.selectedTabWeb(3, context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).cart,
                      style: CommonStyle.getAppFont(
                        fontSize: mViewModel.currentIndex == 3 ? 16 : 13,
                        color: CommonColors.primaryWhite,
                        fontWeight: mViewModel.currentIndex == 3
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    mViewModel.cartCount > 0
                        ? Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                  color: CommonColors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(9))),
                              child: Center(
                                child: Text(
                                  mViewModel.cartCount.toString(),
                                  style: CommonStyle.getAppFont(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                )),
          ),
        ],
      ),
    );

    final layoutMore = Container(
      width: MediaQuery.of(context).size.width * 0.1,
      // height: 55,
      padding: EdgeInsets.only(top: 7, bottom: 7),
      // color: CommonColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*SizedBox(
            width: MediaQuery.of(context).size.width * 0.025,
          ),*/
          Flexible(
            child: MouseRegion(
              onHover: (event) => showMenus(context),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      S.of(context).more,
                      style: CommonStyle.getAppFont(
                        fontSize: mViewModel.currentIndex == 4 ? 16 : 13,
                        color: CommonColors.primaryWhite,
                        fontWeight: mViewModel.currentIndex == 4
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final layoutHome = Container(
      width: MediaQuery.of(context).size.width * 0.12,
      // height: 55,
      padding: EdgeInsets.only(top: 7, bottom: 7),
      // color: CommonColors.primaryColor,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.025,
          ),
          Flexible(
            child: InkWell(
                onTap: () {
                  mViewModel.selectedTabWeb(0, context);
                },
                child: Flexible(
                    child: Row(children: [
                  Container(
                    height: 31,
                    width: 38,
                    child: Image.asset(LocalImages.ic_home_header),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.009),
                  Flexible(
                    child: Container(
                        child: Text(S.of(context).appName,
                            style: CommonStyle.getAppFont(
                              fontSize: mViewModel.currentIndex == 0 ? 15 : 13,
                              color: CommonColors.primaryWhite,
                              fontWeight: mViewModel.currentIndex == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ))),
                  ),
                ]))),
          ),
        ],
      ),
    );

    return Scaffold(
      body: callPage(mViewModel.currentIndex),
      appBar: PreferredSize(
          preferredSize: MediaQuery.of(context).size,
          //Size(MediaQuery.of(context).size.width, 1000),

          child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                textTheme: Theme.of(context).textTheme.copyWith(
                    caption: CommonStyle.getAppFont(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26.withOpacity(0.15)))),
            child: Container(
                height: 50,
                color: CommonColors.color_4a9b6f,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    layoutHome,
                    layoutAppBar,
                    layoutCategory,
                    layoutDeal,
                    layoutCart,
                    layoutMore
                  ],
                )
                /*Text(
                        S.of(context).more,
                        style: CommonStyle.getAppFont(
                          fontSize: 13,
                          color: mViewModel.currentIndex == 4
                              ? CommonColors.red
                              : CommonColors.primaryWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),*/
                ),
          )
/*              child: BottomNavigationBar(
                elevation: 0.0,
                type: BottomNavigationBarType.fixed,
                currentIndex: mViewModel.currentIndex,
                fixedColor: CommonColors.primaryDarkColor,
                onTap: (value) {
                  mViewModel.selectedTab(value, context);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        mViewModel.currentIndex == 0
                            ? LocalImages.ic_home_selected
                            : LocalImages.ic_home_unselected,
                        height: 22,
                        width: 22,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          S.of(context).home,
                          style: CommonStyle.getAppFont(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        mViewModel.currentIndex == 1
                            ? LocalImages.ic_category_selected
                            : LocalImages.ic_category_unselected,
                        height: 22,
                        width: 22,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          S.of(context).categories,
                          style: CommonStyle.getAppFont(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        mViewModel.currentIndex == 2
                            ? LocalImages.ic_deals_selected
                            : LocalImages.ic_deals_unselected,
                        height: 25,
                        width: 22,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          S.of(context).deals,
                          style: CommonStyle.getAppFont(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  BottomNavigationBarItem(
                      icon: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Image.asset(
                                mViewModel.currentIndex == 3
                                    ? LocalImages.ic_cart_selected
                                    : LocalImages.ic_cart_unselected,
                                height: 27,
                                width: 22,
                              ),
                            ),
                          ),
                          mViewModel.cartCount > 0
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                        color: CommonColors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(9))),
                                    child: Center(
                                      child: Text(
                                        mViewModel.cartCount.toString(),
                                        style: CommonStyle.getAppFont(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          S.of(context).cart,
                          style: CommonStyle.getAppFont(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        mViewModel.currentIndex == 4
                            ? LocalImages.ic_more_selected
                            : LocalImages.ic_more_unselected,
                        height: 28,
                        width: 22,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          S.of(context).more,
                          style: CommonStyle.getAppFont(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ],
              )*/
          ),
    );
  }
}
