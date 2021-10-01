import 'package:big_mart/views/cart/cart_list_view.dart';
import 'package:big_mart/views/categories/categories_view.dart';
import 'package:big_mart/views/deals/deal_list_view.dart';
import 'package:big_mart/views/home/home_view.dart';
import 'package:big_mart/views/login/login_view.dart';
import 'package:big_mart/views/more/more_view.dart';
import 'package:big_mart/views/more/more_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';

import 'bottom_nav_bar_view_model.dart';

class bottomNavigationBar extends StatefulWidget {
  @override
  _bottomNavigationBarState createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  //MoreViewModel mViewModel;
  BottomNavBarViewModel mViewModel;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final mViewModel =
          Provider.of<BottomNavBarViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      // mViewModel.setLanguageToBackend();
    });
  }

  /// Set a type current number a layout class
  /*Widget callPage(int current) {
    switch (current) {
      case 0:
        return HomeView();
      case 1:
        return CategoriesView();
      case 2:
        return DealListView();
      case 3:
        return CartListView();
      case 4:
        return MoreView();
      default:
        return new Text("Home"); //Menu(); //Menu();
    }
  }*/



  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
     mViewModel = Provider.of<BottomNavBarViewModel>(context);

    List<Widget> _widgetOptions = <Widget>[
      HomeView(),
      CategoriesView(),
      CartListView(),
      mViewModel.loginDetails == null?LoginView():MoreView()
    ];


    return Scaffold(
      body: _widgetOptions.elementAt(mViewModel.selectedIndex),
      //body: callPage(mViewModel.currentIndex),
      // bottomNavigationBar: Theme(
      //     data: Theme.of(context).copyWith(
      //         canvasColor: Colors.white,
      //         textTheme: Theme.of(context).textTheme.copyWith(
      //             caption: CommonStyle.getAppFont(
      //                 fontSize: 13,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.black26.withOpacity(0.15)))),
      //     child: BottomNavigationBar(
      //       elevation: 0.0,
      //       type: BottomNavigationBarType.fixed,
      //       currentIndex: mViewModel.currentIndex,
      //       fixedColor: CommonColors.primaryDarkColor,
      //       onTap: (value) {
      //         mViewModel.selectedTab(value, context);
      //       },
      //       items: [
      //         BottomNavigationBarItem(
      //             icon: Image.asset(
      //               mViewModel.currentIndex == 0
      //                   ? LocalImages.ic_home_selected
      //                   : LocalImages.ic_home_unselected,
      //               height: 22,
      //               width: 22,
      //             ),
      //             title: Padding(
      //               padding: const EdgeInsets.only(top: 3),
      //               child: Text(
      //                 S.of(context).home,
      //                 style: CommonStyle.getAppFont(
      //                   fontSize: 13,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             )),
      //         BottomNavigationBarItem(
      //             icon: Image.asset(
      //               mViewModel.currentIndex == 1
      //                   ? LocalImages.ic_category_selected
      //                   : LocalImages.ic_category_unselected,
      //               height: 22,
      //               width: 22,
      //             ),
      //             title: Padding(
      //               padding: const EdgeInsets.only(top: 3),
      //               child: Text(
      //                 S.of(context).categories,
      //                 style: CommonStyle.getAppFont(
      //                   fontSize: 13,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             )),
      //         BottomNavigationBarItem(
      //             icon: Image.asset(
      //               mViewModel.currentIndex == 2
      //                   ? LocalImages.ic_deals_selected
      //                   : LocalImages.ic_deals_unselected,
      //               height: 25,
      //               width: 22,
      //             ),
      //             title: Padding(
      //               padding: const EdgeInsets.only(top: 3),
      //               child: Text(
      //                 S.of(context).deals,
      //                 style: CommonStyle.getAppFont(
      //                   fontSize: 13,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             )),
      //         BottomNavigationBarItem(
      //             icon: Stack(
      //               children: [
      //                 Align(
      //                   alignment: Alignment.center,
      //                   child: Container(
      //                     margin: EdgeInsets.only(right: 5),
      //                     child: Image.asset(
      //                       mViewModel.currentIndex == 3
      //                           ? LocalImages.ic_cart_selected
      //                           : LocalImages.ic_cart_unselected,
      //                       height: 27,
      //                       width: 22,
      //                     ),
      //                   ),
      //                 ),
      //                 mViewModel.cartCount > 0
      //                     ? Align(
      //                         alignment: Alignment.topCenter,
      //                         child: Container(
      //                           margin: EdgeInsets.only(left: 10),
      //                           height: 18,
      //                           width: 18,
      //                           decoration: BoxDecoration(
      //                               color: CommonColors.red,
      //                               borderRadius:
      //                                   BorderRadius.all(Radius.circular(9))),
      //                           child: Center(
      //                             child: Text(
      //                               mViewModel.cartCount.toString(),
      //                               style: CommonStyle.getAppFont(
      //                                 fontSize: 10,
      //                                 color: Colors.white,
      //                                 fontWeight: FontWeight.w400,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       )
      //                     : Container()
      //               ],
      //             ),
      //             title: Padding(
      //               padding: const EdgeInsets.only(top: 3),
      //               child: Text(
      //                 S.of(context).cart,
      //                 style: CommonStyle.getAppFont(
      //                   fontSize: 13,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             )),
      //         BottomNavigationBarItem(
      //             icon: Image.asset(
      //               mViewModel.currentIndex == 4
      //                   ? LocalImages.ic_more_selected
      //                   : LocalImages.ic_more_unselected,
      //               height: 28,
      //               width: 22,
      //             ),
      //             title: Padding(
      //               padding: const EdgeInsets.only(top: 3),
      //               child: Text(
      //                 S.of(context).more,
      //                 style: CommonStyle.getAppFont(
      //                   fontSize: 13,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             )),
      //       ],
      //     )),
      bottomNavigationBar: SizedBox(
        height: 90 ,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                //rippleColor: Colors.orange,
                //hoverColor: Colors.orange,
                selectedIndex: mViewModel.selectedIndex,
                onTabChange:(index){
                  mViewModel.changeTab(index);
                  },
                gap: 6,
                activeColor: Colors.white,
                iconSize: 27,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.orangeAccent.withOpacity(0.9),
                color: Colors.grey,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: S.of(context).home,
                  ),
                  GButton(
                    icon: LineIcons.list,
                    text: S.of(context).category,
                  ),
                  GButton(
                    icon: LineIcons.shoppingCart,
                    text: S.of(context).mycart,
                  ),
                  GButton(
                    icon: LineIcons.userAlt,
                    text: S.of(context).myProfile,
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
