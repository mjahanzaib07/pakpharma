

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  AnimationController? animateController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Bounce(
        infinite: true,
        duration: const Duration(seconds: 2),
        child: Image.asset(
          "assets/images/logo.png",
          // width: 300,
          height: 80,
        ),
        // duration: Duration(seconds: 5),
        //(optional, but mandatory if you use manualTrigger:true) This callback exposes the AnimationController used for the selected animation. Then you can call animationController.forward() to trigger the animation wherever you like manually.
        controller: (controller) => animateController = controller,

        //  child: Image.asset('assets'),
      ),
    );

  }
}
