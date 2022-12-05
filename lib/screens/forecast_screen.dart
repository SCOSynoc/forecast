import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:weather_icons/weather_icons.dart';

import '../globals/constants.dart';
import '../globals/global.dart';
import '../widgets/text_widgets.dart';

class ForecastScreen extends StatefulWidget {
  final List<dynamic> forecastList;
  ForecastScreen({required this.forecastList});

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppPrimaryColor,
      body: Container(
        width: Global.getSizeWidth(context),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: Global.getSizeHeight(context),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 31,right: 31),
                  child: Container(
                    child:   Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                           onTap: () {
                             Navigator.pop(context);
                           },
                            child: Icon(CupertinoIcons.left_chevron, color: kCommonIconColor,)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: CommonTextWidget(text: "Back", wght: FontWeight.w700, size: 24, colors: Colors.white,),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 31,right: 31),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextWidget(text: "Today" , size: 24, wght: FontWeight.w900, colors: Colors.white,),
                        CommonTextWidget(text: "Sep, 12" , size: 18, wght: FontWeight.w700, colors: Colors.white,)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 53.0, left: 23, right: 23),
                  child: todayForecastList(context),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 31,right: 31),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextWidget(text: "Next Forecast" , size: 24, wght: FontWeight.w900, colors: Colors.white,),
                        Icon(CupertinoIcons.calendar, size: 20, color: Colors.white,)
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: nextForecastList(context, widget.forecastList),
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }

  Container todayForecastList(BuildContext context) {
    return Container(
                  width: Global.getSizeWidth(context),
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                    return Container(
                      height: 120,
                      width: 70,
                      child: Column(
                        children: [
                          CommonTextWidget(text: "29°C" , size: 18, wght: FontWeight.w400, colors: Colors.white,),
                          Padding(
                            padding: EdgeInsets.only(top: 32),
                            child: Icon(CupertinoIcons.cloud, size: 23,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: CommonTextWidget(text: "15.00" , size: 18, wght: FontWeight.w400, colors: Colors.white,),
                          ),
                        ],
                      ),
                    );
                  }),
                );
  }

  Container nextForecastList(BuildContext context, List<dynamic> data) {
     data.removeLast();
    return Container(
      width: Global.getSizeWidth(context),
      height: Global.getSizeHeight(context)*0.45,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: Container(
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget(text: "Sep,13" , size: 18, wght: FontWeight.w700, colors: Colors.white,),
                    BoxedIcon(Global.showIcons(data[index]["condition"]), size: 30,),
                    CommonTextWidget(text: "${data[index]["temperature"]}°" , size: 18, wght: FontWeight.w400, colors: Colors.white,),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
