import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast/globals/constants.dart';
import 'package:forecast/screens/home_screen.dart';
import 'package:forecast/services/weather_service.dart';
import 'package:forecast/widgets/animated_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import 'content_text_container.dart';

class SearchDialog extends StatefulWidget {
  SearchDialog({Key? key, required this.dataList, required this.token}) : super(key: key);

  final List<dynamic> dataList ;
  final String token ;

  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Container(
          width: 305,
          height: 450,
          child: Column(
                children: [
                  Card(
                   /* height: 54,
                    decoration: BoxDecoration(
                      color:kDialogContainerColor,
                      borderRadius: BorderRadius.circular(15),
                    )*/
                       color: kDialogContainerColor,
                       shadowColor: Colors.grey.shade100,
                       elevation: 2.0,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                       child: TextField(
                         decoration: InputDecoration(
                           prefixIcon: Icon(Icons.arrow_back, color: searchBarIconCOlors, size: 16,),
                           hintText: "Search here",
                           hintStyle: GoogleFonts.overpass(
                             fontSize: 18.0,
                             fontWeight: FontWeight.w400
                           ),
                           border: InputBorder.none,
                           suffixIcon: Icon(CupertinoIcons.mic_solid, color:searchBarIconCOlors , size: 16,)
                         ),
                       ),
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemCount: widget.dataList.length,
                        itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async{
                                WeatherService apiService = WeatherService();
                                await apiService.getLiveWeatherdata(widget.dataList[index]["_id"], widget.token).then((value) {
                                  if(value.weatherModel == null) {
                                    /*showPopUpDialog(context: context, textTitle: "Oops...", msgText: "No data", pressed: () {
                                      Navigator.pop(context);
                                    });*/
                                    showNewDialog(context, (_,__,___) {
                                      return animatedDialog(context: context, textTitle: "Oops.", msgText:"No data", pressed: () {
                                        Navigator.pop(context);
                                      }) ;
                                    });
                                  }else{
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomeScreen(loginResponseModel: value)));
                                  }

                                }).onError((error, stackTrace) {
                                  log("the $error and $stackTrace");
                                });

                          },
                          child: ContentTextContainer(text: "${widget.dataList[index]["name"] ?? "Bangalore"}", text2: "${widget.dataList[index]["maxTemperature"] ?? "34°"} / ${widget.dataList[index]["minTemperature"] ?? "23°"}", icon: IconlyLight.location,
                            style: GoogleFonts.overpass(fontWeight: FontWeight.w400, fontSize: 18, color: searchTextColor), color: searchBarIconCOlors,),
                        ),
                      );
                    }),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
