import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/addressList/address_list_view.dart';
import 'package:big_mart/views/addressList/address_list_view_web.dart';
import 'package:big_mart/views/cart/cart_list_item.dart';
import 'package:big_mart/views/checkout/checkout_view.dart';
import 'package:big_mart/views/login/login_view.dart';
import 'package:big_mart/views/my_orders/my_orders_view.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:big_mart/widgets/no_data_widget.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_cart_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'cart_list_view_model.dart';

class CartListView extends StatefulWidget {
  @override
  _CartListViewState createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  final globalKey = new GlobalKey();
  CartListViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<CartListViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CartListViewModel>(context);

    final layoutCartList = Container(
      child: mViewModel.isApiLoading
          ? ShimmerCartList()
          : mViewModel.cartList.length > 0
              ? Container(
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 10, bottom: 140),
                      shrinkWrap: true,
                      itemCount: mViewModel.cartList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return InkWell(
                          onTap: () {
                            /*Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(seconds: 1),
                            pageBuilder: (_, __, ___) =>
                                ProductDetailsView(productId: mViewModel.cartList[index].prouductId.toString())));*/
                          },
                          child: Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.25,
                              actions: <Widget>[
//                          new IconSlideAction(
//                            caption: S.of(context).cartArchiveText,
//                            color: Colors.blue,
//                            icon: Icons.archive,
//                            onTap: () {
//                              ///
//                              /// SnackBar show if cart Archive
//                              ///
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                content: Text(S.of(context).cartArchice),
//                                duration: Duration(seconds: 2),
//                                backgroundColor: Colors.blue,
//                              ));
//                            },
//                          ),
                              ],
                              secondaryActions: <Widget>[
                                new IconSlideAction(
                                  key: Key(index.toString()),
                                  caption: S.of(context).delete,
                                  color: Colors.red,
                                  icon: Icons.delete,foregroundColor: Colors.white,
                                  onTap: () {
                                    mViewModel.addRemoveCartQuantity(
                                      index: index,
                                      action: 0,
                                    );
                                  },
                                ),
                              ],
                              child: CartListItemView(
                                position: index,
                                cartDetails: mViewModel.cartList[index],
                                onAddQuantity: () {
                                  mViewModel.addRemoveCartQuantity(
                                    index: index,
                                    action: 1,
                                  );
                                },
                                onRemoveQuantity: () {
                                  mViewModel.addRemoveCartQuantity(
                                    index: index,
                                    action: -1,
                                  );
                                },
                                onDelete: () {
                                  mViewModel.addRemoveCartQuantity(
                                    index: index,
                                    action: 0,
                                  );
                                },
                              )),
                        );
                      }),
                )
              : NoDataWidget(message: mViewModel.message),
    );

    // final layoutBottom = mViewModel.cartList.length > 0
    //     ? Container(
    //         padding: EdgeInsets.all(20),
    //         color: CommonColors.white,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Container(
    //               padding: EdgeInsets.only(bottom: 16),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Row(
    //                     children: [
    //                       Text(
    //                         S.of(context).subTotal,
    //                         style: CommonStyle.getAppFont(
    //                             color: CommonColors.color_515c6f,
    //                             fontSize: 15,
    //                             fontWeight: FontWeight.w500),
    //                       ),
    //                       Text(
    //                         "(" +
    //                             mViewModel.cartList.length.toString() +
    //                             " " +
    //                             S.of(context).items +
    //                             ")",
    //                         style: CommonStyle.getAppFont(
    //                             color: CommonColors.color_515c6f,
    //                             fontSize: 15,
    //                             fontWeight: FontWeight.w500),
    //                       ),
    //                     ],
    //                   ),
    //                   Text(
    //                     mViewModel.totalPrice.toString() + " IQ",
    //                     style: CommonStyle.getAppFont(
    //                         color: CommonColors.color_515c6f,
    //                         fontSize: 15,
    //                         fontWeight: FontWeight.w500),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             InkWell(
    //               onTap: () {
    //                 if (mViewModel.loginDetails != null) {
    //                   kIsWeb
    //                       ? Navigator.push(context,
    //                           MaterialPageRoute(builder: (context) {
    //                           return AddressListViewWeb(
    //                             cartList: mViewModel.cartList,
    //                             totalPrice: mViewModel.totalPrice.toString(),
    //                           );
    //                         }))
    //                       : Navigator.push(context,
    //                           MaterialPageRoute(builder: (context) {
    //                           return AddressListView(
    //                             cartList: mViewModel.cartList,
    //                             totalPrice: mViewModel.totalPrice.toString(),
    //                           );
    //                         }));
    //                 } else {
    //                   Navigator.push(context,
    //                       MaterialPageRoute(builder: (context) {
    //                     return LoginView();
    //                   }));
    //                 }
    //               },
    //               child: Container(
    //                 height: 50,
    //                 decoration: BoxDecoration(
    //                   color: Colors.orangeAccent,
    //                   borderRadius: BorderRadius.all(Radius.circular(4)),
    //                 ),
    //                 child: Center(
    //                   child: Text(
    //                     "Check Out",
    //                     style: CommonStyle.getAppFont(
    //                         color: CommonColors.white,
    //                         fontSize: 20,
    //                         letterSpacing: 1,
    //                         fontWeight: FontWeight.w700),
    //                   ),
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       )
    //     : Container();


    final goods = mViewModel.cartList.length > 0
    ?Container(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).goods,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                  ),
                ),
                Text("\$" + mViewModel.totalPrice.toString(),
                  style: TextStyle(
                    color: CommonColors.color_707070,
                    fontSize: 18,
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*Text("Delivery:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                  ),
                ),*/
                /*Text("0.00",
                  style: TextStyle(
                    color: CommonColors.color_707070,
                    fontSize: 18,
                  ),
                )*/
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).totalprice,
                  style: TextStyle(
                    color: CommonColors.black,
                    fontSize: 20,
                  ),
                ),
                Text("\$" + mViewModel.totalPrice.toString(),
                  style: TextStyle(
                    color: CommonColors.black,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            InkWell(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent.withOpacity(.9),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Center(
                  child: Text(
                    S.of(context).checkout,
                    style: CommonStyle.getAppFont(
                        color: CommonColors.white,
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              onTap: (){
                if (mViewModel.loginDetails != null) {
                      kIsWeb
                          ? Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                              return AddressListViewWeb(
                                cartList: mViewModel.cartList,
                                totalPrice: mViewModel.totalPrice.toString(),
                              );
                            }))
                          : /*_popupDialog(context);*/
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return
                        CheckoutView(
                          cartList: mViewModel.cartList,
                          totalPrice: mViewModel.totalPrice,
                         orderId: '1',
                        );
                          }));
                    }
                else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginView();
                      }));
                    }
                  },
            )
          ],
        ),
      )
    )
        :Container();

    // return Scaffold(
    //   key: globalKey,
    //   backgroundColor: CommonColors.white,
    //   appBar: AppBar(
    //     backgroundColor: CommonColors.primaryColor,
    //     elevation: 0.0,
    //     titleSpacing: 0.0,
    //     automaticallyImplyLeading: false,
    //     title: Container(
    //       padding: EdgeInsets.only(left: 4),
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: <Widget>[
    //           /*IconButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             icon: Container(
    //               height: 15,
    //               child: Image.asset(LocalImages.ic_arrow_back, color: CommonColors.white,),
    //             ),
    //           ),*/
    //           Flexible(
    //             child: Padding(
    //               padding: const EdgeInsets.only(left: 14, right: 10),
    //               child: Text(
    //                 S.of(context).cart,
    //                 style: CommonStyle.getAppFont(
    //                     fontSize: 22,
    //                     fontWeight: FontWeight.w500,
    //                     color: CommonColors.white),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     actions: [
    //       Container(
    //         alignment: Alignment.center,
    //         padding: const EdgeInsets.only(left: 10, right: 10),
    //         child: Text(
    //           S.of(context).selectItems,
    //           style: CommonStyle.getAppFont(
    //               fontSize: 18,
    //               fontWeight: FontWeight.w500,
    //               color: CommonColors.white),
    //         ),
    //       ),
    //     ],
    //   ),
    //   body: Column(
    //     children: [
    //       Expanded(child: layoutCartList),
    //       layoutBottom
    //       /*Align(
    //         alignment: Alignment.bottomCenter,
    //         child: layoutBottom,
    //       )*/
    //     ],
    //   ),
    // );

    return Scaffold(
      key: globalKey,
      backgroundColor: CommonColors.white,
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 0.0,
        backgroundColor: CommonColors.dark_6060,
        automaticallyImplyLeading: false,
        title: Container(
          //padding: EdgeInsets.only(left: 4),
          child:  Row(
            children: [
              IconButton(
                onPressed: () {
                  Provider.of<BottomNavBarViewModel>(context,listen: false).changeTab(0);
                },
                icon: Container(
                  height: 18,
                  child: Image.asset(
                    LocalImages.ic_arrow_back,
                    color: CommonColors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 75,right: 100),
                child: Text(S.of(context).yourcart,textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                    ),),
              ),
            ],
          )

        ),
        actions: [
         /* Container(
            // alignment: Alignment.center,
            // padding: const EdgeInsets.only(left: 10, right: 10),
            child: IconButton(
                onPressed: (){

                  },
                icon: Icon(Icons.delete_outline,color: Colors.white,size: 25,))
          ),*/
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: layoutCartList),
          goods
          /*Align(
            alignment: Alignment.bottomCenter,
            child: layoutBottom,
          )*/
        ],
      ),
    );
  }

  /*void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius:
            BorderRadius.all(Radius.circular(18))),
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(LocalImages.ic_dialog,height: 160,width: 160,),
                      SizedBox(height: 2,),
                      Text(S.of(context).success,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(S.of(context).yours,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14),textAlign: TextAlign.center,),
                      ),
                      InkWell(
                        onTap: (){
                          *//*Navigator.of(context)
                            .pushNamedAndRemoveUntil('/bottomNavigationBar', (Route<dynamic> route) => false);*//*
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                builder: (context) => bottomNavigationBar(),
                              ), (route) => false);
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width - 150,
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Center(
                            child: Text(S.of(context).cont,
                              style: TextStyle(
                                  color: CommonColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return MyOrdersView();
                                  }));
                              },
                            child: Text(S.of(context).gotoorders,
                              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 18),)),
                      ),
                    ],
                  )
              )
            ],
          );
        });
  }*/
}

