import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// Helpers
import '../../../helpers/extensions/context_extensions.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

// Widgets
import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/custom_textfield.dart';
import '../../shared/widgets/scrollable_column.dart';

class AddEditPostScreen extends HookConsumerWidget {
  const AddEditPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postBodyController = useTextEditingController(text: '');
    final currentStudent = ref.watch(currentStudentProvider)!;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: kToolbarHeight + 5,
          title: const Text('Create post'),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Divider(
              height: 0,
              thickness: 1.2,
              color: Color(0xFFE0E0E0),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CustomTextButton.gradient(
                width: 60,
                height: 30,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
                gradient: AppColors.buttonGradientPurple,
                child: Center(
                  child: Text(
                    'POST',
                    style: AppTypography.secondary.title18.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ScrollableColumn(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          children: [
            Insets.gapH5,

            // Avatar and Name
            Row(
              children: [
                // Author Avatar
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    currentStudent.profilePictureUrl,
                  ),
                ),

                Insets.gapW10,

                // Author & Post Detals
                Text(
                  '${currentStudent.firstName} ${currentStudent.lastName}',
                  style: AppTypography.primary.body14.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Insets.gapH20,

            // Post Body Text Area
            CustomTextField(
              controller: postBodyController,
              showFocusedBorder: false,
              autofocus: true,
              multiline: true,
              textAlignVertical: TextAlignVertical.top,
              expands: true,
              height: context.screenHeight * 0.65,
              hintText: "What's on your mind?",
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO(arafaysaleem): open image picker gallery
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            Icons.add_photo_alternate_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
