import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';
import '../../helpers/constants/app_styles.dart';
import '../../helpers/constants/app_typography.dart';

// Widgets
import '../shared/widgets/custom_dialog.dart';
import '../shared/widgets/custom_text_button.dart';
import '../shared/widgets/custom_textfield.dart';
import '../shared/widgets/scrollable_column.dart';
import './filter_chips_list.dart';

const hobbies = [
  'Cricket',
  'Cycling',
  'Reading',
  'Boxing',
  'Painting',
  'Clubbing',
  'Dancing'
];
const interests = [
  'Netflix',
  'Literature',
  'Art',
  'Fitness',
  'Education',
  'Social Wellfare'
];

class PreferenceDetailFields extends StatefulHookWidget {
  const PreferenceDetailFields({Key? key}) : super(key: key);

  @override
  _PreferenceDetailFieldsState createState() => _PreferenceDetailFieldsState();
}

class _PreferenceDetailFieldsState extends State<PreferenceDetailFields> {
  bool _formHasData = false;
  late final formKey = GlobalKey<FormState>();

  Future<bool> _showConfirmDialog() async {
    if (_formHasData) {
      final doPop = await showDialog<bool>(
        context: context,
        barrierColor: AppColors.barrierColor,
        builder: (ctx) => const CustomDialog.confirm(
          title: 'Are you sure?',
          body: 'Do you want to go back without saving your preferences?',
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
    final favHangoutSpotController = useTextEditingController(text: '');
    final favActivityController = useTextEditingController(text: '');

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: formKey,
          onWillPop: _showConfirmDialog,
          onChanged: _onFormChanged,
          child: ScrollableColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Insets.gapH20,

              // Hobbies Label
              Text(
                'Hobbies',
                style: AppTypography.primary.subHeading16,
              ),

              Insets.gapH5,

              // Hobby Chips
              FilterChipsList(
                filters: hobbies,
                isSelected: (hobby) => hobbies.contains(hobby),
                onSelected: (hobby) {
                  // Add to selected hobbies provider
                },
              ),

              Insets.gapH20,

              // Interests Label
              Text(
                'Interests',
                style: AppTypography.primary.subHeading16,
              ),

              Insets.gapH5,

              // Interest Chips
              FilterChipsList(
                filters: interests,
                isSelected: (interest) => interests.contains(interest),
                onSelected: (interest) {
                  // Add to selected interests provider
                },
              ),

              Insets.gapH20,

              // Favorite Hangout Spot
              CustomTextField(
                controller: favHangoutSpotController,
                floatingText: 'Favorite Campus Spot',
                hintText: 'Type in your fav. hangout spot',
                keyboardType: TextInputType.text,
                maxLength: 45,
                textInputAction: TextInputAction.next,
              ),

              Insets.gapH25,

              // Favorite Activity
              CustomTextField(
                controller: favActivityController,
                floatingText: 'Favorite Campus Activity',
                hintText: 'Type in your fav. campus activity',
                keyboardType: TextInputType.text,
                maxLength: 45,
                textInputAction: TextInputAction.done,
              ),

              Insets.expand,

              // Confirm Details Button
              CustomTextButton.gradient(
                width: double.infinity,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    // ref.read(authProvider.notifier).register(
                    //       email: email,
                    //       password: password,
                    //       fullName: fullName,
                    //       address: address,
                    //       contact: contact,
                    //     );
                  }
                },
                gradient: AppColors.buttonGradientPurple,
                child: Consumer(
                  builder: (context, ref, child) {
                    return child!;
                    // final authState = ref.watch(authProvider);
                    // return authState.maybeWhen(
                    //   authenticating: () => const Center(
                    //     child: SpinKitRing(
                    //       color: Colors.white,
                    //       size: 30,
                    //       lineWidth: 4,
                    //       duration: Duration(milliseconds: 1100),
                    //     ),
                    //   ),
                    //   orElse: () => child!,
                    // );
                  },
                  child: Center(
                    child: Text(
                      'UPDATE',
                      style: AppTypography.secondary.body16.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
