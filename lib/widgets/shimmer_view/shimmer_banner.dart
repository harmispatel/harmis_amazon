import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF656565).withOpacity(0.15),
              blurRadius: 2.0,
              spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
            )
          ]),
      child: Wrap(
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: Colors.black38,
            highlightColor: Colors.white,
            child: Container(
              color: Colors.black12,
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
