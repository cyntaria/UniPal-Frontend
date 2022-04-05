import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCircularLoader extends StatelessWidget {
  const CustomCircularLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitRing(
        color: Colors.white,
        size: 30,
        lineWidth: 4,
        duration: Duration(milliseconds: 1100),
      ),
    );
  }
}
