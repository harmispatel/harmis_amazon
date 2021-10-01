import 'package:big_mart/models/category.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';

class HomeCategoryItemView extends StatelessWidget {
  int position;
  CategoryDetails category;
  final int catId;

  HomeCategoryItemView({this.position, this.category,this.catId});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: MediaQuery.of(context).size.width / 3,
    //   height: 100,
    //   margin: EdgeInsets.only(right: 16, left: position == 0 ? 16 : 0),
    //   // padding: EdgeInsets.only(bottom: 0, left: 10),
    //   decoration: BoxDecoration(
    //       color: CommonUtils.isEmpty(category.color)
    //           ? CommonColors.primaryColor
    //           : CommonColors.colorFromHex(category.color),
    //       borderRadius: BorderRadius.all(Radius.circular(10)),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.2),
    //           spreadRadius: 3,
    //           blurRadius: 5,
    //           offset: Offset(0, 1), // changes position of shadow
    //         ),
    //       ]
    // ),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Container(
    //         height: 100,
    //         width: double.infinity,
    //         child: ClipRRect(
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(10),
    //             topRight: Radius.circular(10),
    //           ),
    //           child: Image.network(
    //             category.categoriesImg.toString(),
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //       Container(
    //         height: 45,
    //         padding: const EdgeInsets.all(8),
    //         child: Center(
    //           child: Text(
    //             category.categoriesSlug.toString(),
    //             overflow: TextOverflow.ellipsis,
    //             style: CommonStyle.getAppFont(
    //                 color: CommonColors.white,
    //                 fontSize: 17,
    //                 fontWeight: FontWeight.w600),
    //           ),
    //         ),
    //       ),
    //       /*Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Flexible(
    //             child: Padding(
    //               padding: const EdgeInsets.only(left: 4, right: 4),
    //               child: Text(
    //                 category.categoriesSlug.toString(),
    //                 style: CommonStyle.getAppFont(
    //                     color: CommonColors.white,
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.w500),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: 80,
    //             child: Image.network(category.categoriesImg.toString()),
    //           )
    //         ],
    //       ),*/
    //     ],
    //   ),
    // );



    return Container(
      width: 150,
      height: 180,
      margin: EdgeInsets.only(right: 16, left: position == 0 ? 16 : 0),
    decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
      color: CommonColors.primaryAppBackground,
    ),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Container(
                   height: 100,
                   width: double.infinity,
                   child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                     child: Image.network(
                       category.categoriesImg.toString(),
                     ),
                   ),
                 ),
          Container(
            color: CommonColors.white,
                height: 45,
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    category.categoriesSlug.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: CommonStyle.getAppFont(
                        color: CommonColors.color_9f9f9f,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
        ],
       ),
    );
  }
}
