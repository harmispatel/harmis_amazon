import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext buildContext, int index) {
            return _LoadingItem();
          }),
    );
  }
}

class _LoadingItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: () {},
        child: Container(
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
          child: Shimmer.fromColors(
            baseColor: Colors.black38,
            highlightColor: Colors.white,
            child: Container(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 120.0,
                    width: 120.0,
                    color: Colors.black12,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 20.0),
                      child: Container(
                        height: 9.5,
                        width: 140.0,
                        color: Colors.black12,
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 10.0),
                      child: Container(
                        height: 9.5,
                        width: 140.0,
                        color: Colors.black12,
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 10.0),
                      child: Container(
                        height: 9.5,
                        width: 140.0,
                        color: Colors.black12,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
