import 'package:big_mart/models/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:provider/provider.dart';

import '../product_details_view_model.dart';

class WriteReviewView extends StatefulWidget {

  @override
  _WriteReviewViewState createState() => _WriteReviewViewState();
}

class _WriteReviewViewState extends State<WriteReviewView> {
  var mReviewController = new TextEditingController();
  ProductDetailsViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<ProductDetailsViewModel>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ProductDetailsViewModel>(context);


    final rateView = RatingBar(
      initialRating: 1.0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full: Icon(
          Icons.star,
          color: Colors.amber,
        ),
        half: Icon(
          Icons.star_half,
          color: Colors.amber,
        ),
        empty: Icon(
          Icons.star_border,
          color: CommonColors.color_707070,
        ),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: (rating) {
        mViewModel.rating = rating;
      },
    );

    final edReview = Container(
      margin: EdgeInsets.only(top: 24),
      height: 140,
      width: 260,
      decoration: BoxDecoration(
        color: CommonColors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: CommonColors.color_707070, width: 1),
      ),
      child: TextField(
        controller: mReviewController,
        decoration: InputDecoration(
          hintText: S.of(context).writeYourReview,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
        ),
        style: CommonStyle.getAppFont(
            color: CommonColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14.0),
        maxLines: 6,
        autocorrect: false,
      ),
    );

    final btnSubmit = Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      width: 120,
      height: 40,
      child: FlatButton(
        onPressed: () {
          CommonUtils.hideKeyboard(context);
          if (checkValidation()) {
            Navigator.pop(context);
            mViewModel.writeReviewApi(reviewText: mReviewController.text, rating: mViewModel.rating);
          }
        },
        color: Colors.orangeAccent.withOpacity(.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(11.33333)),
        ),
        textColor: Color.fromARGB(255, 255, 255, 255),
        padding: EdgeInsets.all(0),
        child: Text(
          S.of(context).submit,
          textAlign: TextAlign.left,
          style: CommonStyle.getAppFont(
            color: CommonColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[rateView, edReview, btnSubmit],
            ),
          ),
        ),
      ),
    );
  }

  bool checkValidation() {
    if (mReviewController.text.isEmpty) {
      CommonUtils.showToastMessage(S.of(context).writeYourReview);
      return false;
    } else {
      return true;
    }
  }
}
