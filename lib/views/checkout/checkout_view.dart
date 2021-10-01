import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/address.dart';
import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/models/product_details.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/services/api_url.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/addAddress/add_address_view.dart';
import 'package:big_mart/views/addressList/address_list_view.dart';
import 'package:big_mart/views/addressList/address_list_view_model.dart';
import 'package:big_mart/views/checkout/checkout_item.dart';
import 'package:big_mart/views/home/home_view.dart';
import 'package:big_mart/views/my_orders/my_orders_view.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_cart_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'checkout_view_model.dart';

class CheckoutView extends StatefulWidget {
  List<CartDetails> cartList;
  String totalPrice;
  /*AddressDetails addressDetails;*/
  String orderId;
  // List<AddressDetails> addressList = new List();
  // AddressDetails addressDetails;



  CheckoutView(
      {this.cartList, this.totalPrice,/* this.addressDetails,*/ this.orderId,/*this.addressDetails*/});

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final globalKey = new GlobalKey();
  CheckoutViewModel mViewModel;

  int selectedIndex = 0;

  List<String> cash = ["Cash On Delivery"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<CheckoutViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getAddressList();
    });
  }


  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CheckoutViewModel>(context);
    final layoutCartList = Container(
      child: widget.cartList.length > 0
          ? Container(
        child: ListView.builder(
            padding: EdgeInsets.only(top: 10, bottom: 13),
            shrinkWrap: true,
            itemCount: widget.cartList.length,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext ctxt, int index) {
              return CheckoutItemView(
                cartDetails: widget.cartList[index],
              );
            }),
      )
          : Container(),
    );

    /*final deliveryAddress = Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: 12, left: 12, top: 12),
      padding: EdgeInsets.only(bottom: 12, left: 12, top: 12, right: 12),
      decoration: BoxDecoration(
          color: CommonColors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).deliveryAddress,
            style: CommonStyle.getAppFont(
                color: CommonColors.color_515c6f,
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            widget.addressDetails.firstName.toString(),
            style: CommonStyle.getAppFont(
                color: CommonColors.color_96979d,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.addressDetails.mobile.toString(),
            style: CommonStyle.getAppFont(
                color: CommonColors.color_96979d,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.addressDetails.address.toString() +
                ", " +
                widget.addressDetails.area.toString() +
                ", " +
                widget.addressDetails.city.toString(),
            style: CommonStyle.getAppFont(
                color: CommonColors.color_96979d,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          CommonUtils.isEmpty(widget.addressDetails.landmark)
              ? Container()
              : Text(
                  widget.addressDetails.landmark,
                  style: CommonStyle.getAppFont(
                      color: CommonColors.color_96979d,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
        ],
      ),
    );*/

    // final layoutBottom = widget.cartList.length > 0
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
    //                             widget.cartList.length.toString() +
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
    //                     widget.totalPrice.toString() + " IQ",
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
    //                 if (widget.orderId == null) {
    //                   mViewModel.placeOrder(
    //                       addressId:
    //                           widget.addressDetails.addressId.toString());
    //                 } else {
    //                   mViewModel.buyAgain(
    //                       orderId: widget.orderId.toString(),
    //                       addressId:
    //                           widget.addressDetails.addressId.toString());
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
    //                     S.of(context).sendOrder.toUpperCase(),
    //                     style: CommonStyle.getAppFont(
    //                         color: CommonColors.white,
    //                         fontSize: 18,
    //                         letterSpacing: 1,
    //                         fontWeight: FontWeight.w500),
    //                   ),
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       )
    //     : Container();

    final payButton = widget.cartList.length > 0
        ? Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              if (mViewModel.addressList.length==0) {
                CommonUtils.showSnackBar(
                    S.of(context).pleaseSelectAddress, globalKey);
              }
              else{
                _popupDialog(context);
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Center(
                child: Text("Pay",
                  style: TextStyle(
                      color: CommonColors.white,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    )
        : Container();

    final pay = Container(
      padding: EdgeInsets.all(20),
      child: InkWell(
        onTap: (){
          if (mViewModel.currentAddressId != null) {
            _popupDialog(context);
          }
          else{
            CommonUtils.showSnackBar(
                S.of(context).pleaseSelectAddress, globalKey);
          }
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.orangeAccent.withOpacity(.9),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Center(
            child: Text(S.of(context).pay,
              style: TextStyle(
                  color: CommonColors.white,
                  fontSize: 20,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );


    final bottomLayout = Container(
      // decoration: BoxDecoration( borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0),bottomLeft: Radius.circular(20.0)),),
      padding: EdgeInsets.only(left: 20,right: 20,top: 5 ),
      child: Column(
        children: [
          /*Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).deliverydate,
                  style: TextStyle(color: Colors.grey, fontSize: 17),),
                Text("October,01,2021",
                  style: TextStyle(fontSize: 18, color: CommonColors.blue_3c),),
              ],
            ),
          ),*/
         /* SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).delivery,
                  style: TextStyle(color: Colors.grey, fontSize: 17),),
                Text("0.00",
                  style: TextStyle(fontSize: 18, color: CommonColors.blue_3c),),
              ],
            ),
          ),*/

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).totalprice, style: TextStyle(
                    color: CommonColors.blue_3c,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                ),
                Text(widget.totalPrice.toString(), style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CommonColors.black_23),),
              ],
            ),
          ),
        ],
      ),
    );

    final delAdd = Container(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15,right:15,top: 20),
              child: Icon(Icons.my_location),
            ),
            Padding(
              padding: EdgeInsets.only(top: 18),
              child: Text(S.of(context).deliveryaddress + "*",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            ),
            Padding(
                padding: EdgeInsets.only(left: 50,right:50 ,top: 22),
                child:InkWell(
                    onTap: () async{
                      AddressDetails currentAddress = await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressListView()));
                        if(currentAddress!=null){
                          print("Current Address"+currentAddress.toString());
                          mViewModel.currentAddress = currentAddress.address;
                          mViewModel.currentAddressId = currentAddress.addressId.toString();
                          mViewModel.notifyListeners();
                        }
                      },
                    child:Text(mViewModel.currentAddress != null?S.of(context).change:S.of(context).Select,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600,color: Colors.black54))
            )
            )

          ],
        )
    );

    final payMethod = Container(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15,right:17,top: 25),
              child: Icon(Icons.payment),
            ),
            Padding(
              padding: EdgeInsets.only(top: 22),
              child: Text(S.of(context).paymentmethod+"*",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            )

          ],
        )
    );

   /* final addressList = mViewModel.isApiLoading
        ? //ShimmerCartList()
         Center(
             child: SpinKitRing(color: Colors.orangeAccent.withOpacity(.9),lineWidth: 4,))
        : mViewModel.addressList.length>0?
    Container(
      height: 300,
      margin: EdgeInsets.only(top: 5, right: 20, left: 20),
      child: ListView.builder(
        itemCount: mViewModel.addressList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 60,
            child: Card(
              child: ListTile(
                tileColor: Colors.white,
                title: Text(
                  mViewModel.addressList[index].address.toString(),overflow: TextOverflow.fade,maxLines: 2,softWrap: false, style: TextStyle(color: (_selectedIndex == index
                    ? Colors.black
                    : Colors.grey),fontSize: 15),),
                trailing: Icon(_selectedIndex == index
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                  color: Colors.orangeAccent,),
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          );
        },
      ),
    )
        :Container(
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.grey// changes position of shadow
            ),
          ],
        ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.of(context).addAddress,style: TextStyle(color:CommonColors.dark_6060,fontSize: 15),),
            IconButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>AddAddressView())).then((value) {
                  if(value!=null){
                    mViewModel.getAddressList();
                  }
                });
              },
              icon: Container(
                height: 35,
                child: Icon(
                  Icons.add,
                  color: CommonColors.dark_6060,
                ),
              ),
            ),

          ],
        ),
      ),
    );*/

    final addressList =
      /*  ? //ShimmerCartist()
    Center(
        child: SpinKitRing(color: Colors.orangeAccent.withOpacity(.9),lineWidth: 4,))
        : mViewModel.addressList.length>0?*/
    mViewModel.currentAddress!=null?
    Container(
      // height: 100,
      margin: EdgeInsets.only(top: 18, right: 20, left: 20),
      child: ListView.builder(
        itemCount:1,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // height: 60,
            child: Card(
              elevation: 1,
              child: ListTile(
                tileColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(mViewModel.currentAddress.toString(), style: TextStyle(color: Colors.black),),
                ),
                trailing: Icon(selectedIndex == index
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                  color: Colors.orangeAccent,),
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          );
        },
      ),
    ):Container();


    final cardView = Padding(
      padding: EdgeInsets.all(12),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CommonColors.dark_6060
        ),
        child: Container(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        child: Image.asset(LocalImages.ic_world),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Text(S.of(context).worldbank, style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16
                        ),),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        child: Image.asset(LocalImages.ic_master),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Row(
                  children: [
                    Text("1234 5678 7890 1234", style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,))
                  ],
                ),),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).cardholder, style: TextStyle(color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.normal,)),
                    Text(S.of(context).expired, style: TextStyle(color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.normal,))
                  ],
                ),),
              Padding(
                padding: EdgeInsets.only(top: 5, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).alexenderhomiakov, style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.normal,)),
                    Text("11/3", style: TextStyle(color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.normal,))
                  ],
                ),)
            ],
          ),
        ),
      ),
    );


    final cashOnDelivery = Container(
      // height: 100,
      padding: EdgeInsets.only(left: 15,right: 15),
      child: ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 60,
           child:ListTile(
                tileColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(/*cash[index]*/S.of(context).cashcheck, style: TextStyle(color: Colors.black),),
                ),
                trailing: Icon(selectedIndex == index
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                  color: Colors.orangeAccent,),
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
          );
        },
      ),
    );


    // final mBody = SingleChildScrollView(
    //   padding: EdgeInsets.only(bottom: 140),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [layoutCartList, deliveryAddress],
    //   ),
    // );

    final mBody = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        delAdd,
        addressList,
        payMethod,
        SizedBox(height: 10,),
        cardView,
      ],
    );

    return Scaffold(
        key: globalKey,
        backgroundColor: CommonColors.darkk,
        appBar: AppBar(
          backgroundColor: CommonColors.dark_6060,
          elevation: 0.0,
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          title: Container(
            padding: EdgeInsets.only(left: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    height: 18,
                    child: Image.asset(
                      LocalImages.ic_arrow_back,
                      color: CommonColors.white,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 14),
                    child: Text(S.of(context).checkout,
                      style: CommonStyle.getAppFont(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: CommonColors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10,left: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>AddAddressView())).then((value) {
                        if(value!=null){
                          mViewModel.getAddressList();
                        }
                      });
                                         /*showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext bc) {
                            return AddAddressView();
                          }).then((value) {
                        if (value != null && value) {
                          AmViewModel.getAddressList();
                        }
                      });*/
                    },
                    icon: Container(
                      margin: EdgeInsets.only(right: 20,left: 20),
                      height: 35,
                      child: Icon(
                        Icons.add,
                        color: CommonColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: mViewModel.isApiLoading
            ? Center(
            child: SpinKitRing(color: Colors.orangeAccent.withOpacity(.9),lineWidth: 4,))
        :SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0)),
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                          blurRadius: 1,
                          color: Colors.grey
                      )
                      ]
                  ),
                  child: SingleChildScrollView(
                    child:
                    Column(
                      children: [
                        mBody,
                        cashOnDelivery,
                        bottomLayout
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.only(top: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:pay
                  ),
                )
              ],
            )
        )
    );
  }

  void _popupDialog(BuildContext context) {
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
                        /*Navigator.of(context)
                            .pushNamedAndRemoveUntil('/bottomNavigationBar', (Route<dynamic> route) => false);*/
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
                       /*  Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return MyOrdersView();
                              })).then((value) =>*/
                             mViewModel.placeOrder(
                                 addressId:mViewModel.currentAddressId);
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
    }

}


