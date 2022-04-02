import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

// Widgets
import '../../shared/widgets/custom_dialog.dart';
import '../../shared/widgets/scrollable_column.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _formHasData = false;
  late final formKey = GlobalKey<FormState>();

  Future<bool> _showConfirmDialog() async {
    if (_formHasData) {
      final doPop = await showDialog<bool>(
        context: context,
        barrierColor: AppColors.barrierColor,
        builder: (ctx) => const CustomDialog.confirm(
          title: 'Are you sure?',
          body: 'Do you want to go back without saving your form data?',
          trueButtonText: 'Yes',
          falseButtonText: 'No',
        ),
      );
      if (doPop == null || !doPop) return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  void _onFormChanged() {
    if (!_formHasData) _formHasData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: formKey,
          onWillPop: _showConfirmDialog,
          onChanged: _onFormChanged,
          child: const ScrollableColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Insets.gapH20,

              // Do if-else on RegistrationState

              // When Personal
              // Display Personal Details Fields

              // When University
              // Display University Details Fields

              // When Preferences
              // Display Preferences Details Fields

              // When Password
              // Display Password Details Fields
            ],
          ),
        ),
      ),
    );
  }
}
