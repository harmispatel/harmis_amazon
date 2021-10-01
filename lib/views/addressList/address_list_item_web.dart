import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/address.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';

class AddressListItemViewWeb extends StatelessWidget {
  AddressDetails addressDetails;
  Function onEditClick;

  AddressListItemViewWeb({this.addressDetails, this.onEditClick});

  @override
  Widget build(BuildContext context) {
    final tvRecevierName = Container(
      margin: EdgeInsets.only(top: 8),
      child: Text(
        addressDetails.firstName.toString(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: CommonStyle.getAppFont(
            color: CommonColors.color_515c6f,
            fontSize: 15,
            fontWeight: FontWeight.w400),
      ),
    );

    final tvMobile = Container(
      margin: EdgeInsets.only(top: 5),
      child: Text(
        addressDetails.mobile.toString(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: CommonStyle.getAppFont(
            color: CommonColors.color_515c6f,
            fontSize: 15,
            fontWeight: FontWeight.w400),
      ),
    );

    final tvBlockNumber = Container(
      margin: EdgeInsets.only(top: 5),
      child: Text(
        addressDetails.blokNumber.toString(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: CommonStyle.getAppFont(
            color: CommonColors.color_515c6f,
            fontSize: 15,
            fontWeight: FontWeight.w400),
      ),
    );

    final tvAddress = Container(
      margin: EdgeInsets.only(top: 5),
      child: Text(
        addressDetails.address.toString(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: CommonStyle.getAppFont(
            color: CommonColors.color_515c6f,
            fontSize: 15,
            fontWeight: FontWeight.w400),
      ),
    );

    final tvCity = !CommonUtils.isEmpty(addressDetails.city)
        ? Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              addressDetails.city.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CommonStyle.getAppFont(
                  color: CommonColors.color_515c6f,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          )
        : Container();

    return Container(
      margin: EdgeInsets.only(right: 12, left: 12, top: 12),
      padding: EdgeInsets.only(bottom: 12, left: 10, top: 8, right: 20),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Container(
            margin: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                tvRecevierName,
                tvMobile,
                tvBlockNumber,
                tvAddress,
                tvCity,
              ],
            ),
          )),
          Column(
            children: [
              addressDetails.isSelected
                  ? Icon(
                      Icons.done,
                      color: CommonColors.primaryColor,
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 40,
                decoration: BoxDecoration(
                  color: CommonColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: CommonColors.white,
                        ),
                        onPressed: () {
                          onEditClick();
                        }),
                    Text(
                      S.of(context).editAddress.toUpperCase(),
                      style: CommonStyle.getAppFont(
                          color: CommonColors.white,
                          fontSize: 13,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
