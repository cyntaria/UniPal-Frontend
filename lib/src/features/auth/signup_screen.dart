import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';
import '../../helpers/constants/app_styles.dart';
import '../../helpers/constants/app_typography.dart';
import '../../helpers/form_validator.dart';

// Routing
import '../../config/routes/app_router.dart';
import '../../config/routes/routes.dart';

// Widgets
import '../shared/widgets/custom_dialog.dart';
import '../shared/widgets/custom_text_button.dart';
import '../shared/widgets/custom_textfield.dart';
import '../shared/widgets/scrollable_column.dart';

class SignupScreen extends StatefulHookWidget {
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

  void onFormChanged() {
    if (!_formHasData) _formHasData = true;
  }

  @override
  Widget build(BuildContext context) {
    // final emailController = useTextEditingController(text: '');
    // final passwordController = useTextEditingController(text: '');
    // final cPasswordController = useTextEditingController(text: '');
    // final fullNameController = useTextEditingController(text: '');
    // final addressController = useTextEditingController(text: '');
    // final contactController = useTextEditingController(text: '');

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: formKey,
          onWillPop: _showConfirmDialog,
          onChanged: onFormChanged,
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
