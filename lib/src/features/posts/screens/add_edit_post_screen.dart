import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../auth/providers/auth_provider.dart';
import '../providers/posts_provider.dart';

// States
import '../../shared/states/future_state.codegen.dart';

// Helpers
import '../../../helpers/extensions/context_extensions.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

// Routing
import '../../../config/routes/app_router.dart';

// Widgets
import '../../shared/widgets/custom_circular_loader.dart';
import '../../shared/widgets/custom_network_image.dart';
import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/custom_textfield.dart';
import '../../shared/widgets/scrollable_column.dart';

class AddEditPostScreen extends HookConsumerWidget {
  const AddEditPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final postBodyController = useTextEditingController(text: '');
    final currentStudent = ref.watch(currentStudentProvider)!;

    ref.listen<FutureState<String>>(
      postsProvider,
      (_, next) => next.whenOrNull(
        data: (message) async {
          await AppRouter.pop();
          AppUtils.showFlushBar(
            context: context,
            message: message,
            icon: Icons.check_circle_rounded,
            iconColor: Colors.green,
          );
          return ref.refresh(postsFeedFutureProvider);
        },
        failed: (reason) async {
          await AppRouter.pop();
          return AppUtils.showFlushBar(
            context: context,
            message: reason,
          );
        },
      ),
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: formKey,
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
                padding: const EdgeInsets.fromLTRB(0, 13, 8, 13),
                child: CustomTextButton.gradient(
                  width: 60,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      ref
                          .read(postsProvider.notifier)
                          .addPost(body: postBodyController.text);
                    }
                  },
                  gradient: AppColors.buttonGradientPurple,
                  child: Consumer(
                    builder: (_, ref, child) {
                      final state = ref.watch(postsProvider);
                      return state.maybeWhen(
                        loading: () => const CustomCircularLoader(
                          color: Colors.white,
                          size: 20,
                          lineWidth: 3.5,
                        ),
                        orElse: () => child!,
                      );
                    },
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
                  CustomNetworkImage(
                    height: 40,
                    width: 40,
                    shape: BoxShape.circle,
                    imageUrl: currentStudent.profilePictureUrl,
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
                height: context.screenHeight * 0.61,
                hintText: "What's on your mind?",
                validator: (body) {
                  if (body == null || body.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
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
      ),
    );
  }
}
