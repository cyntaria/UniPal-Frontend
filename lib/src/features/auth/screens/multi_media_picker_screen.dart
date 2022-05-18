import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// Routing
import '../../../config/routes/app_router.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

// Widgets
import '../../shared/widgets/custom_text_button.dart';

class MultiMediaPickerScreen extends ConsumerStatefulWidget {
  const MultiMediaPickerScreen({Key? key}) : super(key: key);

  @override
  _MultiMediaPickerScreenState createState() => _MultiMediaPickerScreenState();
}

class _MultiMediaPickerScreenState
    extends ConsumerState<MultiMediaPickerScreen> {
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

  void _returnImage() {
    AppRouter.pop(_pickedImage?.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: AppBar(
        title: const Text('MultiMedia Picker'),
        actions: [
          // Rotate Camera
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_rear_rounded),
          ),

          // Flash On/Off
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.lightbulb_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Insets.expand,

            // Preview
            GestureDetector(
              onTap: _openImagePicker,
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
                    onPressed: _returnImage,
                    disabled: _pickedImage == null,
                    gradient: AppColors.buttonGradientPurple,
                    child: Center(
                      child: Text(
                        'Save',
                        style: AppTypography.secondary.subtitle13.copyWith(
                          color: Colors.white,
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
    );
  }
}
