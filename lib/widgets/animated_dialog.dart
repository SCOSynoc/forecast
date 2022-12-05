import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<Object?> showNewDialog<T>(BuildContext context,Widget Function(BuildContext, Animation , Animation ) page) {
  return showGeneralDialog(context: context, pageBuilder: page ,
      transitionDuration: Duration(milliseconds: 400),
      transitionBuilder:_buildNewTransition
  );
}

Widget _buildNewTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    ) {
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCirc,
      reverseCurve: Curves.bounceOut,
    ),
    child: child,
  );
}

