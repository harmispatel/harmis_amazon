import 'dart:async';

import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/country_master.dart';

class ChooseCountryDialog extends StatefulWidget {
  String title;
  List<CountryDetails> countryList;
  Function onCountrySelected;

  ChooseCountryDialog({this.title, this.countryList, this.onCountrySelected});

  @override
  _ChooseCountryDialogState createState() => _ChooseCountryDialogState();
}

class _ChooseCountryDialogState extends State<ChooseCountryDialog> {
  List<CountryDetails> _filteredCountries = new List();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _filteredCountries.clear();
        _filteredCountries.addAll(widget.countryList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    final ivClose = InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.all(8),
        child: Icon(
          Icons.cancel,
          color: Colors.black,
        ),
      ),
    );

    final tvTitle = Container(
      margin: EdgeInsets.only(top: 16),
      child: Text(
        widget.title.toString(),
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );

    final searchView = Container(
      margin: EdgeInsets.only(bottom: 8, left: 8, right: 8, top: 12),
      child: TextField(
        cursorColor: Colors.black87,
        decoration: InputDecoration(
            labelText: S.of(context).search,
            contentPadding: EdgeInsets.only(left: 5)),
        onChanged: (String value) {
          print(value.toString());
          _filteredCountries.clear();
          if (value.isEmpty) {
            _filteredCountries.addAll(widget.countryList);
          } else {
            for (CountryDetails country in widget.countryList) {
              if (country.countryName
                      .toLowerCase()
                      .contains(value.toLowerCase()) ||
                  country.countyCode.toString().contains(value.toLowerCase())) {
                _filteredCountries.add(country);
              }
            }
          }
          setState(() {});
        },
      ),
    );

    final mBody = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.2,
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          tvTitle,
          searchView,
          Expanded(
            child: _filteredCountries != null && _filteredCountries.length > 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredCountries.length,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                        onTap: () {
                          widget.onCountrySelected(_filteredCountries[index]);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 8, bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 20, width: 20,
                                margin: EdgeInsets.only(right: 6),
                                child: Image.network(_filteredCountries[index].countryImg.toString()),
                              ),
                              Flexible(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50,
                                      child: Text(
                                        "+" + _filteredCountries[index].countyCode.toString(),
                                        style: CommonStyle.getAppFont(
                                            color: Colors.black87,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          _filteredCountries[index].countryName.toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : Container(),
          ),
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.all(16),
      child: Center(child: mBody),
    );

    /*return Center(
      child: mBody,
    );*/
  }
}
