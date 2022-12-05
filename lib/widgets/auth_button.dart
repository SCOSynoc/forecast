import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast/widgets/text_widgets.dart';

import '../globals/constants.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key, required this.width, required this.pressed, required this.color, required this.text,
  }) : super(key: key);
  final double width;
  final Function() pressed;
  final Color color;
  final String text;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15)
      ),
      child: MaterialButton(
          height: 60.0,
          child: CommonTextWidget(text: text, wght: FontWeight.w400, size: 18,colors: Colors.white,),
          onPressed: pressed),
    );
  }
}
