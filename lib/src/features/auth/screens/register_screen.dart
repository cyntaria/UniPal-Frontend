import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/register_form_provider.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';

// Routing
import '../../../config/routes/app_router.dart';

// Widgets
import '../../shared/widgets/custom_dialog.dart';
import '../widgets/password_detail_fields.dart';
import '../widgets/personal_detail_fields.dart';
import '../widgets/university_detail_fields.dart';

class RegisterScreen extends StatefulHookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
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
    final registrationState = ref.watch(registerFormProvider);
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: AppBar(
        title: Text(
          registrationState.when<String>(
            personal: () => 'Personal Details',
            university: () => 'University Details',
            password: () => 'Password Details',
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.adaptive.arrow_back_rounded),
          onPressed: () {
            registrationState.maybeWhen(
              personal: AppRouter.pop,
              orElse: () {
                ref
                    .read(registerFormProvider.notifier)
                    .moveToPreviousRegistration();
              },
            );
          },
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: formKey,
            onWillPop: _showConfirmDialog,
            onChanged: _onFormChanged,
            child: registrationState.when(
              personal: () => PersonalDetailFields(formKey: formKey),
              university: () => UniversityDetailFields(formKey: formKey),
              password: () => PasswordDetailFields(formKey: formKey),
            ),
          ),
        ),
      ),
    );
  }
}
