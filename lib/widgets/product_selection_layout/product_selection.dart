import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/views/product_detail/product_details_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Colorview extends StatefulWidget {
  const Colorview({Key key}) : super(key: key);

  @override
  _ColorviewState createState() => _ColorviewState();
}

class _ColorviewState extends State<Colorview> {

  ProductDetailsViewModel mViewModel;
/*  List<Color> colors =[Colors.white,CommonColors.dark_blue,CommonColors.dark_grey,CommonColors.color_9f9f9f];
  List<String> size =['XXS','XS','S','M','L','XL','XXL'];*/




  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ProductDetailsViewModel>(context);
    final availableColorText = Container(
              child: Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Text(S.of(context).colour,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: CommonColors.black),),
              ),
    );


    final availablecolor = Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      height:100,
      child: Container(
        height: 100,width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:mViewModel.productDetails.result.option.attributes[0].values.length ,
          itemBuilder: (context, i) {
            return Padding(
                padding: EdgeInsets.all(8.0),
                child: InkWell(
                  child:Container(
                    alignment: Alignment.center,
                    width: 40,
                    //color: colors[i],
                    decoration: BoxDecoration(
                        border: Border.all(color: (mViewModel.oncolorpressed==i?Colors.amber:Colors.transparent),width: 4),
                        color: mViewModel.productDetails.result.option.attributes[0].values[i].value.toColor(),
                    ),
                    /*child: Text(mViewModel.productDetails.result.option.attributes[0].values[i].value,
                    style: TextStyle(color: Colors.black,fontSize: 12),),*/
                  ),
                  onTap: (){
                    mViewModel.getColor(mViewModel.productDetails.result.option.attributes[0].values[i].price);
                    mViewModel.getvalue(mViewModel.productDetails.result.option.attributes[0].values[i].price,null);
                    setState(() {
                      mViewModel.oncolorpressed = i;
                    });
                  },
                )
            );
          },
        ),
      ),
    );

    final availableSizeText = Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Text(S.of(context).size,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: CommonColors.black),),
      ),
    );

    final availablesize = Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      height:100,
      child: Container(
        height: 100,width:
      MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:mViewModel.productDetails.result.option.attributes[1].values.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: (mViewModel.onsizepressed==index?Colors.amber:Colors.transparent),width: 4),
                  ),
                  child: InkWell(
                    child: Container(
                        width: 40,
                        color: CommonColors.color_dcdcdc,
                        child: Center(child: Text(mViewModel.productDetails.result.option.attributes[1].values[index].value, style: TextStyle(color: (mViewModel.onsizepressed==index
                            ?Colors.grey
                            :Colors.black),
                            fontSize: 12
                        ),))),
                    onTap: (){
                      mViewModel.getsize(mViewModel.productDetails.result.option.attributes[1].values[index].price);
                      mViewModel.getvalue(null,mViewModel.productDetails.result.option.attributes[1].values[index].price);
                      setState(() {
                        mViewModel.onsizepressed = index;
                      });
                    },
                  ),
                )
            );
          },
        ),
      ),
    );


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           SizedBox(height: 20,),
          availableColorText,
          availablecolor,
          availableSizeText,
          availablesize,
      ]
    );
  }

}
extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return int.parse(hexColor, radix: 16);
  }
}



