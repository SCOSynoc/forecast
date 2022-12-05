import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast/globals/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  TextWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text("${text}", style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 46.0, color: kAppPrimaryColor),);
  }
}


class InsideTextWidget extends StatelessWidget {
  InsideTextWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text("${text}", style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 20.0, color:Colors.black),);
  }
}


class InsideLiteTextWidget extends StatelessWidget {
  InsideLiteTextWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text("${text}", style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14, color:Colors.black),);
  }
}

class CommonTextWidget extends StatelessWidget {
  CommonTextWidget({Key? key, required this.text, this.wght, this.size, this.colors}) : super(key: key);
  final String text;
  final FontWeight? wght;
  final double? size;
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return Text("${text}", style: GoogleFonts.inter(fontWeight: wght, fontSize: size, color:colors),);
  }
}
