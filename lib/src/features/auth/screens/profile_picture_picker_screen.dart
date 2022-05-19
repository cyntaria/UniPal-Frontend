import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// Providers
import '../../profile/providers/profile_provider.dart';

// Routing
import '../../../config/routes/app_router.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

// Widgets
import '../../shared/states/future_state.codegen.dart';
import '../../shared/widgets/custom_circular_loader.dart';
import '../../shared/widgets/custom_dialog.dart';
import '../../shared/widgets/custom_text_button.dart';

class ProfilePicturePickerScreen extends ConsumerStatefulWidget {
  final void Function(String filePath) onSaveCallback;

  const ProfilePicturePickerScreen({
    super.key,
    required this.onSaveCallback,
  });

  @override
  _MultiMediaPickerScreenState createState() => _MultiMediaPickerScreenState();
}

class _MultiMediaPickerScreenState
    extends ConsumerState<ProfilePicturePickerScreen> {
  late final ImagePicker _imagePicker;
  XFile? _pickedImage;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _openImagePicker() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );
    setState(() {
      _pickedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final studentsFuture = ref.watch(profileProvider);

    ref.listen<FutureState<String>>(
      profileProvider,
      (_, state) => state.whenOrNull(
        data: (message) => CustomDialog.showAlertDialog(
          context: context,
          dialogTitle: 'Update Profile Picture Success',
          reason: message,
          buttonText: 'Okay',
          onButtonPressed: AppRouter.pop,
        ),
        failed: (reason) => CustomDialog.showAlertDialog(
          context: context,
          reason: reason,
          dialogTitle: 'Update Profile Picture Failed',
          buttonText: 'Retry',
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        return await studentsFuture.maybeWhen(
          loading: () => false,
          orElse: () => true,
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
        appBar: AppBar(
          title: const Text('MultiMedia Picker'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Insets.expand,

              // Preview
              GestureDetector(
                onTap: studentsFuture.maybeWhen(
                  loading: () => null,
                  orElse: () => _openImagePicker,
                ),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: Shadows.universal,
                  ),
                  padding: const EdgeInsets.all(3),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: _pickedImage != null
                        ? FileImage(
                            File(_pickedImage!.path),
                          )
                        : null,
                    child: _pickedImage == null
                        ? const Icon(
                            Icons.person_rounded,
                            color: AppColors.primaryColor,
                            size: 120,
                          )
                        : null,
                  ),
                ),
              ),

              Insets.expand,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextButton.outlined(
                      disabled: studentsFuture.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      ),
                      onPressed: AppRouter.pop,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1.2,
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: AppTypography.secondary.subtitle13.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Insets.gapW15,

                  // Primary
                  Expanded(
                    child: CustomTextButton.gradient(
                      disabled: studentsFuture.maybeWhen(
                        loading: () => true,
                        orElse: () => _pickedImage == null,
                      ),
                      onPressed: () =>
                          widget.onSaveCallback(_pickedImage!.path),
                      gradient: AppColors.buttonGradientPurple,
                      child: studentsFuture.maybeWhen(
                        loading: () => const CustomCircularLoader(),
                        orElse: () => Center(
                          child: Text(
                            'Save',
                            style: AppTypography.secondary.subtitle13.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Insets.bottomInsets,
            ],
          ),
        ),
      ),
    );
  }
}
