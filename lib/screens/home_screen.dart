import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast/globals/constants.dart';
import 'package:forecast/globals/string_extensions.dart';
import 'package:forecast/models/user_register_model.dart';
import 'package:forecast/screens/forecast_screen.dart';
import 'package:forecast/services/weather_service.dart';
import 'package:forecast/widgets/DialogContainer.dart';
import 'package:forecast/widgets/auth_button.dart';
import 'package:forecast/widgets/search_dialog.dart';
import 'package:forecast/widgets/text_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather_icons/weather_icons.dart';

import '../globals/global.dart';
import '../progress_hud.dart';
import '../widgets/content_text_container.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key, required this.loginResponseModel}) : super(key: key);
  final LoginResponseModel loginResponseModel;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  List<dynamic> citiesList = [];
  bool _isLoading = true;

  void getCityList() async {
    WeatherService apiService = WeatherService();
    await apiService.getCityData(widget.loginResponseModel.token).then((value) {
      log("here city list is ${value["list"]}");
        setState(() {

          citiesList = value["list"];
          _isLoading = false;
        });
    }).onError((error, stackTrace) {
      log("here i am in an error with $error and $stackTrace");
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(key: const Key('profile_screen_progress_hud'), child: Uisetup(context), inAsyncCall:_isLoading );
  }

  @override
  void initState() {
    getCityList();
    super.initState();
  }


  @override
  Widget Uisetup(BuildContext context) {
    List<Map<String, dynamic>> contentList = [
      {"text": "time","value":widget.loginResponseModel.weatherModel!.time ?? ""},
      {"text": "temperature","value":"${widget.loginResponseModel.weatherModel!.temperature ?? ""}°C"},
      {"text": "maxTemperature","value":"${widget.loginResponseModel.weatherModel!.maxTemperature ?? ""}°C"},
      {"text": "minTemperature","value":"${widget.loginResponseModel.weatherModel!.minTemperature ?? " "}°C"},
      {"text": "condition","value":widget.loginResponseModel.weatherModel!.condition ?? ""},
      {"text": "windSpeed","value":"${widget.loginResponseModel.weatherModel!.windSpeed ?? ""}km/h"},
      {"text": "humidity","value":"${widget.loginResponseModel.weatherModel!.humidity ?? " "}%" },
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kAppPrimaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: Global.getSizeWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50, left: 31,right: 31),
                child: InkWell(
                  onTap: () {
                    showGeneralDialog(context: context, pageBuilder: (_,__,___) {
                      log("here token is ${widget.loginResponseModel.token}");
                      return SearchDialog(dataList: citiesList, token: widget.loginResponseModel.token,);
                    });
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(IconlyLight.location, color: kCommonIconColor,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: CommonTextWidget(text: "Semrang", wght: FontWeight.w700, size: 24, colors: Colors.white,),
                            ),
                            Icon(CupertinoIcons.chevron_down, color: kCommonIconColor, size: 12,),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  showDialog(context: context, builder: (context) {
                                    return  Dialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                        child: DialogContainer());
                                  });
                                },
                                child: Icon(CupertinoIcons.power, color: kSignOutColor,)),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),

              Container(
                child: BoxedIcon(Global.showIcons(contentList[4]["value"]), size: 200,),
              ),

              Container(
                width: 356,
                height: 503,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kHomeContainerColor.withOpacity(0.30)
                ),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 17, left: 86, right: 86),
                            child: CommonTextWidget(text: "Today, 12 September", size: 18, wght: FontWeight.w400, colors: kHomeContainerColor ,),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 21),
                            child: Text("${widget.loginResponseModel.weatherModel!.temperature}°",style: GoogleFonts.overpass(fontSize: 100, fontWeight: FontWeight.w400, color: kHomeContainerColor)),
                          ),
                          Container(
                              alignment: Alignment.center,
                              child: Text("${widget.loginResponseModel.weatherModel!.condition}".capitalize(),style: GoogleFonts.overpass(fontSize: 24, fontWeight: FontWeight.w700, color: kHomeContainerColor))
                          ),
                        ],
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24, bottom: 35, left: 24, right: 24),
                      child: Container(
                        width: 305,
                        height: 240,
                        child:ListView.builder(
                            shrinkWrap: true,
                            itemCount: contentList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ContentTextContainer(text: "${contentList[index]["text"]}".capitalize(), text2: "${contentList[index]["value"]}", icon: CupertinoIcons.wind, color: Colors.white,
                              style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 42, bottom: 36),
                child: InkWell(
                  onTap: ()  async {
                    WeatherService apiService = WeatherService();
                    await apiService.getWeatherForecast("635f83b2f7ccaef29c146a07", widget.loginResponseModel.token).then((value) {
                       Map<String, dynamic> map = value["DATA"] ?? {};
                       log("here map values are ${map}");
                       List<dynamic> mapList = map.values.toList();
                       log("here map values in list are ${mapList}");
                       Navigator.push(context, PageTransition(child: ForecastScreen(forecastList: mapList,), type: PageTransitionType.rightToLeft));

                    });
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => ForecastScreen()));
                  },
                  child: Container(
                    width: 220,
                    height: 64,
                    decoration: BoxDecoration(
                      color: kHomeContainerColor,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CommonTextWidget(text: "Forecast report", size: 18, wght: FontWeight.w400, colors: kViewReportContainerColor,),
                          Icon(CupertinoIcons.right_chevron , size: 12, color:kViewReportContainerColor ,)
                        ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ) ,
    );
  }
}

