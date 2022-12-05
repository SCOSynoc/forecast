import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast/globals/global.dart';
import 'package:forecast/widgets/text_widgets.dart';

class ContentTextContainer extends StatelessWidget {
  const ContentTextContainer({
    Key? key, required this.text, required this.text2, required this.icon, this.function, required this.color, required this.style,
  }) : super(key: key);
  final String text;
  final String text2;
  final IconData icon;
  final Function()? function;
  final Color color;
  final  TextStyle style;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: 305,
        height: 24,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, size: 24, color: color,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("$text", style: style,),
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("${text2}", style: style,)
              ],
            )

          ],
        ),
      ),
    );
  }
}
