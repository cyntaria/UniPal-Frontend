import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_assets.dart';
import '../../../../helpers/constants/app_styles.dart';

class SendHangoutFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const SendHangoutFAB({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: onPressed,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Hangout Icon
            Image.asset(
              AppAssets.hangoutIcon,
              height: 22,
              width: 22,
            ),

            Insets.gapW10,

            // Label
            const Text(
              'Request Hangout',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
