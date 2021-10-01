import 'dart:io';

import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/app.dart';
import 'package:big_mart/services/api_url.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/addressList/address_list_view.dart';
import 'package:big_mart/views/cart/cart_list_view_model.dart';
import 'package:big_mart/views/categories/categories_view_model.dart';
import 'package:big_mart/views/deals/deal_list_view.dart';
import 'package:big_mart/views/deals/deal_list_view_model.dart';
import 'package:big_mart/views/home/home_view_model.dart';
import 'package:big_mart/views/language_selection/language_selection_view.dart';
import 'package:big_mart/views/login/login_view.dart';
import 'package:big_mart/views/my_list/my_list_view.dart';
import 'package:big_mart/views/my_orders/my_orders_view.dart';
import 'package:big_mart/views/profile/profile_view.dart';
import 'package:big_mart/views/search_product/search_product_view.dart';
import 'package:big_mart/views/web_view/web_view_page.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'more_view_model.dart';
import 'switch_language_item.dart';

class MoreView extends StatefulWidget {
  @override
  _MoreViewState createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  final globalKey = new GlobalKey();
  MoreViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<MoreViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getLoginDetails();
      mViewModel.setCurrentLanguage();
    });
    //Devicelocale.currentLocale.then((value) => print("device locale: " + value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<MoreViewModel>(context);

    // final layoutAppBar = Container(
    //   height: 55,
    //   padding: EdgeInsets.only(left: 20, right: 20),
    //   color: CommonColors.primaryColor,
    //   child: Row(
    //     children: [
    //       Flexible(
    //           child: InkWell(
    //         onTap: () {
    //           Navigator.push(
    //               context,
    //               PageRouteBuilder(
    //                   transitionDuration: Duration(seconds: 1),
    //                   pageBuilder: (_, __, ___) => SearchProductView()));
    //         },
    //         child: Container(
    //           height: 40,
    //           padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
    //           decoration: BoxDecoration(
    //               color: CommonColors.white,
    //               borderRadius: BorderRadius.all(Radius.circular(20))),
    //           child: Row(
    //             children: [
    //               Container(
    //                 height: 11,
    //                 width: 11,
    //                 child: Image.asset(LocalImages.ic_search),
    //               ),
    //               Flexible(
    //                   child: Container(
    //                 child: TextField(
    //                   enabled: false,
    //                   decoration: InputDecoration(
    //                     hintText: S.of(context).searchForProducts,
    //                     hintStyle: CommonStyle.getAppFont(
    //                         color: CommonColors.color_515c6f,
    //                         fontWeight: FontWeight.w400,
    //                         fontSize: 15.0),
    //                     contentPadding:
    //                         EdgeInsets.only(left: 20, right: 20, bottom: Platform.isAndroid ? mViewModel.languageCode == AppConstants.LANGUAGE_ARABIC ? 8 : 14 : 14),
    //                     border: InputBorder.none,
    //                   ),
    //                   style: CommonStyle.getAppFont(
    //                       color: CommonColors.primaryColor,
    //                       fontWeight: FontWeight.w400,
    //                       fontSize: 16.0),
    //                   maxLines: 1,
    //                   autocorrect: false,
    //                 ),
    //               ))
    //             ],
    //           ),
    //         ),
    //       ))
    //     ],
    //   ),
    // );


    if (mViewModel.loginDetails==null) {
    return  Container(
        child: Center(
          child: SpinKitRing(
            color: Colors.orangeAccent,
            size: 40,
            lineWidth: 4,
          ),
        ),
      );
    }


    final layoutAppBar = Container(
        height: 75,
        padding: EdgeInsets.only(left: 10, right: 20),
        color: CommonColors.dark_6060,
        child:
        Container(
            padding: EdgeInsets.only(left: 15, top: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(
                children: [
                 /* Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                             mViewModel.loginDetails.image),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),*/
                  Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18, top: 2),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mViewModel.loginDetails.firstName.toString(), style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: CommonColors.white,
                            ),),
                            SizedBox(height: 5,),
                            Text(mViewModel.loginDetails.email.toString(), style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                                color: CommonColors.white
                            ),),
                          ],
                        ),
                      )
                  ),
                ],
              ),
                Row(
                  children: [
                    IconButton(onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return ProfileView();
                          }));
                    },
                    icon: Icon(Icons.edit, color: CommonColors.white, size: 30,)),
                  ],
                )
              ],
            )
        )
    );


    //   return Scaffold(
    //     backgroundColor: CommonColors.color_f3f3f3,
    //     body: Stack(
    //       children: [
    //         SingleChildScrollView(
    //           padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 height: MediaQuery.of(context).padding.top +
    //                     AppBar().preferredSize.height,
    //               ),
    //               mViewModel.selectedLanguage != null
    //                   ? SwitchLanguageItem(
    //                       title: S.of(context).language,
    //                       selectedLanguage: mViewModel.selectedLanguage,
    //                       icon: Icons.language,
    //                       onLanguageChange: (int index) {
    //                         mViewModel.selectedLanguage = index;
    //                         if (index == 0) {
    //                           AppPreferences()
    //                               .setLanguageCode(AppConstants.LANGUAGE_ENGLISH);
    //                           mViewModel.languageCode =
    //                               AppConstants.LANGUAGE_ENGLISH;
    //                         } else {
    //                           AppPreferences()
    //                               .setLanguageCode(AppConstants.LANGUAGE_ARABIC);
    //
    //                           mViewModel.languageCode =
    //                               AppConstants.LANGUAGE_ARABIC;
    //                         }
    //                         Provider.of<AppModel>(context, listen: false)
    //                             .changeLanguage();
    //                         Provider.of<HomeViewModel>(context, listen: false)
    //                             .clearList();
    //                         Provider.of<CategoriesViewModel>(context,
    //                                 listen: false)
    //                             .clearList();
    //                         Provider.of<DealListViewModel>(context, listen: false)
    //                             .clearList();
    //                         mViewModel.setLanguageToBackend();
    //                         mViewModel.notifyListeners();
    //                       },
    //                     )
    //                   : Container(),
    //               mViewModel.loginDetails == null
    //                   ? Container()
    //                   : Container(
    //                       padding: EdgeInsets.only(left: 16, right: 16),
    //                       margin: EdgeInsets.only(bottom: 20),
    //                       decoration: BoxDecoration(
    //                           color: CommonColors.white,
    //                           borderRadius:
    //                               BorderRadius.all(Radius.circular(12))),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           InkWell(
    //                             onTap: () {
    //                               Navigator.push(context,
    //                                   MaterialPageRoute(builder: (context) {
    //                                 return ProfileView();
    //                               }));
    //                             },
    //                             child: getCommonRow(LocalImages.ic_profile,
    //                                 S.of(context).profile, true),
    //                           ),
    //                           InkWell(
    //                             onTap: () {
    //                               Navigator.push(context,
    //                                   MaterialPageRoute(builder: (context) {
    //                                 return AddressListView();
    //                               }));
    //                             },
    //                             child: getCommonRow(LocalImages.ic_more_address,
    //                                 S.of(context).address, true),
    //                           ),
    //                           InkWell(
    //                               onTap: () {
    //                                 Navigator.push(context,
    //                                     MaterialPageRoute(builder: (context) {
    //                                   return MyOrdersView();
    //                                 }));
    //                               },
    //                               child: getCommonRow(LocalImages.ic_more_orders,
    //                                   S.of(context).orders, true)),
    //                           /*InkWell(
    //                               onTap: () {},
    //                               child: getCommonRow(LocalImages.ic_more_receipt,
    //                                   S.of(context).storeReceipts, true)),*/
    //                           InkWell(
    //                               onTap: () {
    //                                 Navigator.push(context,
    //                                     MaterialPageRoute(builder: (context) {
    //                                   return MyListView();
    //                                 }));
    //                               },
    //                               child: getCommonRow(
    //                                   LocalImages.ic_more_shopping_list,
    //                                   S.of(context).shoppingLists,
    //                                   false)),
    //                         ],
    //                       ),
    //                     ),
    //               Container(
    //                 padding: EdgeInsets.only(left: 16, right: 16),
    //                 decoration: BoxDecoration(
    //                     color: CommonColors.white,
    //                     borderRadius: BorderRadius.all(Radius.circular(12))),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     mViewModel.loginDetails == null
    //                         ? Container()
    //                         : InkWell(
    //                             onTap: () {
    //                               Navigator.push(context,
    //                                   MaterialPageRoute(builder: (context) {
    //                                 return MyOrdersView();
    //                               }));
    //                             },
    //                             child: getCommonRow(LocalImages.ic_more_buy_again,
    //                                 S.of(context).buyAgain, true),
    //                           ),
    //                     InkWell(
    //                       onTap: () async {
    //                         kIsWeb
    //                             ? await launch(
    //                                 mViewModel.languageCode != null &&
    //                                         mViewModel.languageCode ==
    //                                             AppConstants.LANGUAGE_ENGLISH
    //                                     ? ApiUrl.CONTACT_US
    //                                     : ApiUrl.CONTACT_US_AR,
    //                                 forceSafariVC: false,
    //                                 forceWebView: false,
    //                                 headers: <String, String>{
    //                                   'my_header_key': 'my_header_value'
    //                                 },
    //                               )
    //                             : Navigator.push(context,
    //                                 MaterialPageRoute(builder: (_context) {
    //                                 return WebViewPage(
    //                                   title: S.of(context).contactUs,
    //                                   url: mViewModel.languageCode != null &&
    //                                           mViewModel.languageCode ==
    //                                               AppConstants.LANGUAGE_ENGLISH
    //                                       ? ApiUrl.CONTACT_US
    //                                       : ApiUrl.CONTACT_US_AR,
    //                                 );
    //                               }));
    //                       },
    //                       child: getCommonRow(LocalImages.ic_more_contact_us,
    //                           S.of(context).contactUs, true),
    //                     ),
    //                     InkWell(
    //                         onTap: () async {
    //                           kIsWeb
    //                               ? await launch(
    //                                   mViewModel.languageCode != null &&
    //                                           mViewModel.languageCode ==
    //                                               AppConstants.LANGUAGE_ENGLISH
    //                                       ? ApiUrl.ABOUT_US
    //                                       : ApiUrl.ABOUT_US_AR,
    //                                   forceSafariVC: false,
    //                                   forceWebView: false,
    //                                   headers: <String, String>{
    //                                     'my_header_key': 'my_header_value'
    //                                   },
    //                                 )
    //                               : Navigator.push(context,
    //                                   MaterialPageRoute(builder: (_context) {
    //                                   return WebViewPage(
    //                                     title: S.of(context).aboutUs,
    //                                     url: mViewModel.languageCode != null &&
    //                                             mViewModel.languageCode ==
    //                                                 AppConstants.LANGUAGE_ENGLISH
    //                                         ? ApiUrl.ABOUT_US
    //                                         : ApiUrl.ABOUT_US_AR,
    //                                   );
    //                                 }));
    //                         },
    //                         child: getCommonRow(LocalImages.ic_more_about_us,
    //                             S.of(context).aboutUs, true)),
    //                     InkWell(
    //                         onTap: () async {
    //                           kIsWeb
    //                               ? await launch(
    //                                   mViewModel.languageCode != null &&
    //                                           mViewModel.languageCode ==
    //                                               AppConstants.LANGUAGE_ENGLISH
    //                                       ? ApiUrl.TERMS_AND_CONDITION
    //                                       : ApiUrl.TERMS_AND_CONDITION_AR,
    //                                   forceSafariVC: false,
    //                                   forceWebView: false,
    //                                   headers: <String, String>{
    //                                     'my_header_key': 'my_header_value'
    //                                   },
    //                                 )
    //                               : Navigator.push(context,
    //                                   MaterialPageRoute(builder: (_context) {
    //                                   return WebViewPage(
    //                                     title: S.of(context).termsAndCondition,
    //                                     url: mViewModel.languageCode != null &&
    //                                             mViewModel.languageCode ==
    //                                                 AppConstants.LANGUAGE_ENGLISH
    //                                         ? ApiUrl.TERMS_AND_CONDITION
    //                                         : ApiUrl.TERMS_AND_CONDITION_AR,
    //                                   );
    //                                 }));
    //                           // Get client information
    //                           /* ClientInformation info =
    //                               await ClientInformation.fetch();
    //                           print(info.deviceId);*/
    //                           /*String deviceId =
    //                               await PlatformDeviceId.getDeviceId;*/
    //                         },
    //                         child: getCommonRow(
    //                             LocalImages.ic_more_terms_condition,
    //                             S.of(context).termsAndCondition,
    //                             true)),
    //                     InkWell(
    //                         onTap: () async {
    //                           kIsWeb
    //                               ? await launch(
    //                                   mViewModel.languageCode != null &&
    //                                           mViewModel.languageCode ==
    //                                               AppConstants.LANGUAGE_ENGLISH
    //                                       ? ApiUrl.PRIVACY_POLICY
    //                                       : ApiUrl.PRIVACY_POLICY_AR,
    //                                   forceSafariVC: false,
    //                                   forceWebView: false,
    //                                   headers: <String, String>{
    //                                     'my_header_key': 'my_header_value'
    //                                   },
    //                                 )
    //                               : Navigator.push(context,
    //                                   MaterialPageRoute(builder: (_context) {
    //                                   return WebViewPage(
    //                                     title: S.of(context).privacyPolicy,
    //                                     url: mViewModel.languageCode != null &&
    //                                             mViewModel.languageCode ==
    //                                                 AppConstants.LANGUAGE_ENGLISH
    //                                         ? ApiUrl.PRIVACY_POLICY
    //                                         : ApiUrl.PRIVACY_POLICY_AR,
    //                                   );
    //                                 }));
    //                         },
    //                         child: getCommonRow(
    //                             LocalImages.ic_more_privacy_policy,
    //                             S.of(context).privacyPolicy,
    //                             false)),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Container(
    //                 padding: EdgeInsets.only(left: 16, right: 16),
    //                 decoration: BoxDecoration(
    //                     color: CommonColors.white,
    //                     borderRadius: BorderRadius.all(Radius.circular(12))),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     mViewModel.loginDetails == null
    //                         ? InkWell(
    //                             onTap: () {
    //                               Navigator.push(context,
    //                                   MaterialPageRoute(builder: (context) {
    //                                 return LoginView();
    //                               }));
    //                             },
    //                             child: getCommonRow(LocalImages.ic_more_logout,
    //                                 S.of(context).login, true),
    //                           )
    //                         : InkWell(
    //                             onTap: () {
    //                               mViewModel.clearSession();
    //                             },
    //                             child: getCommonRow(LocalImages.ic_more_logout,
    //                                 S.of(context).logout, true),
    //                           ),
    //                     /* InkWell(
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => GoogleTest()));
    //                       },
    //                       child: getCommonRow(LocalImages.ic_more_logout,
    //                           S.of(context).login, true),
    //                     )*/
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(
    //               height: MediaQuery.of(context).padding.top,
    //             ),
    //             layoutAppBar,
    //           ],
    //         ),
    //       ],
    //     ),
    //   );
    // }
    //
    // Widget getCommonRow(String icon, String title, bool divider) {
    //   return Container(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(
    //           children: [
    //             Container(height: 20, width: 20, child: Image.asset(icon)),
    //             Padding(
    //               padding: const EdgeInsets.all(20.0),
    //               child: Text(
    //                 title,
    //                 style: CommonStyle.getAppFont(
    //                     fontSize: 14,
    //                     fontWeight: FontWeight.w400,
    //                     color: CommonColors.color_515c6f),
    //               ),
    //             ),
    //           ],
    //         ),
    //         divider
    //             ? Container(
    //                 height: 1,
    //                 color: CommonColors.color_f3f3f3,
    //               )
    //             : Container(),
    //       ],
    //     ),
    //   );

    return Scaffold(
      backgroundColor: CommonColors.color_f3f3f3,
      body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .padding
                          .top +
                          AppBar().preferredSize.height + 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: CommonColors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return MyOrdersView();
                                  }));
                            },
                            child: getCommonRow(LocalImages.ic_your_orders,
                                S.of(context).yourorder, true),
                          ),
                          /*InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return AddressListView();
                                  }));
                            },
                            child: getCommonRow(LocalImages.ic_purchase_history,
                                "Purchase History", true),
                          ),*/
                          InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return MyListView();
                                    }));
                              },
                              child: getCommonRow(LocalImages.ic_product_list
                                  ,S.of(context).favouriteproduct, true)),
                        ],
                      ),
                    ),
                    /*Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: CommonColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mViewModel.loginDetails == null
                              ? Container()
                              : InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return MyOrdersView();
                                  }));
                            },
                            child: getCommonRow(LocalImages.ic_reviews,
                                "Reviews", true),
                          ),
                          InkWell(
                            onTap: () async {
                              kIsWeb
                                  ? await launch(
                                mViewModel.languageCode != null &&
                                    mViewModel.languageCode ==
                                        AppConstants.LANGUAGE_ENGLISH
                                    ? ApiUrl.CONTACT_US
                                    : ApiUrl.CONTACT_US_AR,
                                forceSafariVC: false,
                                forceWebView: false,
                                headers: <String, String>{
                                  'my_header_key': 'my_header_value'
                                },
                              )
                                  : Navigator.push(context,
                                  MaterialPageRoute(builder: (_context) {
                                    return WebViewPage(
                                      title: S
                                          .of(context)
                                          .contactUs,
                                      url: mViewModel.languageCode != null &&
                                          mViewModel.languageCode ==
                                              AppConstants.LANGUAGE_ENGLISH
                                          ? ApiUrl.CONTACT_US
                                          : ApiUrl.CONTACT_US_AR,
                                    );
                                  }));
                            },
                            child: getCommonRow(LocalImages.ic_notification,
                                "Notification", true),
                          ),
                          InkWell(
                              onTap: () async {
                                kIsWeb
                                    ? await launch(
                                  mViewModel.languageCode != null &&
                                      mViewModel.languageCode ==
                                          AppConstants.LANGUAGE_ENGLISH
                                      ? ApiUrl.ABOUT_US
                                      : ApiUrl.ABOUT_US_AR,
                                  forceSafariVC: false,
                                  forceWebView: false,
                                  headers: <String, String>{
                                    'my_header_key': 'my_header_value'
                                  },
                                )
                                    : Navigator.push(context,
                                    MaterialPageRoute(builder: (_context) {
                                      return WebViewPage(
                                        title: S
                                            .of(context)
                                            .aboutUs,
                                        url: mViewModel.languageCode != null &&
                                            mViewModel.languageCode ==
                                                AppConstants.LANGUAGE_ENGLISH
                                            ? ApiUrl.ABOUT_US
                                            : ApiUrl.ABOUT_US_AR,
                                      );
                                    }));
                              },
                              child: getCommonRow(LocalImages.ic_f_s,
                                  "Friends and Subscribes", true)),
                        ],
                      ),
                    ),*/
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: CommonColors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         /* InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return ProfileView();
                                  }));
                            },
                            child: Column(
                              children: [
                                ExpansionTile(
                                  backgroundColor: Colors.white,
                                  iconColor: CommonColors.black,
                                  tilePadding: EdgeInsets.zero,
                                  title:
                                    Row(
                                      children: [
                                        Container(height: 20, width: 20, child: Image.asset('assets/img/ic_outline.png')),
                                          SizedBox( width: 20,),
                                        Flexible(
                                          child: Text(
                                              'Delivery Addresses',
                                              style: CommonStyle.getAppFont(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: CommonColors.dark_grey)
                                          ),
                                        ),
                                      ],
                                    ),
                                  children: [
                                    Text(
                                      'Coffee is a brewed drink prepared from roasted coffee beans, the seeds of berries from certain Coffee species.',
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: CommonColors.color_f3f3f3,
                                  thickness: 1.0,
                                ),
                              ],
                            ),

                          ),*/
                          InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return AddressListView();
                                    }));
                              },
                              child: getCommonRow(LocalImages.ic_delivery
                                  ,S.of(context).deliveryaddress, true)),
                          /*InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return AddressListView();
                                  }));
                            },
                            child: getCommonRow(LocalImages.ic_wallet,
                                "Your Wallets", true),
                          ),*/
                          InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return ProfileView();
                                    }));
                              },
                              child: getCommonRow(LocalImages.ic_settings
                                  , S.of(context).settings, true)),

                          InkWell(
                              onTap: ()   {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return LanguageSelectionView(from: true,);
                                    }));
                              },
                              child: getCommonRow(LocalImages.ic_world
                                  , S.of(context).languagechange, true)),
                        ],
                      ),
                    ),
                                  Container(
                                    padding: EdgeInsets.only(left: 16, right: 16),
                                    decoration: BoxDecoration(
                                        color: CommonColors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(12))),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        mViewModel.loginDetails == null /*|| mViewModel.socialLog == null*/
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) {
                                                    return LoginView();
                                                  }));
                                                },
                                                child: getCommonRow(LocalImages.ic_more_logout,
                                                    S.of(context).login, true),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  mViewModel.clearSession();
                                                },
                                                child: getCommonRow(LocalImages.ic_more_logout,
                                                    S.of(context).logout, true),
                                              ),
                                        /* InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => GoogleTest()));
                                          },
                                          child: getCommonRow(LocalImages.ic_more_logout,
                                              S.of(context).login, true),
                                        )*/
                                      ],
                                    ),
                                  ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .padding
                        .top,
                  ),
                  layoutAppBar,
                ],
              ),
        ],
      )


    );
  }


  Widget getCommonRow(String icon, String title, bool divider,) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(height: 20, width: 20, child: Image.asset(icon,color: Colors.black,)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  title,
                  style: CommonStyle.getAppFont(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: CommonColors.dark_grey),
                ),
              ),

            ],
          ),
          divider
              ? Container(
            height: 1,
            color: CommonColors.color_f3f3f3,
          )
              : Container(),
        ],
      ),
    );
  }
}


