import 'package:flutter/material.dart';

// Helpers
import '../../helpers/constants/app_styles.dart';
import '../../helpers/constants/app_typography.dart';
import '../../helpers/form_validator.dart';

// Widgets
import '../shared/widgets/custom_textfield.dart';
import '../shared/widgets/scrollable_column.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Text('UniPal', style: AppTypography.primary.heading34),

          Insets.gapH30,

          // ERP-Email Input
          const CustomTextField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: FormValidator.emailValidator,
          ),

          Insets.gapH10,

          // Password Input
          const CustomTextField(
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            validator: FormValidator.passwordValidator,
          ),

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
