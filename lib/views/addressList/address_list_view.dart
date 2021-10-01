import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/address.dart';
import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/addAddress/add_address_view.dart';
import 'package:big_mart/views/checkout/checkout_view.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_cart_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'address_list_item.dart';
import 'address_list_view_model.dart';

class AddressListView extends StatefulWidget {
  List<CartDetails> cartList;
  String totalPrice;
  String orderId;

  AddressListView({this.cartList, this.totalPrice, this.orderId});

  @override
  _AddressListViewState createState() => _AddressListViewState();
}

class _AddressListViewState extends State<AddressListView> {
  final globalKey = new GlobalKey();
  AddressListViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<AddressListViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getAddressList();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AddressListViewModel>(context);

    final layoutAddAddress = Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext bc) {
                    return AddAddressView();
                  }).then((value) {
                if (value != null && value) {
                  mViewModel.getAddressList();
                }
              });
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Center(
                child: Text(
                  S.of(context).addNewAddress.toUpperCase(),
                  style: CommonStyle.getAppFont(
                      color: CommonColors.white,
                      fontSize: 13,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final layoutBottom = Container(
      padding: EdgeInsets.all(20),
      color: CommonColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              if (mViewModel.selectedAddress == null) {
                CommonUtils.showSnackBar(
                    S.of(context).pleaseSelectAddress, globalKey);
              } else {
                /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CheckoutView(
                    cartList: widget.cartList,
                    totalPrice: widget.totalPrice,
                   *//* addressDetails: mViewModel.selectedAddress,*//*
                    orderId: widget.orderId,
                  );
                }));*/
                AddressDetails selectedData =  mViewModel.selectedAddress;
                Navigator.pop(context,selectedData);
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orangeAccent.withOpacity(.9),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Center(
                child: Text(
                  S.of(context).done.toUpperCase(),
                  style: CommonStyle.getAppFont(
                      color: CommonColors.white,
                      fontSize: 18,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );

  /*  return Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  height: 15,
                  child: Image.asset(
                    LocalImages.ic_arrow_back,
                    color: CommonColors.white,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 75, right: 10),
                  child: Text(
                    S.of(context).address,
                    style: CommonStyle.getAppFont(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: CommonColors.white),
                  ),
                ),
              ),
              // Spacer(),
              *//* IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext bc) {
                        return AddAddressView();
                      }).then((value) {
                    if (value != null && value) {
                      mViewModel.getAddressList();
                    }
                  });
                },
                icon: Container(
                  height: 15,
                  child: Icon(Icons.add_box),
                ),
              ),*//*
            ],
          ),
        ),
        actions: [
         *//* IconButton(
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext bc) {
                    return AddAddressView();
                  }).then((value) {
                if (value != null && value) {
                  mViewModel.getAddressList();
                }
              });
            },
            icon: Container(
              height: 15,
              child: Icon(Icons.add_box),
            ),
          ),*//*
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: mViewModel.isApiLoading
                  ? ShimmerCartList()
                  : mViewModel.addressList.length > 0
                      ? Container(
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 10, bottom: 20),
                              shrinkWrap: true,
                              itemCount: mViewModel.addressList.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return InkWell(
                                  onTap: () {
                                    for (int i = 0;
                                        i < mViewModel.addressList.length;
                                        i++) {
                                      mViewModel.addressList[i].isSelected =
                                          false;
                                    }
                                    mViewModel.addressList[index].isSelected =
                                        true;
                                    mViewModel.selectedAddress =
                                        mViewModel.addressList[index];
                                    mViewModel.notifyListeners();
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
                                          color: Colors.orangeAccent,
                                          icon: Icons.delete,
                                          onTap: () {
                                            mViewModel.removeAddress(
                                                addressId: mViewModel
                                                    .addressList[index]
                                                    .addressId
                                                    .toString(),
                                                context: context);
                                          },
                                        ),
                                      ],
                                      child: AddressListItemView(
                                        addressDetails:
                                            mViewModel.addressList[index],
                                        onEditClick: () {
                                          showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext bc) {
                                                return AddAddressView(
                                                  addressDetails: mViewModel
                                                      .addressList[index],
                                                );
                                              }).then((value) {
                                            if (value != null && value) {
                                              mViewModel.getAddressList();
                                            }
                                          });
                                        },
                                      )),
                                );
                              }),
                        )
                      : layoutAddAddress,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: widget.cartList != null && mViewModel.addressList.length > 0
                ? layoutBottom
                : Container(),
          ),
        ],
      ),
    );*/

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                 /* if (mViewModel.selectedAddress == null) {
                    CommonUtils.showSnackBar(
                        S.of(context).pleaseSelectAddress, globalKey);
                  } else {
                    String selectedData =  mViewModel.selectedAddress.address;
                    Navigator.pop(context,selectedData);
                  }*/
                },
                icon: Container(
                  height: 15,
                  child: Image.asset(
                    LocalImages.ic_arrow_back,
                    color: CommonColors.white,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 75, right: 100),
                  child: Text(
                    S.of(context).address,
                    style: CommonStyle.getAppFont(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: CommonColors.white),
                  ),
                ),
              ),
              // Spacer(),
               /*IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext bc) {
                        return AddAddressView();
                      }).then((value) {
                    if (value != null && value) {
                      mViewModel.getAddressList();
                    }
                  });
                },
                icon: Container(
                  height: 15,
                  child: Icon(Icons.add_box),
                ),
              ),*/
            ],
          ),
        ),
        actions: [
          /* IconButton(
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext bc) {
                    return AddAddressView();
                  }).then((value) {
                if (value != null && value) {
                  mViewModel.getAddressList();
                }
              });
            },
            icon: Container(
              height: 15,
              child: Icon(Icons.add_box),
            ),
          ),*/
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
            Container(
              child: mViewModel.isApiLoading
                  ? ShimmerCartList()
                  : mViewModel.addressList.length > 0
                  ? Container(
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    shrinkWrap: true,
                    itemCount: mViewModel.addressList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                        onTap: () {
                          for (int i = 0;
                          i < mViewModel.addressList.length;
                          i++) {
                            mViewModel.addressList[i].isSelected =
                            false;
                          }
                          mViewModel.addressList[index].isSelected =
                          true;
                          mViewModel.selectedAddress =
                          mViewModel.addressList[index];
                          mViewModel.notifyListeners();
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
                                color: Colors.orangeAccent,
                                icon: Icons.delete,
                                onTap: () {
                                  mViewModel.removeAddress(
                                      addressId: mViewModel
                                          .addressList[index]
                                          .addressId
                                          .toString(),
                                      context: context);
                                },
                              ),
                            ],
                            child: AddressListItemView(
                              addressDetails:
                              mViewModel.addressList[index],
                              onEditClick: () {
                                showModalBottomSheet(
                                    backgroundColor:
                                    Colors.transparent,
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext bc) {
                                      return AddAddressView(
                                        addressDetails: mViewModel
                                            .addressList[index],
                                      );
                                    }).then((value) {
                                  if (value != null && value) {
                                    mViewModel.getAddressList();
                                  }
                                });
                              },
                            )),
                      );
                    }),
              )
                  : layoutAddAddress,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: /*widget.cartList != null &&*/ mViewModel.addressList.length > 0
                ? layoutBottom
                : Container(),
          ),
        ],
      ),
    );
  }
}
