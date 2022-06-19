import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Helpers
import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/constants/lottie_assets.dart';
import '../../../helpers/extensions/context_extensions.dart';

class LottieAnimationLoader extends StatelessWidget {
  const LottieAnimationLoader({super.key});

  @override
  Widget build(BuildContext context) {
    const loaders = [
      LottieAssets.femaleWalkingLottie,
      LottieAssets.movingBusLottie,
      LottieAssets.peopleTalkingLottie,
    ];
    final i = AppUtils.randomizer().nextInt(3);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          loaders[i],
          width: context.screenWidth,
        ),
      ),
    );
  }
}
