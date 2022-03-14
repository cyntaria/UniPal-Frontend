import 'package:flutter/material.dart';

// Widgets
import '../../helpers/constants/app_styles.dart';
import '../shared/widgets/scrollable_column.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ScrollableColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo

          Insets.gapH30,

          // ERP-Email Input

          Insets.gapH10,

          // Password Input

          Insets.gapH5,

          // Forgot Password Link

          Insets.gapH10,

          // Login Button

          Insets.gapH15,

          // Divider with "or"

          Insets.gapH15,

          // Signup Button
        ],
      ),
    );
  }
}
