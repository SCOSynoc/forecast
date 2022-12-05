import 'package:flutter/cupertino.dart';
import 'package:forecast/widgets/text_widgets.dart';

class CommonHead extends StatelessWidget {
  const CommonHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco,dpr_1/j72dkcqsnqdhsnksqxi9",
              width: 200,
              height: 56,
            ),
            CommonTextWidget(text: "Forecasting",wght: FontWeight.w800, size: 24,),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CommonTextWidget(text: "Enter your email address and password",wght: FontWeight.w500, size: 16,),
            )
          ]
      ),
    );
  }
}
